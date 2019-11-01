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
