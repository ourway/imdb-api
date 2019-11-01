defmodule OpenMovieApi.Db do
  @moduledoc """
  database operations
  """
  alias OpenMovieApi.Models

  def add_principal(line) do
    model = process_principal_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok =
          :mnesia.write({Principals, model.nconst, model.category, model.job, model.characters})
      end)

    line
  end

  def add_crew(line) do
    model = process_crew_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok = :mnesia.write({Crew, model.tconst, model.directors, model.writers})
      end)

    line
  end

  def add_aka(line) do
    model = process_aka_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok = :mnesia.write({Akas, model.tconst, model.region, model.region})
      end)

    line
  end

  def add_episode(line) do
    model = process_episode_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok = :mnesia.write({Episodes, model.tconst, model.parent, model.season, model.episode})
      end)

    line
  end

  def add_rating(line) do
    model = process_rating_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok = :mnesia.write({Ratings, model.tconst, model.rate, model.votes})
      end)

    line
  end

  def add_basic(line) do
    model = process_basic_tsv_line(line)

    {:atomic, :ok} =
      :mnesia.sync_transaction(fn ->
        :ok =
          :mnesia.write(
            {Basics, model.tconst, model.type, model.title, model.isAdult, model.startYear,
             model.endYear, model.runtime, model.genres}
          )
      end)

    line
  end

  def process_principal_tsv_line(lineList) do
    [_, _, nconst, category, job, characters] = lineList

    %Models.Principal{
      nconst: nconst,
      category: category,
      job:
        case job do
          "\\N" -> nil
          x -> x
        end,
      characters:
        case characters do
          "\\N" -> nil
          x -> x |> Jason.decode!()
        end
    }
  end

  def process_aka_tsv_line(lineList) do
    [tconst, _, _, region, lang, _, _, _] = lineList

    %Models.Aka{
      tconst: tconst,
      region:
        case region do
          "\\N" -> nil
          x -> x
        end,
      lang:
        case lang do
          "\\N" -> nil
          x -> x
        end
    }
  end

  def process_episode_tsv_line(lineList) do
    [tconst, parent, season, episode] = lineList

    %Models.Episode{
      tconst: tconst,
      parent: parent,
      season:
        case season do
          "\\N" -> -1
          n -> n |> String.to_integer()
        end,
      episode:
        case episode do
          "\\N" -> -1
          n -> n |> String.to_integer()
        end
    }
  end

  def process_crew_tsv_line(lineList) do
    [tconst, directors, writers] = lineList

    %Models.Crew{
      tconst: tconst,
      directors:
        case directors do
          "\\N" -> []
          l -> l |> String.split(",", trim: true)
        end,
      writers:
        case writers do
          "\\N" -> []
          l -> l |> String.split(",", trim: true)
        end
    }
  end

  def process_rating_tsv_line(lineList) do
    [tconst, rate, votes] = lineList

    %Models.Rating{
      tconst: tconst,
      rate: rate |> String.to_float(),
      votes: votes |> String.to_integer()
    }
  end

  def process_basic_tsv_line(lineList) do
    [tconst, type, title, _, isAdult, startYear, endYear, runtime, genres] = lineList

    %Models.Basic{
      tconst: tconst,
      type: type,
      title: title,
      isAdult:
        case isAdult |> String.to_integer() do
          0 -> false
          1 -> true
        end,
      startYear:
        case startYear do
          "\\N" -> -1
          n -> n |> String.to_integer()
        end,
      endYear:
        case endYear do
          "\\N" -> -1
          n -> n |> String.to_integer()
        end,
      runtime:
        case runtime do
          "\\N" -> -1
          "" -> -1
          n -> n |> String.to_integer()
        end,
      genres: genres |> String.split(",", trim: true)
    }
  end
end
