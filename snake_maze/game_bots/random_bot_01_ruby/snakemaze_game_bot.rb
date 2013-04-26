require 'json'

DEBUG = false
EXPECTED_NR_ARGS = 2

require './snakemaze_play_turn.rb'

class GameBotError < StandardError
end

class WrongNumberOfArgumentsError < GameBotError
  MESSAGE = "ERROR: I was expecting exactly #{EXPECTED_NR_ARGS.to_s} command line arguments."
end

class ArgumentIsNotANamedPipeError < GameBotError
  MESSAGE = 'ERROR: The argument is not a named pipe.'
end

class UnexpectedFileAccessError < GameBotError
  MESSAGE = 'ERROR: Unexpected file access error.'
end

class RequestNotInJSONFormatError < GameBotError
  MESSAGE = 'ERROR: Request from game engine not in JSON format.'
end

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

begin
  verify_number_of_cmd_line_arguments(ARGV.size)

  input_named_pipe = ARGV.first
  output_named_pipe = ARGV.last

  verify_that_argument_is_a_named_pipe(input_named_pipe)
  verify_that_argument_is_a_named_pipe(output_named_pipe)

  loop do
    $stderr.puts 'INFO: Waiting for game engine to send a request...'

    raw_request = read_raw_json(input_named_pipe)

    parsed_request = parse_raw_json(raw_request)

    begin
      request = parsed_request['request']
    rescue
      $stderr.puts "ERROR: I could not locate a key-value pair for REQUEST."
      exit
    end

    $stderr.puts 'INFO: The game engine requested: ' + request

    if request != 'play_your_turn'
      $stderr.puts "ERROR: The game engine did not request that I play my turn."
      exit
    end

    begin
      width = parsed_request['rectangle']['width']
      height = parsed_request['rectangle']['height']
    rescue
      $stderr.puts "ERROR: I could not locate WIDTH/HEIGHT."
      exit
    end

    begin
      obstacles = parsed_request['obstacles']
    rescue
      $stderr.puts "ERROR: I could not locate OBSTACLES."
      exit
    end

    response = play_turn(width, height, obstacles)

    $stderr.puts "INFO: I am sending the following snake data to the game engine:"
    $stderr.puts response.inspect

    raw_response = response.to_json

    send_raw_json_to_game_engine(
      output_named_pipe,
      raw_response
    )
  end
rescue GameBotError => e
  $stderr.puts e.class::MESSAGE
end

