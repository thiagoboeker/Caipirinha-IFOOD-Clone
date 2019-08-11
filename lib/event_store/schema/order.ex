defmodule EventStore.Schema.Orders do
    use Ecto.Schema
    alias EventStore.Schema.SelectedItems
    alias EventStore.Schema.Demands
    alias EventStore.Schema.Feedback
    alias EventStore.Schema.Closes
    alias EventStore.Schema.Payments
    schema "orders" do
        field :uid, :string
        field :business_id, :integer
        field :user_id, :integer
        field :open, :boolean, virtual: true
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        has_many :items, SelectedItems, foreign_key: :order_id
        has_one :demand, Demands, foreign_key: :order_id
        has_one :feedback, Feedback, foreign_key: :order_id
        has_one :close, Closes, foreign_key: :order_id
        has_one :payment, Payments, foreign_key: :order_id
    end
end