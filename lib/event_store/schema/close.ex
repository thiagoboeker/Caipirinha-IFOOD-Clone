defmodule EventStore.Schema.Closes do
    use Ecto.Schema
    alias EventStore.Schema.Orders
    schema "close" do
        field :reason, :string
        field :hash, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        belongs_to :order, Orders, foreign_key: :order_id
    end
end