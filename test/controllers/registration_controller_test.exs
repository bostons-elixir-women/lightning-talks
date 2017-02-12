defmodule ElixirLightningTalks.RegistrationControllerTest do
  use ElixirLightningTalks.ConnCase

  alias ElixirLightningTalks.Alchemist

  @valid_attrs %{
    name: "My Name",
    email: "me@example.com",
    password: "12312312gdsa",
    password_confirmation: "12312312gdsa"
  }

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{data: %{type: "alchemist",
    attributes: @valid_attrs
    }}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Alchemist, %{email: @valid_attrs[:email]})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    assert_error_sent 400, fn ->
      conn = post conn, registration_path(conn, :create), %{data: %{type: "alchemist",
        attributes: @invalid_attrs
      }}
    end
  end
end
