#!/bin/bash

sed -i 's/^python /python2 /' elevators/game_bots/random_bot_02_python/run_elevators_game_bot.sh
sed -i 's/^python /python2 /' snake_maze/game_bots/random_bot_02_python/run_snakemaze_game_bot.sh
sed -i 's/^python /python2 /' tictactoe/game_bots/random_bot_02_python/run_tictactoe_game_bot_as_player_1.sh
sed -i 's/^python /python2 /' tictactoe/game_bots/random_bot_02_python/run_tictactoe_game_bot_as_player_2.sh
sed -i 's/^python /python2 /' tictactoe/game_engine/start_tictactoe_game_engine.sh

