# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirLightningTalks.Repo.insert!(%ElixirLightningTalks.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ElixirLightningTalks.Repo
alias ElixirLightningTalks.Alchemist

[
  %Alchemist{
    name: "Example1",
    email: "example@domain.com"
  },
  %Alchemist{
    name: "Example2",
    email: "exampl@domain.com"
  }
] |> Enum.each(&Repo.insert!(&1))
