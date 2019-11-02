#!/usr/bin/env bash
mix deps.get
mix do deps.compile, compile
source .env
bash data/download.sh
MIX_ENV=prod mix run -e OpenMovieApi.DbSetup.run
echo Processing the data. Will take few hours. Please wait ...
MIX_ENV=prod mix run -e OpenMovieApi.Commands.process_all
echo done. Starting server ...
PORT=8014 MIX_ENV=prod mix phx.server
