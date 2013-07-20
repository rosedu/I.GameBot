require 'json'
require './src/exceptions.rb'
require './src/input_verifications.rb'
require './src/json_handling_and_file_io.rb'

DEBUG = true
INTERVAL_BETWEEN_PASSENGER_WAVES = 10
ELEVATOR_ADVANCE_HELPER = {
  'at_floor_not_in_motion_same_floor' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => false,
    'new_value_for_currently' => 'not_in_motion',
    'direction_stays_the_same' => true
  },
  'at_floor_not_in_motion_close' => {
    'new_location_type' => 'just_left_floor',
    'move_by_one' => false,
    'new_value_for_currently' => 'moving_at_half_speed',
    'direction_stays_the_same' => false
  },
  'at_floor_not_in_motion_far' => {
    'new_location_type' => 'just_left_floor',
    'move_by_one' => false,
    'new_value_for_currently' => 'accelerating',
    'direction_stays_the_same' => false
  },
  'at_floor_moving_at_half_speed' => {
    'new_location_type' => 'about_to_reach_floor',
    'move_by_one' => true,
    'new_value_for_currently' => 'moving_at_half_speed',
    'direction_stays_the_same' => true
  },
  'at_floor_moving_at_full_speed' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => true,
    'new_value_for_currently' => 'moving_at_full_speed',
    'direction_stays_the_same' => true
  },
  'just_left_floor_moving_at_half_speed' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => true,
    'new_value_for_currently' => 'moving_at_half_speed',
    'direction_stays_the_same' => true
  },
  'just_left_floor_accelerating' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => true,
    'new_value_for_currently' => 'moving_at_full_speed',
    'direction_stays_the_same' => true
  },
  'about_to_reach_floor_moving_at_half_speed' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => false,
    'new_value_for_currently' => 'not_in_motion',
    'direction_stays_the_same' => false
  },
  'about_to_reach_floor_decelerating' => {
    'new_location_type' => 'at_floor',
    'move_by_one' => false,
    'new_value_for_currently' => 'not_in_motion',
    'direction_stays_the_same' => false
  }
}

def on_clock_tick(game_state)
  elevators = game_state['elevators']
  passengers = game_state['passengers']

  new_elevators_hash = {}
  elevators.each do |elevator_k, elevator_v|
    location = elevator_v['location']
    location_k = location.keys[0]
    location_v = location.values[0]
    currently = elevator_v['currently']
    direction = elevator_v['direction']
    destination = elevator_v['destination']

    about_to_reach_destination = false

    # Destination relative to location (d_rel_to_l)
    if destination == location_v
      d_rel_to_l = 'same_floor'
    else
      differential = destination - location_v

      if [-2, -1, 1, 2].include?(differential)
        d_rel_to_l = 'close'
      else
        d_rel_to_l = 'far'
      end

      if [-1, 1].include?(differential)
        about_to_reach_destination = true
      end
    end # if destination == location_v

    lookup_key = location_k + '_' + currently
    if currently == 'not_in_motion'
      lookup_key += '_' + d_rel_to_l
    end

    # Retrieve elevator advance helper via lookup
    eah = ELEVATOR_ADVANCE_HELPER[lookup_key]

    new_location_type = eah['new_location_type']
    new_value_for_currently = eah['new_value_for_currently']

    new_value_for_location = location_v
    if eah['move_by_one'] || about_to_reach_destination
      differential = destination - location_v

      if differential > 0
        new_value_for_location += 1
      end

      if differential < 0
        new_value_for_location -= 1
      end
    end

    if about_to_reach_destination
      new_location_type = 'about_to_reach_floor'

      if new_value_for_currently == 'moving_at_full_speed'
        new_value_for_currently = 'decelerating'
      end
    end

    new_value_for_direction = direction
    if !eah['direction_stays_the_same'] && direction == 'not_in_motion'
      differential = destination - location_v

      if differential > 0
        new_value_for_direction = 'up'
      end

      if differential < 0
        new_value_for_direction = 'down'
      end
    end
    if new_value_for_currently == 'not_in_motion'
      new_value_for_direction = 'not_in_motion'
    end

    new_elevators_hash[elevator_k] = {
      'location' => {new_location_type => new_value_for_location},
      'currently' => new_value_for_currently,
      'direction' => new_value_for_direction,
      'destination' => destination
    }
  end # elevator_k, elevator_v

  # Determine passenger list for each elevator
  passengers_per_elevator = {}

  elevators.keys.each do |elevator_id|
    passengers_per_elevator[elevator_id] = []
  end

  passengers.each do |passenger_k, passenger_v|
    if passenger_v['location'].has_key?('aboard_elevator')
      elevator_id = passenger_v['location']['aboard_elevator']
      passengers_per_elevator[elevator_id] << passenger_k
    end
  end

  # Disembark passengers who arrived at their destination
  passengers_per_elevator.each do |elevator_id, passenger_list|
    elevator = new_elevators_hash[elevator_id]
    if elevator['currently'] == 'not_in_motion'
      elevator_location_v = elevator['location'].values[0]
      passenger_list.each do |passenger_k|
        passenger_destination = passengers[passenger_k]['destination']
        if passenger_destination == elevator_location_v
          passengers.delete(passenger_k)
        end
      end # passenger_k
    end # if elevator['currently'] == 'not_in_motion'
  end # elevator_id, passenger_list

  game_state['elevators'] = new_elevators_hash

  game_state
end

def input_from_game_bot_is_needed(game_state)
  needed =
    game_state['elevators'].values.any? do |elevator_v|
      elevator_v['currently'] == 'not_in_motion'
    end

  needed
end

