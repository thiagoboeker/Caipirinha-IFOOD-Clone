defmodule Caipirinha.Repo.Migrations.Business do
  use Ecto.Migration

  def change do
    create table("business") do
      add :name, :string, size: 100
      add :cnpj, :string, size: 100
      add :phone, :string, size: 50
      add :logradouro, :string, size: 100
      add :numero, :integer
      add :district_id, references(:districts)
      timestamps()
    end
  end
end
