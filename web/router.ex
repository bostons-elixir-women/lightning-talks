defmodule ElixirLightningTalks.Router do
  use ElixirLightningTalks.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/api", ElixirLightningTalks do
    pipe_through :api
    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login
    resources "/alchemists", AlchemistController, except: [:new, :edit]
  end
end
