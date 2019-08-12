# Caipirinha

## Summary

This is a very honest attempt to showcase my knowledge on Elixir, I've studying Elixir for a few months now and I'm getting very confortable with it.
This project is a backend for a food delivery like app.

## The project

The project structure in the _lib/event_store_ folder:
* Changesets
* Schema
* System

### Changesets
Here goes all the logic to change the database, I've put very little on the DB and basically everything here to test the reach of the _Ecto.Changeset_ package, have to say I'm impressed by the flexibility and the power of it.

### Schema
The DB mapping to the system. With _Ecto.Schema_ I could map the DB tables to structs inside Elixir, and combined with _Ecto.Changeset_ I can pretty much do everything outside of the database.

### System
The building blocks of the system.

# Keynotes

#### WebSocket
First I have to say that work with WebSockets in Cowboy felt pretty good, the GenServer/GenStage whatever flow really keeps you going and feel so natural that makes everything nice.
```elixir
    def websocket_info({:demand, demand}, state) do
        {:reply, {:text, demand}, state}
    end
```
This callback is based on handle_info of the GenServer which is called when you send an ordinary message to the process using his PID. So every socket has a PID and this means that with this PID you can send a message trough the socket wherever on your system. This is very nice and feels very natural
```elixir
    defp server_generate_demand(close, state) do
        demand = Orders.new_demand(close) |> Repo.insert()
        {:ok, payload} = demand
        case Map.fetch(state.business_connected, payload.business_id) do
            {:ok, pid} -> send pid, {:demand, Poison.encode!(payload)}
            _ -> nil
        end
        {:reply, demand, state}   
    end
```
This example at _lib/event_store/system/server_ shows basically it. First I fetched the id of the business client which have the socket pid's then I can easily send a message from the Server to the client.
####CRUD
I'm very against the RESTify!(read it like is a spellcast in Harry Potter), so to abstract the CRUD stuff I wrote a very simple macro.
_lib/event_store/system/response.ex_
```elixir
    defmacro process_response(op, fields: fields, module: mod) do
        quote bind_quoted: [fields: fields, op: op, mod: mod] do
            op
            |> mod.parse_fields(fields)
            |> mod.case_success(fn demand -> { 200, demand } end)
            |> mod.case_failure(fn errors -> { 400, errors } end)
            |> mod.response(fn status, resp -> send_resp(var!(conn), status, Poison.encode!(resp)) end)
        end
    end
```
Pretty simple, and to use it goes like this.
```elixir
    Orders.new(conn.body_params)
    |> Repo.insert()
    |> Http.process_response(
        fields: [:business_id, :user_id, :id, :inserted_at, :updated_at],
        module: Http)
```
####Dipatcher
Elixir modularity is really amazing in my opinion, and one thing I really enjoyed is the dispatch thing. You can put your routes in one module with very clear logic to where things are going. I'm currently working with PHP and is really a pain to find files with routes that I didnt even knew existed
```elixir
  defmodule EventStore.System.Dispatcher do
    def dispatch do
        [
            {:_,[
                {"/event/order/[...]", Plug.Cowboy.Handler, {EventStore.System.Routes, []}},
                {"/event/business/[...]", Plug.Cowboy.Handler, {EventStore.System.Business, []}},
                {"/business/ws", EventStore.System.BusinessSocket, []},
                {"/event/user/[...]", Plug.Cowboy.Handler, {EventStore.System.User, []}}
            ]}
        ]
    end
  end
```
## Wrap up
This is a imcomplete project, these are the things that I'm going to add next.
- [ ] Payment
- [ ] User socket
- [ ] A beautiful UI with VueJS

