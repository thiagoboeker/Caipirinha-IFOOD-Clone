defmodule Caipirinha.Repo.Migrations.Feedback do
  use Ecto.Migration

  def change do
    create table("feedback") do
      add :order_id, references(:orders)
      add :rating, :integer
      add :user_id, references(:users)
      timestamps()
    end
    create unique_index("feedback", [:order_id])
  end
end
