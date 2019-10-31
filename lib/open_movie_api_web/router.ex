defmodule OpenMovieApiWeb.Router do
  use OpenMovieApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", OpenMovieApiWeb do
    pipe_through :api
  end
end
