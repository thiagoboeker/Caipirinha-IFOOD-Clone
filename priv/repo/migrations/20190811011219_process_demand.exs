defmodule Caipirinha.Repo.Migrations.ProcessDemand do
  use Ecto.Migration

  def change do
    create table("process_demand") do
      add :action, :string
      add :desc, :string
      add :demand_id, references(:demands)
      timestamps()
    end
  end
end
