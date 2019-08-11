defmodule EventStore.System.Business do
    use Plug.Router
    require EventStore.System.Http, as: Http
    alias EventStore.System.Server
    
    plug :match
    plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
    plug :dispatch

    post "/event/business/attend_demand" do
        Server.process_demand(conn.body_params)
        |> Http.process_response(
            fields: [:id, :action, :desc, :demand_id, :inserted_at, :updated_at],
            module: Http
        )
    end
end