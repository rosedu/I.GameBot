def send_raw_json_to_player(
      output_of_game_engine_input_of_player,
      raw_json
    )
  begin
    f = open(output_of_game_engine_input_of_player, 'w')
    f.puts raw_json
    f.close
  rescue
    $stderr.puts 'FILE: ' + output_of_game_engine_input_of_player if DEBUG
    raise UnexpectedFileAccessError
  end
end

def read_raw_json(file_handle)
  begin
    f = open(file_handle, 'r')
    raw_json = f.readlines.join
    f.close
  rescue
    $stderr.puts 'FILE: ' + file_handle if DEBUG
    raise UnexpectedFileAccessError
  end

  raw_json
end

def parse_raw_json(raw_json)
  begin
    parsed_json = JSON.parse(raw_json)
  rescue
    $stderr.puts 'RESPONSE: ' + raw_json if DEBUG
    raise ResponseNotInJSONFormatError
  end

  parsed_json
end

def write_progress_log_to_disk(
      progress_log
    )
  begin
    output_file = '/tmp/elevators_progress_log_' +
                  progress_log['contestant'] +
                  '.json'
    f = open(output_file, 'w')
    f.puts progress_log.to_json
    f.close
  rescue
    $stderr.puts 'FILE: ' + output_file if DEBUG
    raise UnexpectedFileAccessError
  end
end

