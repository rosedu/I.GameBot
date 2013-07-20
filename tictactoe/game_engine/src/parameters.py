EXPECTED_NR_ARGS = 6

BONUS_POINTS = 3

GAME_CONTINUES = 0
GAME_STOPS_NOW = 1

BOARD = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']

WINNING_COMBINATIONS = {
    'a1a2a3': ['a1', 'a2', 'a3'],
    'b1b2b3': ['b1', 'b2', 'b3'],
    'c1c2c3': ['c1', 'c2', 'c3'],
    'a1b1c1': ['a1', 'b1', 'c1'],
    'a2b2c2': ['a2', 'b2', 'c2'],
    'a3b3c3': ['a3', 'b3', 'c3'],
    'a1b2c3': ['a1', 'b2', 'c3'],
    'a3b2c1': ['a3', 'b2', 'c1']
}

WCOMB_FOR_TOKEN = {
    'a1': ['a1a2a3', 'a1b1c1', 'a1b2c3'],
    'a2': ['a1a2a3', 'a2b2c2'],
    'a3': ['a1a2a3', 'a3b3c3', 'a3b2c1'],
    'b1': ['b1b2b3', 'a1b1c1'],
    'b2': ['b1b2b3', 'a2b2c2', 'a1b2c3', 'a3b2c1'],
    'b3': ['b1b2b3', 'a3b3c3'],
    'c1': ['c1c2c3', 'a1b1c1', 'a3b2c1'],
    'c2': ['c1c2c3', 'a2b2c2'],
    'c3': ['c1c2c3', 'a3b3c3', 'a1b2c3']
}

# This is how many points a player gets for winning
WINNER_GETS_POINTS = 10

# This is how many points a player gets
# for successfully defending against a direct attack
POINTS_FOR_SUCCESSFUL_DEFENSE = 1

# Points scored by x if they place their token
# on one of the edges at the start of the game
EDGE_TOKEN_POINTS = 3

