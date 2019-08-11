defmodule Caipirinha.Repo.Migrations.Holding do
  use Ecto.Migration

  def change do
    create table("holding") do
      add :mode, :string
      add :demand_id, references(:demands)
      timestamps()
    end
  end
end
