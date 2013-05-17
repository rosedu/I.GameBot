require 'json'
require './src/exceptions.rb'
require './src/input_verifications.rb'
require './src/json_handling_and_file_io.rb'

DEBUG = true

def game_state_after_building_snake(snake, topology)
  game_state = {
    :why_the_game_ended => :not_applicable, # Because the game has not ended
    :board_squares_occupied_by_snake => [],
    :if_there_was_an_error_it_occured_at => {},
    :score => 0
  }

  current_square = snake['starts_at'].dup
  game_state[:board_squares_occupied_by_snake] = [current_square]
  snake['shape_segments'].each do |segment|
    current_square = current_square.dup
    case segment
    when 'right'
      current_square['x'] += 1
    when 'left'
      current_square['x'] -= 1
    when 'up'
      current_square['y'] -= 1
    when 'down'
      current_square['y'] += 1
    end
    game_state[:board_squares_occupied_by_snake] << current_square
  end

  obstacles_hash = {}
  topology['obstacles'].each do |obstacle|
    key_symbol = "x_#{obstacle['x'].to_s}_y_#{obstacle['y'].to_s}".to_sym
    obstacles_hash[key_symbol] = :dummy
  end

  occupied_squares_hash = {}
  game_state[:board_squares_occupied_by_snake].each do |square|
    square_out_of_bounds = square['x'] > topology['rectangle']['width'] - 1 ||
                           square['x'] < 0 ||
                           square['y'] < 0 ||
                           square['y'] > topology['rectangle']['height'] - 1

    if square_out_of_bounds &&
       game_state[:if_there_was_an_error_it_occured_at].empty?
      game_state[:why_the_game_ended] = :snake_exited_the_grid
      game_state[:if_there_was_an_error_it_occured_at] = square
      return game_state
    end

    key_symbol = "x_#{square['x'].to_s}_y_#{square['y'].to_s}".to_sym

    if obstacles_hash.has_key?(key_symbol) &&
       game_state[:if_there_was_an_error_it_occured_at].empty?
      game_state[:why_the_game_ended] = :snake_ran_over_an_obstacle
      game_state[:if_there_was_an_error_it_occured_at] = square
      return game_state
    end

    if occupied_squares_hash.has_key?(key_symbol) &&
       game_state[:if_there_was_an_error_it_occured_at].empty?
      game_state[:why_the_game_ended] = :snake_has_intersected_with_itself
      game_state[:if_there_was_an_error_it_occured_at] = square
      return game_state
    else
      occupied_squares_hash[key_symbol] = :dummy
    end

    game_state[:score] += 1
  end

  if game_state[:why_the_game_ended] == :not_applicable
    game_state[:why_the_game_ended] = :normal_exit
  end

  game_state
end

def start_game
  output_of_game_engine_input_of_player = ARGV.shift
  output_of_player_input_of_game_engine = ARGV.shift
  screen_name_of_contestant = ARGV.shift

  topology_json_hash = {}
  ARGV.each do |topology_json_file|
    topology_json_hash[topology_json_file] = :dummy
  end

  progress_log = {
    'contestant' => screen_name_of_contestant,
    'topologies_processed' => 0,
    'per_topology_final_game_state' => {},
    'overall_score' => 0
  }

  begin
    verify_that_argument_is_a_named_pipe(
      output_of_game_engine_input_of_player
    )

    verify_that_argument_is_a_named_pipe(
      output_of_player_input_of_game_engine
    )

    topology_json_hash.each_key do |topology_json_file|
      verify_that_topology_file_exists(
        topology_json_file
      )

      raw_topology_json = read_raw_json(
                            topology_json_file
                          )

      parsed_topology_json = parse_raw_json(
                               raw_topology_json
                             )

      verify_topology(
        parsed_topology_json
      )

      topology_json_hash[topology_json_file] = parsed_topology_json
    end

    topology_json_hash.each do |topology_json_file, parsed_topology_json|
      request = parsed_topology_json.dup
      request['request'] = 'play_your_turn'
      raw_request = request.to_json

      $stderr.puts "INFO: I am sending the following request to the game bot:" if DEBUG
      $stderr.puts request.inspect if DEBUG

      send_raw_json_to_player(
        output_of_game_engine_input_of_player,
        raw_request
      )

      raw_snake = read_raw_json(
                    output_of_player_input_of_game_engine
                  )

      parsed_snake = parse_raw_json(
                       raw_snake
                     )

      $stderr.puts "INFO: I have received the following snake data from the game bot:" if DEBUG
      $stderr.puts parsed_snake.inspect if DEBUG

      verify_validity_of_snake_data(
        parsed_snake,
        parsed_topology_json
      )

      game_state = game_state_after_building_snake(
                     parsed_snake,
                     parsed_topology_json
                   )

      progress_log['topologies_processed'] += 1
      progress_log['per_topology_final_game_state'][topology_json_file] =
        game_state
      progress_log['overall_score'] += game_state[:score]
      write_progress_log_to_disk(
        progress_log
      )

      $stderr.puts "INFO: Based on the snake data I received from the game bot, I have computed the following game state:" if DEBUG
      $stderr.puts game_state.inspect if DEBUG
    end
  rescue GameEngineError => e
    $stderr.puts e.class::MESSAGE
  end
  puts progress_log.to_json
end

