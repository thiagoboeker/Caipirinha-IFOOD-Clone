defmodule Caipirinha.Repo.Migrations.Payment do
  use Ecto.Migration

  def change do
    create table("payments") do
      add :order_id, references("orders")
      add :user_id, references("users")
      add :business_id, references("business")
      add :demand_id, references("demands")
      add :uid, :string, size: 255
      timestamps()
    end
    create unique_index("payments", [:order_id])
  end
end
