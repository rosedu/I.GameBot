import sys

for identifier in sys.argv[1:]:
    for n in ['1','2']:
        f = open('start_' + identifier + '_as_player_' + n + '.sh', 'w')
        print >> f, 'cd /tmp/aichallenge/tictactoe/' + identifier
        print >> f, './run_tictactoe_game_bot_as_player_' + n + '.sh'
        f.close()

f = open('start_tournament.sh', 'w')
print >> f, 'pkill xterm'

for x in sys.argv[1:]:
    for zero in sys.argv[1:]:
        if zero != x:
            print >> f, 'xterm -e ./start_' + x    + '_as_player_1.sh &'
            print >> f, 'xterm -e ./start_' + zero + '_as_player_2.sh &'
            print >> f, 'python ' + \
                        'src/start_game_engine.py ' + \
                        '/tmp/output_of_game_engine_input_of_player_1 ' + \
                        '/tmp/output_of_player_1_input_of_game_engine ' + \
                        '/tmp/output_of_game_engine_input_of_player_2 ' + \
                        '/tmp/output_of_player_2_input_of_game_engine ' + \
                        x + ' ' + zero + ' ' + \
                        '2>/tmp/tictactoe_debug_log.txt'
            print >> f, 'pkill xterm'

f.close()

# rm start_*_as_player_*.sh
# rm start_tournament.sh
# python generate_tournament_scripts.py Andrei_Tuicu emanuel_antonache raduct93
# chmod +x start_*_as_player_*.sh
# chmod +x start_tournament.sh
# python generate_leaderboard.py /tmp/*.json
