defmodule Caipirinha.Repo.Migrations.District do
  use Ecto.Migration

  def change do
    create table("districts") do
      add :name, :string, size: 50
      add :city_id, references(:cities)
    end
  end
end
