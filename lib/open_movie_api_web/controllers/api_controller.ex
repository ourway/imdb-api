defmodule OpenMovieApiWeb.APIs do
  @moduledoc """
    This module fetches data from mnesia database.

  """

  alias OpenMovieApi.Db

  use OpenMovieApiWeb, :controller

  def ping(conn, _params) do
    conn |> json(%{message: :pong})
  end

  def info(conn, %{"tconst" => tconst}) do
    :mnesia.wait_for_tables([Basics, Ratings], 60_000)
    basic_data = tconst |> Db.get_basic()
    rating_data = tconst |> Db.get_rating()

    data = basic_data |> Map.put(:id, tconst)
    data = data |> Map.put(:rate, rating_data.rate)
    data = data |> Map.put(:votes, rating_data.votes)

    conn |> json(data)
  end
end
