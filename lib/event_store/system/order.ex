defmodule EventStore.System.Routes do
    alias Caipirinha.Repo
    alias EventStore.Changesets.Orders
    alias EventStore.Changesets.User
    alias EventStore.System.Server
    require EventStore.System.Http, as: Http
    use Plug.Router
    
    
    plug :match
    plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
    plug :dispatch

    post "/event/order/open" do
        Orders.new(conn.body_params)
        |> Repo.insert()
        |> Http.process_response(
            fields: [:business_id, :user_id, :id, :inserted_at, :updated_at],
            module: Http
        )
    end

    post "/event/order/select_item" do
        User.add_item(conn.body_params)
        |> Repo.insert()
        |> Http.process_response(
            fields: [:order_id, :user_id, :item_id, :action, :inserted_at, :updated_at],
            module: Http
        )
    end

    post "/event/order/close" do
        Orders.close_order(conn.body_params)
        |> Repo.insert()
        |> Http.parse_fields([:order_id, :reason, :inserted_at, :hash, :updated_at])
        |> Server.close_and_process()
        |> Http.process_response(
            fields: [:order_id, :reason, :inserted_at, :hash, :updated_at],
            module: Http
        )
    end
end 