defmodule Caipirinha.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, size: 100
      add :uid, :string, size: 255
      add :cpf, :string, size: 50
      add :phone, :string, size: 50
      add :logradouro, :string, size: 100
      add :numero, :integer
      add :district_id, references(:districts)
      timestamps()
    end
  end
end
