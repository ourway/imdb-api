# OpenMovieApi

Basic APIs for getting movie information based on imdb id.
Data is getting updates every day.

API docs are available on: https://imdb.appido.ir/docs

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

