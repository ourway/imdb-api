# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :open_movie_api, OpenMovieApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qXwc3qm29ACuF+0cPvS1SQSmXdInnn3b3MZMA7HThnBtu79Bv2QuogjKheZHd/we",
  render_errors: [view: OpenMovieApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: OpenMovieApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
