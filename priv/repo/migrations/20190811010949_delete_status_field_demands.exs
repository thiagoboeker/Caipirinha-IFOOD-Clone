defmodule Caipirinha.Repo.Migrations.DeleteStatusFieldDemands do
  use Ecto.Migration

  def change do
    alter table("demands") do
      remove :status
    end
  end
end
