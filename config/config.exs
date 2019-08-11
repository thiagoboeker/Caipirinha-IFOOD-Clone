use Mix.Config

config :caipirinha, ecto_repos: [Caipirinha.Repo]
config :caipirinha, Caipirinha.Repo,
        database: "caipirinha",
        username: "root",
        password: "kusanagi2k",
        hostname: "127.0.0.1",
        migration_timestamps: [type: :utc_datetime_usec]

# config :caipirinha, Caipirinha.Repo,
#         adapter: Ecto.Adapters.Postgres,
#         pool_size: 10,
#         migration_lock: nil,
#         queue_target: 5000