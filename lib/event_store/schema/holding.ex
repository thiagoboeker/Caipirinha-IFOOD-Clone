defmodule EventStore.Schema.Holding do
    use Ecto.Schema
    alias EventStore.Schema.Demands
    schema "holding" do
        field :mode, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        belongs_to :demand, Demands, foreign_key: :demand_id
    end
end