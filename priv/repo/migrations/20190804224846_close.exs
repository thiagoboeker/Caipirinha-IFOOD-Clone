defmodule Caipirinha.Repo.Migrations.Close do
  use Ecto.Migration

  def change do
    create table("close") do
      add :order_id, references("orders")
      add :reason, :string, size: 100
      timestamps()
    end
    create unique_index("close", [:order_id])
  end
end
