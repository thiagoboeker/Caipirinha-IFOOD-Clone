defmodule Caipirinha.Repo.Migrations.Items do
  use Ecto.Migration

  def change do
    create table("items") do
      add :name, :string, size: 100
      add :uid, :string, size: 255
      add :price, :integer
      add :business_id, references(:business)
      timestamps()
    end
  end
end
