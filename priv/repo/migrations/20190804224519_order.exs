defmodule Caipirinha.Repo.Migrations.Order do
  use Ecto.Migration

  def change do
    create table("orders") do
      add :uid, :string, size: 255
      add :business_id, references(:business)
      add :user_id, references(:users)
      timestamps()
    end
  end
end
