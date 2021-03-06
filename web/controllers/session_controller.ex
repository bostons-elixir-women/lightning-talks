defmodule ElixirLightningTalks.SessionController do
  use ElixirLightningTalks.Web, :controller # use - bring external functionality into current context

  import Ecto.Query, only: [where: 2] # import functions from module... where > Ecto.Query.where
  import Comeonin.Bcrypt
  import Logger

  alias ElixirLightningTalks.Alchemist # shorten module reference to Alchemist (can also specify shorter name w/ alias)

  # action(conn, map of desired params -- can also be _params to allow anything)
  def create(conn, %{"grant_type" => "password",
  	"email" => email,
  	"password" => password}) do

    try do
    	## Handle a user login
      alchemist = Alchemist
      |> where(email: ^email)
      |> Repo.one! # Fetches single result, ! raises error if none found
      cond do # akin to else if clauses... stops at first evaluation of true
        checkpw(password, alchemist.encrypted_password) ->
          # Successful login
          Logger.info "Email " <> email <> " just logged in"
          # Encode a JWT
          { :ok, jwt, _} = Guardian.encode_and_sign(alchemist, :token)
          conn
          |> json(%{access_token: jwt}) # Return token to the client

        true ->
          # Unsuccessful login
          Logger.warn "Email " <> email <> " just failed to login"
          conn
          |> put_status(401)
          |> render(ElixirLightningTalks.ErrorView, "401.json") # 401
      end
    rescue
      e ->
        IO.inspect e # Print error to console
        Logger.error "Unexpected error while attempting to login email " <> email
        conn
        |> put_status(401)
        |> render(ElixirLightningTalks.ErrorView, "401.json")
    end
  end

end
