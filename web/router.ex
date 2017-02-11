defmodule ElixirLightningTalks.Router do
  use ElixirLightningTalks.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", ElixirLightningTalks do
    pipe_through :api
    resources "/alchemists", AlchemistController, except: [:new, :edit]
  end
end
