execfile('src/parameters.py')
execfile('src/exceptions.py')
execfile('src/validations.py')
execfile('src/json_handling_and_file_io.py')
import itertools
DEBUG = True

class PlayerInfo:

    def __init__(self, input_channel, output_channel, player_role, game_state_key):
        self.input_channel  = input_channel
        self.output_channel = output_channel
        self.player_role    = player_role
        self.game_state_key = game_state_key

def sync_overall_scores(progress_log):

    progress_log['overall_score_x'] = \
        progress_log['score_for_x'] + \
        progress_log['bonus_points_for_x']

    progress_log['overall_score_zero'] = \
        progress_log['score_for_zero'] + \
        progress_log['bonus_points_for_zero']

    return progress_log


def incorporate_points_scored(
        progress_log,
        points_scored_by_x,
        points_scored_by_zero
    ):

    progress_log['score_for_x'] += \
        points_scored_by_x

    progress_log['score_for_zero'] += \
        points_scored_by_zero

    return progress_log


def is_aligned_wT(game_state, token_placed):
    poss_advantage = WCOMB_FOR_TOKEN[game_state['occupied_by_t']]
    my_poss_advantage = [WINNING_COMBINATIONS[x] for x in poss_advantage]
    list_advantages = list(itertools.chain(*my_poss_advantage))
    return token_placed in list_advantages

def compute_points_scored(
        turn,
        game_state,
        who_just_moved,
        token_placed
    ):

    return_code = GAME_CONTINUES

    points_scored_by_x    = 0
    points_scored_by_zero = 0

    bonus_token_placed = ['a2','a3', 'b1', 'b4', 'c1', 'c4', 'd2', 'd4']
    

    if turn == 1 and token_placed in bonus_token_placed and not is_aligned_wT(game_state, token_placed):
        points_scored_by_x = EDGE_TOKEN_POINTS
        return (
            return_code,
            points_scored_by_x,
            points_scored_by_zero
        )
    if turn == 2 and token_placed in bonus_token_placed and not is_aligned_wT(game_state, token_placed):
        points_scored_by_zero = EDGE_TOKEN_POINTS
        return (
            return_code,
            points_scored_by_x,
	    points_scored_by_zero
        ) 

    possible_wcomb_for_token = [
        WINNING_COMBINATIONS[aligned_squares]
        for aligned_squares in WCOMB_FOR_TOKEN[token_placed]
    ]

    if turn >= 5:
        
        empty_set = set([])
        set_occupied_by_t = set(game_state['occupied_by_t'])
        set_with_only_token_placed = set([token_placed])
        set_owned_by_x    = set(game_state['owned_by_x'])
        set_owned_by_zero = set(game_state['owned_by_zero'])

        for comb in possible_wcomb_for_token:

            if who_just_moved == 1:

                if set(comb) - set_owned_by_x - set_with_only_token_placed == empty_set:

                    points_scored_by_x = WINNER_GETS_POINTS
                    return_code = GAME_STOPS_NOW

                    return (
                        return_code,
                        points_scored_by_x,
                        points_scored_by_zero
                    )

            else:

                if set(comb) - set_owned_by_zero - set_with_only_token_placed == empty_set:

                    points_scored_by_zero = WINNER_GETS_POINTS
                    return_code = GAME_STOPS_NOW

                    return (
                        return_code,
                        points_scored_by_x,
                        points_scored_by_zero
                    )

        for comb in possible_wcomb_for_token:

            if who_just_moved == 1:

                if len( set.intersection(set(comb), set_owned_by_zero) ) == 2:

                    points_scored_by_x = POINTS_FOR_SUCCESSFUL_DEFENSE

                    return (
                        return_code,
                        points_scored_by_x,
                        points_scored_by_zero
                    )

            else:

                if len( set.intersection(set(comb), set_owned_by_x) ) == 2:

                    points_scored_by_zero = POINTS_FOR_SUCCESSFUL_DEFENSE

                    return (
                        return_code,
                        points_scored_by_x,
                        points_scored_by_zero
                    )

    return (
        return_code,
        points_scored_by_x,
        points_scored_by_zero
    )

