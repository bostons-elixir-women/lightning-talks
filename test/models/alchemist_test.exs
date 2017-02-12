defmodule ElixirLightningTalks.AlchemistTest do
  use ElixirLightningTalks.ModelCase

  alias ElixirLightningTalks.Alchemist

  @valid_attrs %{email: "me@example.com",
  name: "Sample Person",
  password: "abcde12345",
  password_confirmation: "abcde12345"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Alchemist.changeset(%Alchemist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Alchemist.changeset(%Alchemist{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "mis-matched password_confirmation doesn't work" do
    changeset = Alchemist.changeset(%Alchemist{}, %{email: "jo@example.com",
      password: "1lh2bj1rjbk2",
      password_confirmation: "b1bk23jkn12"})
    refute changeset.valid?
  end

  test "missing password_confirmation doesn't work" do
    changeset = Alchemist.changeset(%Alchemist{}, %{email: "jo@example.com",
      password: "1lh2bj1rjbk2"})
    refute changeset.valid?
  end

  test "short password doesn't work" do
    changeset = Alchemist.changeset(%Alchemist{}, %{email: "jo@example.com",
      password: "1lh2d",
      password_confirmation: "1lh2d"})
    refute changeset.valid?
  end
end
