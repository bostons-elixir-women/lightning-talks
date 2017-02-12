defmodule ElixirLightningTalks.Router do
  use ElixirLightningTalks.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/api", ElixirLightningTalks do
    pipe_through :api
    post "/register", RegistrationController, :create
    resources "/alchemists", AlchemistController, except: [:new, :edit]
    resources "/session", SessionController, only: [:index]
  end
end
