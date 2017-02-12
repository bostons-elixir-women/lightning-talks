defmodule ElixirLightningTalks.SessionController do
  use ElixirLightningTalks.Web, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "Ok"})
  end
end