def incorporate_input_from_game_bot(
      game_state,
      embarked_passengers_and_elevator_destinations
    )
  eped = embarked_passengers_and_elevator_destinations

  eped.each do |eped_k, eped_v|
    elevator_id = eped_k.to_i

    eped_v['embark_passengers'].each do |p_id|
      game_state['passengers'][p_id]['location'] = {
        'aboard_elevator' => elevator_id
      }
    end

    game_state['elevators'][elevator_id]['destination'] =
      eped_v['set_destination']
  end

  game_state
end

def request_and_incorporate_input_from_game_bot(
      game_state,
      output_of_game_engine_input_of_player,
      output_of_player_input_of_game_engine
    )
  request = game_state.dup
  request['request'] = 'embark_passengers_and_set_destinations'
  raw_request = request.to_json

  $stderr.puts "INFO: I am sending the following request to the game bot:" if DEBUG
  $stderr.puts raw_request if DEBUG

  send_raw_json_to_player(
    output_of_game_engine_input_of_player,
    raw_request
  )

  raw_response =
    read_raw_json(
      output_of_player_input_of_game_engine
    )

  $stderr.puts "INFO: I have received the following response from the game bot:" if DEBUG
  $stderr.puts raw_response if DEBUG

  parsed_response =
    parse_raw_json(
      raw_response
    )

  verify_embarked_passengers_and_elevator_destinations(
    parsed_response,
    game_state
  )

  embarked_passengers_and_elevator_destinations =
    parsed_response.dup

  game_state =
    incorporate_input_from_game_bot(
      game_state,
      embarked_passengers_and_elevator_destinations
    )

  game_state
end

def start_game
  output_of_game_engine_input_of_player = ARGV.shift
  output_of_player_input_of_game_engine = ARGV.shift
  screen_name_of_contestant = ARGV.shift

  scenario_json_hash = {}
  ARGV.each do |scenario_json_file|
    scenario_json_hash[scenario_json_file] = :dummy
  end

  progress_log = {
    'contestant' => screen_name_of_contestant,
    'scenarios_processed' => 0,
    'per_scenario_performance' => {},
    'overall_seconds_elapsed' => 0
  }

  begin
    verify_that_argument_is_a_named_pipe(
      output_of_game_engine_input_of_player
    )

    verify_that_argument_is_a_named_pipe(
      output_of_player_input_of_game_engine
    )

    scenario_json_hash.each_key do |scenario_json_file|
      verify_that_scenario_file_exists(
        scenario_json_file
      )

      raw_scenario_json = read_raw_json(
                            scenario_json_file
                          )

      parsed_scenario_json = parse_raw_json(
                               raw_scenario_json
                             )

      verify_scenario(
        parsed_scenario_json
      )

      scenario_json_hash[scenario_json_file] = parsed_scenario_json
    end

    write_progress_log_to_disk(
      progress_log
    )

    scenario_json_hash.each do |scenario_json_file, scenario|
      request = {
        'request' => 'set_standby_locations',
        'number_of_floors' => scenario['number_of_floors'],
        'number_of_elevators' => scenario['number_of_elevators'],
        'carrying_capacity_of_one_elevator' => scenario['carrying_capacity_of_one_elevator']
      }
      raw_request = request.to_json

      $stderr.puts "INFO: I am sending the following request to the game bot:" if DEBUG
      $stderr.puts raw_request if DEBUG

      send_raw_json_to_player(
        output_of_game_engine_input_of_player,
        raw_request
      )

      raw_response = read_raw_json(
                       output_of_player_input_of_game_engine
                     )

      $stderr.puts "INFO: I have received the following response from the game bot:" if DEBUG
      $stderr.puts raw_response if DEBUG

      parsed_response = parse_raw_json(
                          raw_response
                        )

      verify_standby_locations(
        parsed_response,
        scenario
      )

      standby_locations = parsed_response.dup

      elevators = {}
      standby_locations.each do |standby_l_k, standby_l_v|
        at_floor = standby_l_v['set_standby_location']
        elevators[standby_l_k.to_i] = {
          'location' => {'at_floor' => at_floor},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => at_floor
        }
      end

      game_state = {
        'number_of_floors' => scenario['number_of_floors'],
        'number_of_elevators' => scenario['number_of_elevators'],
        'carrying_capacity_of_one_elevator' => scenario['carrying_capacity_of_one_elevator']
      }

      seconds_elapsed = 0

      scenario['traffic_patterns'].each do |traffic_pattern_id, list_of_passenger_waves|
        game_state['elevators'] = elevators.dup
        game_state['passengers'] = {}
          loop do
            verify_game_state_consistency(
              game_state
            )

            passenger_wave = {}
            if seconds_elapsed % INTERVAL_BETWEEN_PASSENGER_WAVES == 0
              passenger_wave = list_of_passenger_waves.shift
              passenger_wave = {} if passenger_wave.nil?
            end

            game_state['passengers'].merge!(passenger_wave)

            verify_game_state_consistency(
              game_state
            )

            if input_from_game_bot_is_needed(game_state)
              game_state = request_and_incorporate_input_from_game_bot(
                             game_state,
                             output_of_game_engine_input_of_player,
                             output_of_player_input_of_game_engine
                           )

              verify_game_state_consistency(
                game_state
              )
            end

            game_state = on_clock_tick(game_state)

            seconds_elapsed += 1

            break if game_state['passengers'].empty?
          end # loop do
      end # list_of_passenger_waves

      progress_log['scenarios_processed'] += 1
      progress_log['per_scenario_performance']['scenario_json_file'] =
        {'seconds_elapsed' => seconds_elapsed}
      progress_log['overall_seconds_elapsed'] += seconds_elapsed
      write_progress_log_to_disk(
        progress_log
      )
    end # scenario_json_file
  rescue GameEngineError => e
    $stderr.puts e.class::MESSAGE
  end
  puts progress_log.to_json
end

