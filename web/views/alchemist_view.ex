defmodule ElixirLightningTalks.AlchemistView do
  use ElixirLightningTalks.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :email, :encrypted_password, :inserted_at, :updated_at]
  

end
