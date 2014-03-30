EXPECTED_NR_ARGS = 6

BONUS_POINTS = 3
EXTRA_POINTS_FOR_NOT_ALIGNING_WITH_T = 3

GAME_CONTINUES = 0
GAME_STOPS_NOW = 1

BOARD = ['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'b4', 'c1', 'c2', 'c3', 'c4', 'd1', 'd2', 'd3','d4']

WINNING_COMBINATIONS = {
    'a1a2a3a4': ['a1', 'a2', 'a3', 'a4'],
    'b1b2b3b4': ['b1', 'b2', 'b3', 'b4'],
    'c1c2c3c4': ['c1', 'c2', 'c3', 'c4'],
    'd1d2d3d4': ['d1', 'd2', 'd3', 'd4'],
    'a1b1c1d1': ['a1', 'b1', 'c1', 'd1'],
    'a2b2c2d2': ['a2', 'b2', 'c2', 'd2'],
    'a3b3c3d3': ['a3', 'b3', 'c3', 'd3'],
    'a4b4c4d4': ['a4', 'b4', 'c4', 'd4'],
    'a1b2c3d4': ['a1', 'b2', 'c3', 'd4'],
    'a4b3c2d1': ['a4', 'b3', 'c2', 'd1']
}

WCOMB_FOR_TOKEN = {
    'a1': ['a1a2a3a4', 'a1b1c1d1', 'a1b2c3d4'],
    'a2': ['a1a2a3a4', 'a2b2c2d2'],
    'a3': ['a1a2a3a4', 'a3b3c3d3'],
    'a4': ['a1a2a3a4', 'a4b4c4d4', 'a4b3c2d1'],
    'b1': ['b1b2b3b4', 'a1b1c1d1'],
    'b2': ['b1b2b3b4', 'a2b2c2d2', 'a1b2c3d4'],
    'b3': ['b1b2b3b4', 'a3b3c3d3', 'a4b3c2d1'],
    'b4': ['b1b2b3b4', 'a4b4c4d4'],
    'c1': ['c1c2c3c4', 'a1b1c1d1'],
    'c2': ['c1c2c3c4', 'a2b2c2d2', 'a4b3c2d1'],
    'c3': ['c1c2c3c4', 'a3b3c3d3', 'a1b2c3d4'],
    'c4': ['c1c2c3c4', 'a4b4c4d4'],
    'd1': ['d1d2d3d4', 'a1b1c1d1', 'a4b3c2d1'],
    'd2': ['d1d2d3d4', 'a2b2c2d2'],
    'd3': ['d1d2d3d4', 'a3b3c3d3'],
    'd4': ['d1d2d3d4', 'a4b4c4d4', 'a1b2c3d4']
}

# This is how many points a player gets for winning
WINNER_GETS_POINTS = 10

# This is how many points a player gets
# for successfully defending against a direct attack
POINTS_FOR_SUCCESSFUL_DEFENSE = 1

# Points scored by x if they place their token
# on one of the edges at the start of the game
EDGE_TOKEN_POINTS = 3

