defmodule ElixirLightningTalks.Repo.Migrations.AddUserIndex do
  use Ecto.Migration

  def change do
    create index(:alchemists, [:email], unique: true)
  end
end
