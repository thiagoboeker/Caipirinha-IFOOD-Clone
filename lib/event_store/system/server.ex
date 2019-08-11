defmodule EventStore.System.Server do
    
    use GenServer
    alias EventStore.Changesets.Orders
    alias EventStore.Changesets.Business
    #alias EventStore.Schema.Orders
    alias Caipirinha.Repo

    def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, opts, name: :system)
    end

    @impl true
    def init(_opts) do
        state = %{
            business_connected: %{}
        }
        {:ok, state}
    end

    @impl true
    def handle_call({:close, close}, _from, state) do
        with {:ok, result} <- close do
            case result.reason do
                "COMPLETED" -> server_generate_demand(result, state)
                _ -> nil
            end
        end
        {:reply, close, state}
    end

    @impl true
    def handle_call({:process_demand, demand}, _from, state) do
        server_process_demand(demand, state)
    end

    @impl true
    def handle_call({:business_connected, conn}, _from, state) do
        new_state = %{state | business_connected: Map.put(state.business_connected, conn.id, conn.pid)}
        {:reply, :ok, new_state}
    end

    defp server_generate_demand(close, state) do
        demand = Orders.new_demand(close) |> Repo.insert()
        {:ok, payload} = demand
        case Map.fetch(state.business_connected, payload.business_id) do
            {:ok, pid} -> send pid, {:demand, Poison.encode!(payload)}
            _ -> nil
        end
        {:reply, demand, state}   
    end

    defp server_process_demand(demand, state) do
        process = Business.process_demand(demand) |> Repo.insert()
        {:reply, process, state}
    end

    def business_connect(conn) do
        GenServer.call(:system, {:business_connected, conn})
    end

    def process_demand(params \\ %{}) do
        GenServer.call(:system, {:process_demand, params})
    end

    def close_and_process(order) do
        GenServer.call(:system, {:close, order})
    end
end