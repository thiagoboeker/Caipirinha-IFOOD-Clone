defmodule Caipirinha.Repo.Migrations.AddInfoColumnHolding do
  use Ecto.Migration

  def change do
    alter table("holding") do
      add :info, :string
    end
  end
end
