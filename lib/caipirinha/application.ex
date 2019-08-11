defmodule Caipirinha.Application do
  use Application
  alias EventStore.System.Dispatcher
  def start(_type, _args) do
    children = [
      {Caipirinha.Repo, []},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: EventStore.System.Routes,
        options: [
          dispatch: Dispatcher.dispatch(),
          port: 9000
        ]
      ),
      {EventStore.System.Server, []}
    ]
    opts = [strategy: :one_for_one, name: Caipirinha.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
