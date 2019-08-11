defmodule EventStore.Changesets.Business do

    import Ecto.Changeset
    alias EventStore.Schema.ProcessDemands
    alias Caipirinha.Repo
    
    @required_fields [:name, :cnpj, :phone, :logradouro, :numero, :district_id]
    @update_fields [:name, :phone, :logradouro, :numero, :district_id]
    
    def new(business, params \\ %{}) do
        business
        |> cast(params, @required_fields)
        |> validate_required(@required_fields)
        |> validate_number(:numero, greater_than: 0) 
    end

    def update(business, params \\ %{}) do
        business
        |> cast(params, @update_fields)
        |> validate_number(:numero, greater_than: 0)
    end

    def process_demand(params \\ %{}) do
        %ProcessDemands{inserted_at: Repo.now(), updated_at: Repo.now()}
        |> cast(params, [:action, :desc, :demand_id])
        |> validate_inclusion(:action, ["ACCEPTED", "WAITING", "PROCESSING", "DELIVERING"])
    end
end