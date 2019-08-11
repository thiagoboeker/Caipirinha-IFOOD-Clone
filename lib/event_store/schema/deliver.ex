defmodule EventStore.Schema.Delivers do
    use Ecto.Schema
    schema "deliver" do
        field :payment_id, :integer
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
    end
end