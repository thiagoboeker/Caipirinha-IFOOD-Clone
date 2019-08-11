defmodule EventStore.Schema.Business do
    use Ecto.Schema
    alias EventStore.Schema.Items
    schema "business" do
        field :name, :string
        field :uid, :string
        field :cnpj, :string
        field :phone, :string
        field :logradouro, :string
        field :numero, :integer
        field :district_id, :integer
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        has_many :items, Items
    end
end