defmodule OpenMovieApi.Commands do
  @moduledoc """
  commands to run with mix or in terminal
  """
  alias OpenMovieApi.Helpers
  alias OpenMovieApi.Db

  @doc """
  adds basics to db
  """
  def process_basics do
    "data/title.basics.tsv" |> Helpers.read_tsv(Db, :add_basic)
  end

  def process_ratings do
    "data/title.ratings.tsv" |> Helpers.read_tsv(Db, :add_rating)
  end

  def process_episodes do
    "data/title.episode.tsv" |> Helpers.read_tsv(Db, :add_episode)
  end

  def process_akas do
    "data/title.akas.tsv" |> Helpers.read_tsv(Db, :add_aka)
  end

  def process_crew do
    "data/title.crew.tsv" |> Helpers.read_tsv(Db, :add_crew)
  end

  def process_principal do
    "data/title.principals.tsv" |> Helpers.read_tsv(Db, :add_principal)
  end
end
