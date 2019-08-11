defmodule EventStore.Schema.Districts do
    use Ecto.Schema
    schema "districts" do
        field :name, :string
        field :city_id, :integer
    end
end