defmodule EventStore.Schema.Items do
    use Ecto.Schema
    schema "items" do
        field :name, :string
        field :uid, :string
        field :price, :integer
        field :business_id, :integer
        field :inserted_at, :utc_datetime
        field :update_at, :utc_datetime
    end
end