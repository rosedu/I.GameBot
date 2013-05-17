require 'json'

DEBUG = false
EXPECTED_NR_ARGS = 2

VALID_REQUESTS = [
  'set_standby_locations',
  'embark_passengers_and_set_destinations'
]

require './exceptions.rb'
require './helpers.rb'
require './elevators_play_turn.rb'

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

    if !VALID_REQUESTS.include?(request)
      $stderr.puts "ERROR: The game engine did not send a valid request."
      exit
    end

    begin
      number_of_floors =
        parsed_request['number_of_floors']
      number_of_elevators =
        parsed_request['number_of_elevators']
      carrying_capacity_of_one_elevator =
        parsed_request['carrying_capacity_of_one_elevator']
    rescue
      $stderr.puts "ERROR: I could not locate all the topology data."
      exit
    end

    if request == 'embark_passengers_and_set_destinations'
      begin
        passengers = parsed_request['passengers']
      rescue
        $stderr.puts "ERROR: I could not locate PASSENGERS."
        exit
      end

      begin
        elevators = parsed_request['elevators']
      rescue
        $stderr.puts "ERROR: I could not locate ELEVATORS."
        exit
      end
    end

    case request
    when 'set_standby_locations'
      response = set_standby_locations(
                   number_of_floors,
                   number_of_elevators,
                   carrying_capacity_of_one_elevator
                 )
    when 'embark_passengers_and_set_destinations'
      response = embark_passengers_and_set_destinations(
                   number_of_floors,
                   number_of_elevators,
                   carrying_capacity_of_one_elevator,
                   passengers,
                   elevators
                 )
    end

    raw_response = response.to_json

    $stderr.puts "INFO: I am sending the following response to the game engine:"
    $stderr.puts raw_response.inspect

    send_raw_json_to_game_engine(
      output_named_pipe,
      raw_response
    )
  end
rescue GameBotError => e
  $stderr.puts e.class::MESSAGE
end

