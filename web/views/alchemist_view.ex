defmodule ElixirLightningTalks.AlchemistView do
  use ElixirLightningTalks.Web, :view

  def render("index.json", %{alchemists: alchemists}) do
    %{data: render_many(alchemists, ElixirLightningTalks.AlchemistView, "alchemist.json")}
  end

  def render("show.json", %{alchemist: alchemist}) do
    %{data: render_one(alchemist, ElixirLightningTalks.AlchemistView, "alchemist.json")}
  end

  def render("alchemist.json", %{alchemist: alchemist}) do
   %{
     "type": "alchemist",
     "id": alchemist.id,
     "attributes": %{
       "email": alchemist.email
     }
   }
 end
end
