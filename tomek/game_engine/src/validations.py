import os, stat

def verify_number_of_cmd_line_arguments(actual_nr_args):

    if actual_nr_args != EXPECTED_NR_ARGS:
        if DEBUG:
            print 'ACTUAL NUMBER OF ARGUMENTS: %(actual_nr_args)s' % locals()
        raise WrongNumberOfArgumentsError

    return

def verify_game_state_consistency(
        game_state,
        who_moves_next
    ):
    max_size_of_game_state=3
   
    if type(game_state) is not dict:
        raise GameStateIsNotAHashError

    if len(game_state)!=max_size_of_game_state:
        raise GameStateLengthError

    size_of_owned_by_x    = len( game_state['owned_by_x'] )
    size_of_owned_by_zero = len( game_state['owned_by_zero'] )


    if 'owned_by_x' not in game_state:
        raise  KeyOwnedbyXNotInGameStateError

    if 'owned_by_zero' not in game_state:
        raise  KeyOwnedbyZeroNotInGameStateError    

    if 'occupied_by_t' not in game_state:
        raise  KeyOcupiedByTNotInGameStateError

    if size_of_owned_by_x < size_of_owned_by_zero:
        raise GameStateInconsistencyError

    if size_of_owned_by_x > 1 + size_of_owned_by_zero:
        raise GameStateInconsistencyError

    inferred_player_role_id = 0    

    if size_of_owned_by_x == size_of_owned_by_zero:
        inferred_player_role_id = 1

    if size_of_owned_by_x == 1 + size_of_owned_by_zero:
        inferred_player_role_id = 2

    if inferred_player_role_id != who_moves_next:
        raise CrossCheckFailedError

    return

def verify_ready_response(
        parsed_response
    ):

    if type(parsed_response) is not dict:
        raise ReadyResponseIsNotAHashError

    if len(parsed_response) != 1:
        raise ReadyResponseHashIsNotOfSizeOneError

    if 'status' not in parsed_response:
        raise NoSuchKeyStatusError

    if parsed_response['status'] != 'ready':
        raise PlayerIsNotReadyError

    return

def verify_turn_response(
        game_state,
        parsed_response
    ):

    if type(parsed_response) is not dict:
        raise TurnResponseIsNotAHashError

    if len(parsed_response) != 1:
        raise TurnResponseHashIsNotOfSizeOneError

    if 'turn' not in parsed_response:
        raise NoSuchKeyTurnError

    occupied_cells = game_state['owned_by_x'] + game_state['owned_by_zero'] + [game_state['occupied_by_t']]

    token_placed = parsed_response['turn']

    if token_placed not in BOARD or token_placed in occupied_cells:
        raise IllegalMoveError

    return

def verify_that_argument_is_a_named_pipe(arg):

    try:
        stat.S_ISFIFO(os.stat(arg).st_mode)
    except OSError:
        if DEBUG:
            print 'ARGUMENT: ' + arg
        raise ArgumentIsNotANamedPipeError

    return


