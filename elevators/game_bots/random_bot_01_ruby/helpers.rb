def verify_number_of_cmd_line_arguments(actual_nr_args)
  if actual_nr_args != EXPECTED_NR_ARGS
    $stderr.puts 'ACTUAL NUMBER OF ARGUMENTS: ' + actual_nr_args.to_s if DEBUG
    raise WrongNumberOfArgumentsError
  end
end

def verify_that_argument_is_a_named_pipe(arg)
  valid_arg = File.exists?(arg) && File.ftype(arg) == 'fifo'
  if !valid_arg
    $stderr.puts 'ARGUMENT: ' + arg
    raise ArgumentIsNotANamedPipeError
  end
end

def send_raw_json_to_game_engine(
      file_handle,
      raw_json
    )
  begin
    f = open(file_handle, 'w')
    f.puts raw_json
    f.close
  rescue
    $stderr.puts 'FILE: ' + file_handle if DEBUG
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
    $stderr.puts 'REQUEST: ' + raw_json if DEBUG
    raise RequestNotInJSONFormatError
  end

  parsed_json
end

