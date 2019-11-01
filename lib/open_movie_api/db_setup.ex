defmodule OpenMovieApi.DbSetup do
  @moduledoc """
    Provides functionalities needed to setup movie database in mnesia

    :mnesia setup process includes
      stopping available :mnesia applications
      creating schema
      creating tables
      starting mnesia

  """

  require Logger

  @basics_table [:tconst, :type, :title, :isAdult, :startYear, :endYear, :runtime, :genres]
  @ratings_table [:tconst, :rate, :votes]
  @akas_table [:tconst, :region, :lang]
  @episode_table [:tconst, :parent, :season, :episode]
  @crew_table [:tconst, :directors, :writers]
  @principals_table [:nconst, :category, :job, :characters]

  defp prepare do
    :mnesia.stop()
    :mnesia.delete_schema([node()])
    :mnesia.create_schema([node()])
    :mnesia.start()
  end

  defp create do
    :mnesia.create_table(Basics, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @basics_table,
      index: [:isAdult]
    ])

    :mnesia.create_table(Ratings, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @ratings_table,
      index: [:rate, :votes]
    ])

    :mnesia.create_table(Akas, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @akas_table
    ])

    :mnesia.create_table(Episodes, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @episode_table,
      index: [:parent]
    ])

    :mnesia.create_table(Crew, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @crew_table
    ])

    :mnesia.create_table(Principals, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @principals_table,
      index: [:category]
    ])
  end

  def run do
    prepare()
    create()
  end
end
