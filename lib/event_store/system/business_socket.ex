defmodule EventStore.System.BusinessSocket do
    @behaviour :cowboy_websocket
    alias EventStore.System.Server
    alias Caipirinha.Repo
    alias EventStore.Schema.Business
    
    def init(request, _state) do
        {:cowboy_websocket, request, %{identity: %{peer: request.peer, pid: request.pid, ready: false}}}
    end

    def websocket_init(state) do
        {:ok, state}
    end

    def websocket_handle({:text, json}, state) do
        {resp, current} = Poison.decode!(json)
                            |> authenticate(state)
                            |> register_with_server()
        {:reply, {:text, resp}, current}
    end

    def websocket_info({:demand, demand}, state) do
        {:reply, {:text, demand}, state}
    end
    
    defp ok(msg: msg, state: state), do: { Poison.encode!(%{success: true, msg: msg}), state }
    defp error(msg: msg, state: state), do: { Poison.encode!(%{success: false, msg: msg}), state }

    defp authenticate(payload, state) do
        business = Repo.get_by(Business, [uid: payload["uid"]])
        case business do
            nil -> {:error, "USER NOT FOUND", state}
            _ -> 
                cond do
                    business.uid == payload["uid"] ->
                        ready = %{state | identity: Map.put(state.identity, :ready, true)}
                        with_business = %{state | identity: Map.put(ready.identity, :id, business.id)}
                        {:ok, "OK", with_business}
                    true -> {:error, "Error Authenticating", state}
                end
        end 
    end

    defp register_with_server(state) do
        with {:ok, _, current} <- state do
            case current.identity.ready do
                true -> 
                    :ok = Server.business_connect(current.identity)
                    ok(msg: "Registered Successfully", state: current)
                _ ->    error(msg: "Error registering" , state: current)
            end
        else
            { :error, msg, current } -> error(msg: msg, state: current)
        end
    end
end