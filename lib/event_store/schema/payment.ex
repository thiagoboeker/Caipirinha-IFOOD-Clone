defmodule EventStore.Schema.Payments do
    use Ecto.Schema
    alias EventStore.Schema.Delivers
    schema "payments" do
        field :order_id, :integer
        field :user_id, :integer
        field :business_id, :integer
        field :demand_id, :integer
        field :uid, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        has_one :deliver, Delivers, foreign_key: :payment_id
    end
end