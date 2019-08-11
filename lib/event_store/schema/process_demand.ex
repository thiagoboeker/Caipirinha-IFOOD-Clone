defmodule EventStore.Schema.ProcessDemands do
    use Ecto.Schema
    alias EventStore.Schema.Demands
    schema "process_demand" do
        field :desc, :string
        field :action, :string
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        belongs_to :demand, Demands, foreign_key: :demand_id
    end
end