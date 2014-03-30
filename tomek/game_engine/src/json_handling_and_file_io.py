import json
import sys

def send_raw_json_to_player(
      output_of_game_engine_input_of_player,
      request
    ):

    raw_json = json.dumps(request)

    f = open(output_of_game_engine_input_of_player, 'w')
    print >> f, raw_json
    f.close()

    return

def read_raw_json(file_handle):

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
        raise ResponseNotInJSONFormatError

    return parsed_json

def communicate_with_bot(
        output_of_game_engine_input_of_player,
        request,
        output_of_player_input_of_game_engine
    ):

    send_raw_json_to_player(
        output_of_game_engine_input_of_player,
        request
    )

    raw_response = \
        read_raw_json(
            output_of_player_input_of_game_engine
        )

    parsed_response = \
        parse_raw_json(
            raw_response
        )

    return parsed_response

def write_progress_log_to_disk(
      progress_log
    ):

    output_file = '/tmp/tomek_progress_log_' + \
                  progress_log['contestant_x'] + \
                  '_' + \
                  progress_log['contestant_zero'] + \
                  '.json'
    f = open(output_file, 'w')
    print >> f, json.dumps(progress_log)
    f.close()

    return

