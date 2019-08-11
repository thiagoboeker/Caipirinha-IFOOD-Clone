defmodule EventStore.Changesets.User do
    import Ecto.Changeset
    alias EventStore.Schema.SelectedItems
    alias EventStore.Schema.Holding
    alias Caipirinha.Repo
    
    @require_fields [:name, :uid, :cpf, :phone, :logradouro, :numero, :district_id]
    @update_fields [:id, :name, :phone, :logradouro, :numero, :district_id]
    
    def new_changeset(user, params \\ %{}) do
        user
        |> cast(params, @require_fields)
        |> validate_required(@require_fields)
        |> validate_number(:numero, greater_than: 0)
    end

    def update_changeset(user, params \\ %{}) do
        user
        |> cast(params, @update_fields)
        |> validate_number(:numero, greater_than: 0)
    end

    def add_item(params \\ %{}) do
        %SelectedItems{inserted_at: Repo.now(), updated_at: Repo.now()}
        |> cast(params, [:order_id, :item_id, :action])
        |> validate_inclusion(:action, ["INSERTED", "REMOVED"])
    end

    def holding(params \\ %{}) do
        %Holding{inserted_at: Repo.now(), updated_at: Repo.now()}
        |> cast(params, [:demand_id, :mode])
        |> validate_required([:demand_id, :mode])
        |> validate_inclusion(:mode, ["HOLD", "DEBIT", "CREDIT"])
    end
end