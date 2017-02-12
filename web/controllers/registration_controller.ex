defmodule ElixirLightningTalks.RegistrationController do
  use ElixirLightningTalks.Web, :controller

  alias ElixirLightningTalks.Alchemist

  def create(conn, %{"data" => %{"type" => "alchemist",
    "attributes" => %{"name" => name,
    "email" => email,
    "password" => password,
    "password_confirmation" => password_confirmation}}}) do

    changeset = Alchemist.changeset %Alchemist{}, %{name: name,
      email: email,
      password_confirmation: password_confirmation,
      password: password
    }

    case Repo.insert changeset do
      {:ok, alchemist} ->
        conn
        |> put_status(:created)
        |> render(ElixirLightningTalks.AlchemistView, "show.json", alchemist: alchemist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElixirLightningTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
