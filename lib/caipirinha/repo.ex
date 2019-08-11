defmodule Caipirinha.Repo do
    use Ecto.Repo,
        otp_app: :caipirinha,
        adapter: Ecto.Adapters.MyXQL
    
    def now() do
        {:ok, dt} = DateTime.now("Etc/UTC")
        DateTime.truncate(dt, :second)
    end
end 