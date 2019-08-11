defmodule Caipirinha.Repo.Migrations.SelectedItems do
  use Ecto.Migration

  def change do
    create table("selected_items") do
      add :order_id, references(:orders)
      add :item_id, references(:items)
      add :action, :string, size: 50
      timestamps()
    end
  end
end
