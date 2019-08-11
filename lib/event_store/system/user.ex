defmodule EventStore.System.User do
    use Plug.Router
    alias EventStore.Changesets.User
    alias Caipirinha.Repo
    require EventStore.System.Http, as: Http

    plug :match
    plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
    plug :dispatch
    post "/event/user/holding" do
        User.holding(conn.params)
        |> Repo.insert()
        |> Http.process_response(
            fields: [:id, :demand_id, :mode, :inserted_at, :updated_],
            module: Http
        )
    end
end