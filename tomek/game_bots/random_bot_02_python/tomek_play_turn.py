import random

BOARD = ['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'b4', 'c1', 'c2', 'c3', 'c4', 'd1', 'd2', 'd3', 'd4']

def play_turn(
        player_role,
        owned_by_x,
        owned_by_zero,
        occupied_by_t
    ):

    available_squares = list( set(BOARD) - set(owned_by_x) - set(owned_by_zero) - set([occupied_by_t]))

    return random.choice(available_squares)