defmodule ElixirLightningTalks.AlchemistController do
  use ElixirLightningTalks.Web, :controller

  alias ElixirLightningTalks.Alchemist
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    alchemists = Repo.all(Alchemist)
    render(conn, "index.json-api", data: alchemists)
  end

  def create(conn, %{"data" => data = %{"type" => "alchemist", "attributes" => _alchemist_params}}) do
    changeset = Alchemist.changeset(%Alchemist{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, alchemist} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", alchemist_path(conn, :show, alchemist))
        |> render("show.json-api", data: alchemist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alchemist = Repo.get!(Alchemist, id)
    render(conn, "show.json-api", data: alchemist)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "alchemist", "attributes" => _alchemist_params}}) do
    alchemist = Repo.get!(Alchemist, id)
    changeset = Alchemist.changeset(alchemist, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, alchemist} ->
        render(conn, "show.json-api", data: alchemist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alchemist = Repo.get!(Alchemist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(alchemist)

    send_resp(conn, :no_content, "")
  end

end
