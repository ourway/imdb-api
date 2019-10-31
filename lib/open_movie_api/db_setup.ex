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

  @basics_table [:tconst, :type, :title, :isAdult, :start, :end, :runtime, :genres]
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
    :mnesia.create_table(:basics, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @basics_table,
      index: [:isAdult]
    ])

    :mnesia.create_table(:ratings, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @ratings_table,
      index: [:rate, :votes]
    ])

    :mnesia.create_table(:akas, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @akas_table
    ])

    :mnesia.create_table(:episodes, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @episode_table,
      index: [:parent]
    ])

    :mnesia.create_table(:crew, [
      {:disc_copies, [node()]},
      {:type, :ordered_set},
      majority: true,
      attributes: @crew_table
    ])

    :mnesia.create_table(:principals, [
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
