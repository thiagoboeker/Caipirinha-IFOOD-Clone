defmodule EventStore.Schema.City do
    use Ecto.Schema
    schema "cities" do
        field :name, :string
        field :state_id, :integer
    end
end