import json
import sys
import os, stat

DEBUG = False
EXPECTED_NR_ARGS = 2

execfile('tomek_play_turn.py')

class GameBotError(Exception):
    pass

class WrongNumberOfArgumentsError(GameBotError):
    def __str__(self):
        return 'ERROR: I was expecting exactly %(EXPECTED_NR_ARGS)s command line arguments.' % globals()

class ArgumentIsNotANamedPipeError(GameBotError):
    def __str__(self):
        return 'ERROR: The argument is not a named pipe.'

class UnexpectedFileAccessError(GameBotError):
    def __str__(self):
        return 'ERROR: Unexpected file access error.'

class RequestNotInJSONFormatError(GameBotError):
    def __str__(self):
        return 'ERROR: Request from game engine not in JSON format.'

def verify_number_of_cmd_line_arguments(actual_nr_args):

    if actual_nr_args != EXPECTED_NR_ARGS:
        if DEBUG:
            print 'ACTUAL NUMBER OF ARGUMENTS: %(actual_nr_args)s' % locals()
        raise WrongNumberOfArgumentsError

    return

def verify_that_argument_is_a_named_pipe(arg):

    try:
        stat.S_ISFIFO(os.stat(arg).st_mode)
    except OSError:
        if DEBUG:
            print 'ARGUMENT: ' + arg
        raise ArgumentIsNotANamedPipeError

    return

def send_response_to_game_engine(
      file_handle,
      response
    ):

    raw_json = json.dumps(response)

    f = open(file_handle, 'w')
    print >> f, raw_json
    f.close()

    return

def read_raw_json(file_handle):

    raw_json = ''

    f = open(file_handle, 'r')

    try:
        raw_json = f.read()
    finally:
        f.close()

    return raw_json

def parse_raw_json(raw_json):

    try:
        parsed_json = json.loads(raw_json)
    except ValueError:
        raise RequestNotInJSONFormatError

    return parsed_json

try:

    verify_number_of_cmd_line_arguments( len(sys.argv) - 1 )

    input_named_pipe  = sys.argv[1]
    output_named_pipe = sys.argv[2]

    verify_that_argument_is_a_named_pipe(input_named_pipe)
    verify_that_argument_is_a_named_pipe(output_named_pipe)

    while True:

        print 'INFO: Accepting requests ...'

        raw_request = read_raw_json(input_named_pipe)

        print raw_request

        parsed_request = parse_raw_json(raw_request)

        try:
            request = parsed_request['request']
        except:
            request = ''
            print 'ERROR: I could not locate a key-value pair for REQUEST.'
            continue

        print 'INFO: The game engine requested: ' + request

        response = {}

        if request == 'exit':

            sys.exit(0)

        if request == 'status':

            response['status'] = 'ready'

        if request == 'play_your_turn':

            try:
                player_role = parsed_request['player_role']
            except:
                print 'ERROR: I could not locate a key-value pair for PLAYER_ROLE.'
                continue

            try:
                owned_by_x = parsed_request['owned_by_x']
            except:
                print 'ERROR: I could not locate a key-value pair for OWNED_BY_X.'
                continue

            try:
                owned_by_zero = parsed_request['owned_by_zero']
            except:
                print 'ERROR: I could not locate a key-value pair for OWNED_BY_ZERO.'
                continue
            try:
                occupied_by_t = parsed_request['occupied_by_t']
            except:
                print 'ERROR: I could not locate a key-value pair for OCCUPIED_BY_T.'
                continue

            if type(owned_by_x) is not list:
                print 'ERROR: OWNED_BY_X should be a list, it is not.'
                continue

            if type(owned_by_zero) is not list:
                print 'ERROR: OWNED_BY_ZERO should be a list, it is not.'
                continue

            if type(occupied_by_t) is not str:
                print 'ERROR: OCCUPIED_BY_T should be a string, it is not.'
                continue

            if player_role in ['x','zero']:
                response['turn'] = \
                    play_turn(
                        player_role,
                        owned_by_x,
                        owned_by_zero,
                        occupied_by_t
                    )
            else:
                print 'ERROR: PLAYER_ROLE should be either x or zero, it is neither.'
                continue

        print 'INFO: Sending response: ' + str(response)

        send_response_to_game_engine(
            output_named_pipe,
            response
        )

except GameBotError, e:

    print str(e)

