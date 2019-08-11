defmodule EventStore.Schema.SelectedItems do
    use Ecto.Schema
    schema "selected_items" do
        field :order_id, :integer
        field :item_id, :integer
        field :action, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
    end
end