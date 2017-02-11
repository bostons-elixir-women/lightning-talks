defmodule ElixirLightningTalks.Repo.Migrations.CreateAlchemist do
  use Ecto.Migration

  def change do
    create table(:alchemists) do
      add :name, :string
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
