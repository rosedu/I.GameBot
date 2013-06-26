import sys
import json
import operator

def read_raw_json(file_handle):

    f = open(file_handle, 'r')
    try:
        raw_json = f.read()
    finally:
        f.close()

    return raw_json

def parse_raw_json(raw_json):

    return json.loads(raw_json)

def add_contestant_info_to_players_dictionary(
        contestant,
        overall_score,
        players_dictionary
    ):

    if contestant in players_dictionary:
        players_dictionary[contestant] += overall_score
    else:
        players_dictionary[contestant] = overall_score

    return players_dictionary

players = {}

for json_file in sys.argv[1:]:

    progress_log = parse_raw_json( read_raw_json(json_file) )

    contestant_x =    progress_log['contestant_x'].encode('ascii')
    contestant_zero = progress_log['contestant_zero'].encode('ascii')
    overall_score_x    = progress_log['overall_score_x']
    overall_score_zero = progress_log['overall_score_zero']

    players = \
        add_contestant_info_to_players_dictionary(
            contestant_x,
            overall_score_x,
            players
        )

    players = \
        add_contestant_info_to_players_dictionary(
            contestant_zero,
            overall_score_zero,
            players
        )

leaderboard = sorted(players.items(), key=operator.itemgetter(1), reverse=True)

print
print 'Leaderboard / Cumulative Scores for the OSSS TicTacToe++ competition'
print


for contestant_info in leaderboard:
    print contestant_info[0], ':', contestant_info[1]

print

