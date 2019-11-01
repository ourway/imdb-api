defmodule OpenMovieApi.Db do
  @moduledoc """
  database operations
  """
  require Logger
  alias OpenMovieApi.Models
  alias OpenMovieApi.Helpers

  def record_data(models, f, total) do
    last_const = models |> List.last() |> Map.get(:tconst)

    last =
      case last_const do
        nil ->
          models |> List.last() |> Map.get(:nconst)

        x ->
          x
      end

    last_id = last |> Helpers.get_id()
    progress = last_id * 100 / total
    Logger.debug(fn -> "#{progress}% completed. #{last_id}" end)
    :mnesia.activity(:transaction, f, [], :mnesia_frag)
  end

  def add_principal(lines, total) do
    models =
      for line <- lines do
        process_principal_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write({Principals, model.nconst, model.category, model.job, model.characters})
      end
    end

    models |> record_data(f, total)
  end

  def add_crew(lines, total) do
    models =
      for line <- lines do
        process_crew_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write({Crew, model.tconst, model.directors, model.writers})
      end
    end

    models |> record_data(f, total)
  end

  def add_aka(lines, total) do
    models =
      for line <- lines do
        process_aka_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write({Akas, model.tconst, model.region, model.region})
      end
    end

    models |> record_data(f, total)
  end

  def add_episode(lines, total) do
    models =
      for line <- lines do
        process_episode_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write({Episodes, model.tconst, model.parent, model.season, model.episode})
      end
    end

    models |> record_data(f, total)
  end

  def add_rating(lines, total) do
    models =
      for line <- lines do
        process_rating_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write({Ratings, model.tconst, model.rate, model.votes})
      end
    end

    models |> record_data(f, total)
  end

  def add_basic(lines, total) do
    models =
      for line <- lines do
        process_basic_tsv_line(line)
      end

    f = fn ->
      for model <- models do
        :mnesia.write(
          {Basics, model.tconst, model.type, model.title, model.isAdult, model.startYear,
           model.endYear, model.runtime, model.genres}
        )
      end
    end

    models |> record_data(f, total)
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
      genres:
        case genres do
          "\\N" -> []
          g -> g |> String.split(",", trim: true)
        end
    }
  end
end
