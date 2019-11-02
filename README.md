# OpenMovieApi

Basic APIs for getting movie information based on imdb id.
Data is getting updates every day.

API docs are available on: https://imdb.appido.ir/docs

## How it works

This app downloads `imdb datasets` from https://datasets.imdbws.com.
Downloaded data are huge and IMDd updates it every day.

Using this data, then I extract them [see helpers.ex](http://bit.ly/2PGoz6r), and afer few cleanups,
I added them to related fragmented `:mnesia` tables. This way, the data is available on demand and
very fast.

## Using API

Request:

```
GET /api/{imdb_id}
```

Example: `GET https://imdb.appido.ir/api/tt3538766`

Response:

```javascript

{
end_year: 2015,
genres: [ ],
id: "tt3538766",
is_adult: false,
rate: 7.3,
runtime: 93,
start_year: 2014,
title: "Messi",
type: "movie",
votes: 3332
}

```

## Install

Run the following

```bash
#!/usr/bin/env bash
mix deps.get
mix do deps.compile, compile
cp .env.example .env
source .env
bash data/download.sh
mix run -e OpenMovieApi.DbSetup.run
echo Processing the data. Will take few hours. Please wait ...
mix run -e OpenMovieApi.Commands.process_all
mix phx.server
```

or simply run `./run.sh`.
API will be served on port `8014`.

## Updating data:

You may want your data to be up to date.
add something like this to your crontab:

```bash
30 3 * * 1 cd <APP_FOLDER> && /usr/bin/bash upload.sh
```

This command will start updating movie database at `03:30` every monday.

## Author

I am Farsheed Ashouri. If you have any quesions regarding to this software,
drop me a mail: farsheed <at> ashouri <dot> org
