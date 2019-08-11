defmodule EventStore.Schema.Users do
    use Ecto.Schema
    alias EventStore.Schema.Orders
    schema "users" do
        field :name, :string
        field :uid, :string
        field :cpf, :string
        field :phone, :string
        field :logradouro, :string
        field :numero, :integer
        field :district_id, :integer
        field :inserted_at, :utc_datetime
        field :updated_at, :utc_datetime
        has_many :orders, Orders, foreign_key: :user_id
    end
end