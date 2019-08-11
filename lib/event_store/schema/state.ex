defmodule EventStore.Schema.State do
    use Ecto.Schema
    alias EventStore.Schema.City
    schema "states" do
        field :name, :string
        has_many :cities, City
    end
end