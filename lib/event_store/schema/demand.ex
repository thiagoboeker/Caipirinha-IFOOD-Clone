defmodule EventStore.Schema.Demands do
    use Ecto.Schema
    alias EventStore.Schema.Orders
    schema "demands" do
        field :order_id, :integer
        field :business_id, :integer
        field :status, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        belongs_to :orders, Orders
    end
end