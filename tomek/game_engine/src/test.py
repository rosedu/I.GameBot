def is_aligned_wT(game_state, token_placed):
    poss_advantage = WCOMB_FOR_TOKEN[game_state['occupied_by_t']]
    my_poss_advantage = [WINNING_COMBINATIONS[x] for x in poss_advantage]
    list_advantages = list(itertools.chain(*my_poss_advantage))
    return token_placed in list_advantages


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
    'a2': ['a1a2a3a4', 'a2b2c2d4'],
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
