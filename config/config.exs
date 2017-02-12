# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_lightning_talks,
  ecto_repos: [ElixirLightningTalks.Repo]

# Configures the endpoint
config :elixir_lightning_talks, ElixirLightningTalks.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CIjyTudBYj11Ua4Sr/EK8ki1pDDJaDIzoC5c411ueupKsj23Rdk525rB1UXibQBi",
  render_errors: [view: ElixirLightningTalks.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElixirLightningTalks.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
  "json-api": Poison

  config :mime, :types, %{
    "application/vnd.api+json" => ["json-api"]
  }

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "ElixirLightningTalks",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: System.get_env("GUARDIAN_SECRET") || "dvuE82dhCDDBBu+YLrzFnJHWv/1rp19XMmKfedBSp01ddSrCe4f+5ojYVkSv/PQz",
  serializer: ElixirLightningTalks.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
