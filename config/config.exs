# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :raven, RavenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E+/fj394EFlyo/4gCdFTfM1j+Y/G+ABTmBw62L0mEsZq6/4fz81BE4lrmU2xE+7C",
  render_errors: [view: RavenWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Raven.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
