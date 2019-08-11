defmodule Caipirinha.Repo.Migrations.City do
  use Ecto.Migration

  def change do
    create table("cities") do
      add :name, :string, size: 50
      add :state_id, references(:states)
    end
  end
end
