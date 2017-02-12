defmodule ElixirLightningTalks.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias ElixirLightningTalks.Repo
  alias ElixirLightningTalks.Alchemist

  def for_token(alchemist = %Alchemist{}), do: { :ok, "Alchemist:#{alchemist.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("Alchemist:" <> id), do: { :ok, Repo.get(Alchemist, id) }
  def from_token(_), do: {:error, "Unkown resource type" }
end