def start_game(game_number):

    verify_number_of_cmd_line_arguments( len(sys.argv) - 1 )

    output_of_game_engine_input_of_player_1 = sys.argv[1]
    output_of_player_1_input_of_game_engine = sys.argv[2]
    output_of_game_engine_input_of_player_2 = sys.argv[3]
    output_of_player_2_input_of_game_engine = sys.argv[4]
    screen_name_of_contestant_x             = sys.argv[5]
    screen_name_of_contestant_zero          = sys.argv[6]

    progress_log = {
        'contestant_x':    screen_name_of_contestant_x,
        'contestant_zero': screen_name_of_contestant_zero,
        'score_for_x':    0,
        'score_for_zero': 0,
        'bonus_points_for_x':    0,
        'bonus_points_for_zero': 0,
        'overall_score_x':    0,
        'overall_score_zero': 0,
        'owned_by_x':    [],
        'owned_by_zero': [],
        'last_token_placed': ''
    }

    try:

        verify_that_argument_is_a_named_pipe(
            output_of_game_engine_input_of_player_1
        )

        verify_that_argument_is_a_named_pipe(
            output_of_player_1_input_of_game_engine
        )

        verify_that_argument_is_a_named_pipe(
            output_of_game_engine_input_of_player_2
        )

        verify_that_argument_is_a_named_pipe(
            output_of_player_2_input_of_game_engine
        )

        status_request = {'request': 'status'}

        progress_log['bonus_points_for_x']    = 0
        progress_log['bonus_points_for_zero'] = BONUS_POINTS

        progress_log = \
            sync_overall_scores(progress_log)

        write_progress_log_to_disk(
            progress_log
        )

        parsed_response = \
            communicate_with_bot(
                output_of_game_engine_input_of_player_1,
                status_request,
                output_of_player_1_input_of_game_engine
            )

        verify_ready_response(
            parsed_response
        )

        progress_log['bonus_points_for_x']    = BONUS_POINTS
        progress_log['bonus_points_for_zero'] = 0

        progress_log = \
            sync_overall_scores(progress_log)

        write_progress_log_to_disk(
            progress_log
        )

        parsed_response = \
            communicate_with_bot(
                output_of_game_engine_input_of_player_2,
                status_request,
                output_of_player_2_input_of_game_engine
            )

        verify_ready_response(
            parsed_response
        )

        progress_log['bonus_points_for_x']    = 0
        progress_log['bonus_points_for_zero'] = BONUS_POINTS

        who_moves_next = 1

     
        t_pozitions = ['a1','a2','b2']
        occupied_by_t = t_pozitions[game_number]
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': [],
            'occupied_by_t': occupied_by_t 
        }
        progress_log['occupied_by_t'] = game_state['occupied_by_t']
        last_token_placed = ''

        player_data = {
            1: PlayerInfo(
                   output_of_game_engine_input_of_player_1,
                   output_of_player_1_input_of_game_engine,
                   'x',
                   'owned_by_x'
               ),
            2: PlayerInfo(
                   output_of_game_engine_input_of_player_2,
                   output_of_player_2_input_of_game_engine,
                   'zero',
                   'owned_by_zero'
               )
        }

        for turn in range(1,16):

            verify_game_state_consistency(game_state, who_moves_next)

            turn_request = {
                'request':       'play_your_turn',
                'player_role':   player_data[who_moves_next].player_role,
                'owned_by_x':    game_state['owned_by_x'],
                'owned_by_zero': game_state['owned_by_zero'],
                'occupied_by_t': game_state['occupied_by_t']
            }

            progress_log['owned_by_x']    = game_state['owned_by_x']
            progress_log['owned_by_zero'] = game_state['owned_by_zero']
            

            progress_log = \
                sync_overall_scores(progress_log)

            write_progress_log_to_disk(
                progress_log
            )

            parsed_response = \
                communicate_with_bot(
                    player_data[who_moves_next].input_channel,
                    turn_request,
                    player_data[who_moves_next].output_channel
                )

            verify_turn_response(
                game_state,
                parsed_response
            )

            who_just_moved = who_moves_next 

            token_placed = parsed_response['turn'].encode('ascii')
            progress_log['last_token_placed'] = token_placed

            game_state[player_data[who_just_moved].game_state_key].append(
                token_placed
            )

            progress_log['owned_by_x']    = game_state['owned_by_x']
            progress_log['owned_by_zero'] = game_state['owned_by_zero']

            return_code, points_scored_by_x, points_scored_by_zero = \
                compute_points_scored(
                    turn,
                    game_state,
                    who_just_moved,
                    token_placed
                )

            progress_log = \
                incorporate_points_scored(
                    progress_log,
                    points_scored_by_x,
                    points_scored_by_zero
                )

            progress_log['bonus_points_for_x'] = \
                BONUS_POINTS - progress_log['bonus_points_for_x']
            progress_log['bonus_points_for_zero'] = \
                BONUS_POINTS - progress_log['bonus_points_for_zero']

            if return_code == GAME_STOPS_NOW or turn == 15:
                progress_log['bonus_points_for_x']    = BONUS_POINTS
                progress_log['bonus_points_for_zero'] = BONUS_POINTS
                break

            who_moves_next = 3 - who_moves_next

        progress_log = \
            sync_overall_scores(progress_log)

        progress_log['owned_by_x']    = game_state['owned_by_x']
        progress_log['owned_by_zero'] = game_state['owned_by_zero']

        write_progress_log_to_disk(
            progress_log
        )

    except GameEngineError, e:

        print str(e)

    write_progress_log_to_disk(
        progress_log
    )
    
    print '================================================'
    print 'Game number: ' + str(game_number + 1)
    print progress_log
    print
    print 'Game ' + str(game_number + 1) + ' score  X : ' + str(progress_log['overall_score_x'])
    print
    print 'Game ' + str(game_number + 1) + ' score O : ' + str(progress_log['overall_score_zero'])
    print

    return(progress_log['overall_score_x'], progress_log['overall_score_zero'])

def start_match():
    overall_score_x = 0
    overall_score_zero = 0
    for i in range(0,3):
       crt_score_x, crt_score_zero = start_game(i)
       overall_score_x += crt_score_x
       overall_score_zero += crt_score_zero

    print '================================================'
    print 'Overall score X: ' +str(overall_score_x)
    print 'Overall score O: ' + str(overall_score_zero)
    if overall_score_x > overall_score_zero:
       print 'Match winner X'
    elif overall_score_x < overall_score_zero:
       print 'Match winner O'
    else:
       print 'Match ended in a tie'
