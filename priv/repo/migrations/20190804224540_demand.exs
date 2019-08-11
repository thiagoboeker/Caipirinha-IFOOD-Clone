defmodule Caipirinha.Repo.Migrations.Demand do
  use Ecto.Migration

  def change do
    create table("demands") do
      add :order_id, references("orders")
      add :business_id, references("business")
      add :status, :integer
      timestamps()
    end

    create unique_index("demands", [:order_id])
  end
end
