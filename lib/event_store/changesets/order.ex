defmodule EventStore.Changesets.Orders do
    import Ecto.Changeset
    alias EventStore.Schema.Orders
    alias EventStore.Schema.Closes
    alias Caipirinha.Repo
    alias EventStore.System.Hash
    alias EventStore.Schema.Demands
    
    @required_fields [:uid, :business_id, :user_id, :inserted_at, :updated_at]

    def new(params \\ %{}) do
        %Orders{inserted_at: Repo.now(), updated_at: Repo.now()}
        |> cast(params, @required_fields)
        |> validate_required(@required_fields)
    end

    def new_demand(params \\ %{}) do
        %Closes{}
        |> cast(params, [:order_id, :reason])
        |> validate_inclusion(:reason, ["COMPLETED"])
        |> get_field(:order_id)
        |> (&(Repo.get(Orders, &1))).()
        |> (&(
            %Demands{
            order_id: &1.id, 
            business_id: &1.business_id, 
            inserted_at: Repo.now(),
            updated_at: Repo.now() 
        })).()
    end 

    def close_order(params \\ %{}) do
        %Closes{inserted_at: Repo.now(), updated_at: Repo.now()}
        |> cast(params, [:order_id, :reason])
        |> validate_inclusion(:reason, ["COMPLETED", "CANCELED"])
        |> unique_constraint(:order_id)
        |> put_hash()
        |> validate_change(:hash, &validate_hash/2)
    end

    def validate_hash(:hash, hash) do
        cond do
            hash == "INVALID" -> [hash: "INVALID"]
            true -> []
        end
    end

    def put_hash(close) do
        with %{order_id: order_id } <- close.changes do
            hash =  Repo.get(Orders, order_id)
                |> (&(%{order: &1, close: close})).()
                |> Hash.hash()
            put_change(close, :hash, hash)
        else
            _ -> put_change(close, :hash, "INVALID")
        end
    end
end