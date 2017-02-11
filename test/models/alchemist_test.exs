defmodule ElixirLightningTalks.AlchemistTest do
  use ElixirLightningTalks.ModelCase

  alias ElixirLightningTalks.Alchemist

  @valid_attrs %{email: "some content", encrypted_password: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Alchemist.changeset(%Alchemist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Alchemist.changeset(%Alchemist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
