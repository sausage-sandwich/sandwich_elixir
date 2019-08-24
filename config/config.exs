# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sandwich,
  ecto_repos: [Sandwich.Repo]

# Configures the endpoint
config :sandwich, Sandwich.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Lr+R7FjrUvsMbmdURb16FGaH/0Az5Zcj6cXunqE6YTxGPeKCfsj6lxRgzEgHr15Z",
  render_errors: [view: Sandwich.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sandwich.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :phoenix_slime, :use_slim_extension, true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
