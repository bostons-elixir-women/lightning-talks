defmodule ElixirLightningTalks.AlchemistControllerTest do
  use ElixirLightningTalks.ConnCase

  alias ElixirLightningTalks.Alchemist
  alias ElixirLightningTalks.Repo

  @valid_attrs %{email: "some content", encrypted_password: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, alchemist_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    alchemist = Repo.insert! %Alchemist{}
    conn = get conn, alchemist_path(conn, :show, alchemist)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{alchemist.id}"
    assert data["type"] == "alchemist"
    assert data["attributes"]["name"] == alchemist.name
    assert data["attributes"]["email"] == alchemist.email
    assert data["attributes"]["encrypted_password"] == alchemist.encrypted_password
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, alchemist_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, alchemist_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "alchemist",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Alchemist, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, alchemist_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "alchemist",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    alchemist = Repo.insert! %Alchemist{}
    conn = put conn, alchemist_path(conn, :update, alchemist), %{
      "meta" => %{},
      "data" => %{
        "type" => "alchemist",
        "id" => alchemist.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Alchemist, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    alchemist = Repo.insert! %Alchemist{}
    conn = put conn, alchemist_path(conn, :update, alchemist), %{
      "meta" => %{},
      "data" => %{
        "type" => "alchemist",
        "id" => alchemist.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    alchemist = Repo.insert! %Alchemist{}
    conn = delete conn, alchemist_path(conn, :delete, alchemist)
    assert response(conn, 204)
    refute Repo.get(Alchemist, alchemist.id)
  end

end
