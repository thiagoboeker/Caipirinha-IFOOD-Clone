defmodule Caipirinha.Repo.Migrations.AddUidBusiness do
  use Ecto.Migration

  def change do
    alter table("business") do
      add :uid, :string
    end
    create unique_index("business", [:uid])
  end
end
