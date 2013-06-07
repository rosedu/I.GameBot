import random

BOARD = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']

def play_turn(
        player_role,
        owned_by_x,
        owned_by_zero
    ):

    available_squares = list( set(BOARD) - set(owned_by_x) - set(owned_by_zero) )

    return random.choice(available_squares)

