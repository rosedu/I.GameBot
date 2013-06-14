import json
import sys
import os, stat

DEBUG = False
EXPECTED_NR_ARGS = 2

VALID_REQUESTS = [
  'set_standby_locations',
  'embark_passengers_and_set_destinations'
]

execfile('elevators_play_turn.py')

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

        parsed_request = parse_raw_json(raw_request)

        try:
            request = parsed_request['request']
        except:
            request = ''
            print 'ERROR: I could not locate a key-value pair for REQUEST.'
            break

        print 'INFO: The game engine requested: ' + request

        if request not in VALID_REQUESTS:

            print 'ERROR: The game engine did not send a valid request.'
            break

        try:
            number_of_floors = \
                parsed_request['number_of_floors']

            number_of_elevators = \
                parsed_request['number_of_elevators']

            carrying_capacity_of_one_elevator = \
                parsed_request['carrying_capacity_of_one_elevator']
        except:
            print 'ERROR: I could not locate all the topology data.'
            break

        if request == 'embark_passengers_and_set_destinations':

            try:
                passengers = \
                    parsed_request['passengers']
            except:
                print 'ERROR: I could not locate PASSENGERS.'
                break

            try:
                elevators = \
                    parsed_request['elevators']
            except:
                print 'ERROR: I could not locate ELEVATORS.'
                break

        if request == 'set_standby_locations':

            response = set_standby_locations(
                number_of_floors,
                number_of_elevators,
                carrying_capacity_of_one_elevator
            )

        if request == 'embark_passengers_and_set_destinations':

            response = embark_passengers_and_set_destinations(
                number_of_floors,
                number_of_elevators,
                carrying_capacity_of_one_elevator,
                passengers,
                elevators
            )

        print 'INFO: Sending response: ' + str(response)

        send_response_to_game_engine(
            output_named_pipe,
            response
        )

except GameBotError, e:

    print str(e)

