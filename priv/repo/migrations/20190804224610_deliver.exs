defmodule Caipirinha.Repo.Migrations.Deliver do
  use Ecto.Migration
  def change do
    create table("deliver") do
      add :payment_id, references("payments")
      timestamps()
    end
    create unique_index("deliver", [:payment_id])
  end
end
