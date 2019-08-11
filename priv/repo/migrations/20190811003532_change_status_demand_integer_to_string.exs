defmodule Caipirinha.Repo.Migrations.ChangeStatusDemandIntegerToString do
  use Ecto.Migration

  def change do
    alter table("demands") do
      modify :status, :string
    end
  end
end
