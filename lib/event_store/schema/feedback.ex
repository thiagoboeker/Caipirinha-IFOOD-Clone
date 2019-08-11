defmodule EventStore.Schema.Feedback do
    use Ecto.Schema
    schema "feedback" do
        field :order_id, :integer
        field :rating, :integer
        field :user_id, :integer
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
    end
end