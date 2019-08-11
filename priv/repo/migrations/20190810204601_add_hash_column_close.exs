defmodule Caipirinha.Repo.Migrations.AddHashColumnClose do
  use Ecto.Migration

  def change do
    alter table("close") do
      add :hash, :string
    end
  end
end
