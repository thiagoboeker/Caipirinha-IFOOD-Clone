defmodule Caipirinha.Repo.Migrations.State do
  use Ecto.Migration

  def change do
    create table("states") do
      add :name, :string, size: 50
    end
  end
end
