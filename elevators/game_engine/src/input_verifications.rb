PASSENGER_ID_LENGTH = 26

def verify_that_argument_is_a_named_pipe(arg)
  valid_arg = File.exists?(arg) && File.ftype(arg) == 'fifo'
  if !valid_arg
    $stderr.puts 'ARGUMENT: ' + arg if DEBUG
    raise ArgumentIsNotANamedPipeError
  end
end

def verify_that_scenario_file_exists(file_handle)
  valid_arg = File.exists?(file_handle) && File.file?(file_handle)
  if !valid_arg
    $stderr.puts 'SCENARIO FILE: ' + file_handle if DEBUG
    raise ScenarioFileNotFoundError
  end
end

def extract_passenger_count_per_elevator(game_state)
  passenger_count_per_elevator = {}

  game_state['elevators'].keys.each do |elevator_id|
    passenger_count_per_elevator[elevator_id] = 0
  end

  game_state['passengers'].each do |passenger_k, passenger_v|
    if passenger_v['location'].has_key?('aboard_elevator')
      passenger_count_per_elevator[passenger_v['location']['aboard_elevator']] += 1
    end
  end

  passenger_count_per_elevator
end

def verify_scenario(parsed_scenario_json)
  if !parsed_scenario_json.is_a?(Hash)
    raise ScenarioIsNotAHashError
  end

  if parsed_scenario_json.size != 4
    raise ScenarioIsAHashOfSizeOtherThanFourError
  end

  if !parsed_scenario_json.has_key?('number_of_floors')
    raise NoSuchKeyNumberOfFloorsError
  end

  number_of_floors = parsed_scenario_json['number_of_floors']

  if !number_of_floors.is_a?(Fixnum)
    raise NumberOfFloorsIsNotOfTypeFixnumError
  end

  if number_of_floors <= 1
    raise NumberOfFloorsIsNotGreaterThanOneError
  end

  if !parsed_scenario_json.has_key?('number_of_elevators')
    raise NoSuchKeyNumberOfElevatorsError
  end

  if !parsed_scenario_json['number_of_elevators'].is_a?(Fixnum)
    raise NumberOfElevatorsIsNotOfTypeFixnumError
  end

  if parsed_scenario_json['number_of_elevators'] <= 0
    raise NumberOfElevatorsIsNotGreaterThanZeroError
  end

  if !parsed_scenario_json.has_key?('carrying_capacity_of_one_elevator')
    raise NoSuchKeyCarryingCapacityError
  end

  if !parsed_scenario_json['carrying_capacity_of_one_elevator'].is_a?(Fixnum)
    raise CarryingCapacityIsNotOfTypeFixnumError
  end

  if parsed_scenario_json['carrying_capacity_of_one_elevator'] <= 0
    raise CarryingCapacityIsNotGreaterThanZeroError
  end

  if !parsed_scenario_json.has_key?('traffic_patterns')
    raise NoSuchKeyTrafficPatternsError
  end

  if !parsed_scenario_json['traffic_patterns'].is_a?(Hash)
    raise TrafficPatternsNotAHashError
  end

  parsed_scenario_json['traffic_patterns'].each do |tpk, tpv|
    if !tpk.is_a?(String)
      raise TrafficPatternKeyNotAStringError
    end

    if !tpv.is_a?(Array)
      raise TrafficPatternValueNotAnArrayError
    end

    passenger_ids_hash = {}
    tpv.each do |wave|
      if !wave.is_a?(Hash)
        raise FoundANonHashWhereAWaveShouldBeError
      end

      wave.each do |wave_k, wave_v|
        if !wave_k.is_a?(String)
          raise FoundANonStringWhereAPassengerIDShouldBeError
        end

        if wave_k.size != PASSENGER_ID_LENGTH
          raise PassengerIDHasWrongLengthError
        end

        if !wave_k.match(/^passenger_/)
          raise PassengerIDHasWrongPrefixError
        end

        if passenger_ids_hash.has_key?(wave_k)
          raise PassengerIDsAreNotUniqueAcrossWavesError
        else
          passenger_ids_hash[wave_k] = :dummy
        end

        if !wave_v.is_a?(Hash)
          raise PassengerDataIsNotAHashError
        end

        if wave_v.size != 2
          raise PassengerDataHashIsNotOfSizeTwoError
        end

        if !wave_v.has_key?('location')
          raise NoSuchKeyLocationError
        end

        if !wave_v['location'].is_a?(Hash)
          raise LocationIsNotAHashError
        end

        if wave_v['location'].size != 1
          raise LocationHashIsNotOfSizeOneError
        end

        if !wave_v['location'].has_key?('at_floor')
          raise NoSuchKeyAtFloorError
        end

        at_floor = wave_v['location']['at_floor']

        if !at_floor.is_a?(Fixnum)
          raise AtFloorIsNotAFixnumError
        end

        if !at_floor.between?(0, number_of_floors - 1)
          raise AtFloorIsOutOfBoundsError
        end

        if !wave_v.has_key?('destination')
          raise NoSuchKeyDestinationError
        end

        destination = wave_v['destination']

        if !destination.is_a?(Fixnum)
          raise DestinationIsNotAFixnumError
        end

        if !destination.between?(0, number_of_floors - 1)
          raise DestinationIsOutOfBoundsError
        end

        if at_floor == destination
          raise PassengersAlreadyAtTheirDestinationsError
        end
      end # wave_k, wave_v
    end # wave
  end # tpk, tpv
end

def verify_standby_locations(
      parsed_response,
      parsed_scenario_json
    )
  number_of_floors = parsed_scenario_json['number_of_floors']
  number_of_elevators = parsed_scenario_json['number_of_elevators']

  stringified_elevator_ids_hash = {}
  (0..number_of_elevators-1).each do |elevator_id|
    stringified_elevator_ids_hash[elevator_id.to_s] = :dummy
  end

  if !parsed_response.is_a?(Hash)
    raise StandbyLocationsDataIsNotAHashError
  end

  if parsed_response.size != number_of_elevators
    raise StandbyLocationsHashIsOfWrongSizeError
  end

  parsed_response.each do |standby_l_k, standby_l_v|
    if !stringified_elevator_ids_hash.has_key?(standby_l_k)
      raise WrongElevatorIDError
    end

    if !standby_l_v.is_a?(Hash)
      raise ElevatorIDDoesNotPointToAHashError
    end

    if standby_l_v.size != 1
      raise ElevatorHashIsOfWrongSizeError
    end

    if !standby_l_v.has_key?('set_standby_location')
      raise NoSuchKeySetStandbyLocationError
    end

    standby_location = standby_l_v['set_standby_location']

    if !standby_location.is_a?(Fixnum)
      raise StandbyLocationIsNotOfTypeFixnumError
    end

    if !standby_location.between?(0, number_of_floors - 1)
      raise StandbyLocationIsOutOfBoundsError
    end
  end # standby_l_k, standby_l_v
end

def verify_embarked_passengers_and_elevator_destinations(
      parsed_response,
      game_state
    )
  number_of_floors = game_state['number_of_floors']
  number_of_elevators = game_state['number_of_elevators']
  carrying_capacity_of_one_elevator = game_state['carrying_capacity_of_one_elevator']

  stringified_elevator_ids_hash = {}
  (0..number_of_elevators-1).each do |elevator_id|
    stringified_elevator_ids_hash[elevator_id.to_s] = :dummy
  end

  if !parsed_response.is_a?(Hash)
    raise EmbarkDataIsNotAHashError
  end

  passengers = game_state['passengers']

  passenger_count_per_elevator =
    extract_passenger_count_per_elevator(game_state)

  parsed_response.each do |parsed_r_k, parsed_r_v|
    if !stringified_elevator_ids_hash.has_key?(parsed_r_k)
      raise WrongElevatorIDError
    end

    elevator_id = parsed_r_k.to_i
    elevator = game_state['elevators'][elevator_id]

    if elevator['currently'] != 'not_in_motion'
      raise SpecifiedElevatorIsCurrentlyInMotionError
    end

    at_floor_e = elevator['location']['at_floor']

    if !parsed_r_v.is_a?(Hash)
      raise ElevatorIDDoesNotPointToAHashError
    end

    if parsed_r_v.size != 2
      raise ElevatorHashIsOfWrongSizeError
    end

    if !parsed_r_v.has_key?('embark_passengers')
      raise NoSuchKeyEmbarkPassengersError
    end

    to_embark = parsed_r_v['embark_passengers']

    if !to_embark.is_a?(Array)
      raise EmbarkPassengersValueNotAnArrayError
    end

    how_many_passengers_to_embark = to_embark.size
    if carrying_capacity_of_one_elevator < how_many_passengers_to_embark +
                                           passenger_count_per_elevator[elevator_id]
      raise CarryingCapacityExceededError
    end

    if to_embark.uniq.size != to_embark.size
      raise DuplicatePassengersToEmbarkError
    end

    to_embark.each do |passenger_to_embark|
      if !game_state['passengers'].has_key?(passenger_to_embark)
        raise PassengerToEmbarkNotFoundError
      end

      if !game_state['passengers'][passenger_to_embark]['location'].has_key?('at_floor')
        raise PassengerToEmbarkIsAlreadyAboardAnElevatorError
      end

      at_floor_p = game_state['passengers'][passenger_to_embark]['location']['at_floor']

      if at_floor_p != at_floor_e
        raise PassengerToEmbarkIsNotWhereTheElevatorIsError
      end
    end

    if !parsed_r_v.has_key?('set_destination')
      raise NoSuchKeySetDestinationError
    end

    if !parsed_r_v['set_destination'].is_a?(Fixnum)
      raise SetDestinationIsNotOfTypeFixnumError
    end

    if !parsed_r_v['set_destination'].between?(0, number_of_floors - 1)
      raise SetDestinationIsOutOfBoundsError
    end
  end # parsed_r_k, parsed_r_v
end

def verify_game_state_consistency(
      game_state
    )
  if !game_state.is_a?(Hash)
    raise GameStateConsistencyCheckFailedError
  end

  if game_state.size != 5
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state.has_key?('number_of_floors')
    raise GameStateConsistencyCheckFailedError
  end

  number_of_floors =
    game_state['number_of_floors']

  if !number_of_floors.is_a?(Fixnum)
    raise GameStateConsistencyCheckFailedError
  end

  if number_of_floors <= 1
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state.has_key?('number_of_elevators')
    raise GameStateConsistencyCheckFailedError
  end

  number_of_elevators =
    game_state['number_of_elevators']

  if !number_of_elevators.is_a?(Fixnum)
    raise GameStateConsistencyCheckFailedError
  end

  if number_of_elevators <= 0
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state.has_key?('carrying_capacity_of_one_elevator')
    raise GameStateConsistencyCheckFailedError
  end

  carrying_capacity_of_one_elevator =
    game_state['carrying_capacity_of_one_elevator']

  if !carrying_capacity_of_one_elevator.is_a?(Fixnum)
    raise GameStateConsistencyCheckFailedError
  end

  if carrying_capacity_of_one_elevator <= 0
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state.has_key?('passengers')
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state['passengers'].is_a?(Hash)
    raise GameStateConsistencyCheckFailedError
  end

  game_state['passengers'].each do |passenger_k, passenger_v|
    if !passenger_k.is_a?(String)
      raise GameStateConsistencyCheckFailedError
    end

    if passenger_k.size != PASSENGER_ID_LENGTH
      raise GameStateConsistencyCheckFailedError
    end

    if !passenger_k.match(/^passenger_/)
      raise GameStateConsistencyCheckFailedError
    end

    if !passenger_v.is_a?(Hash)
      raise GameStateConsistencyCheckFailedError
    end

    if passenger_v.size != 2
      raise GameStateConsistencyCheckFailedError
    end

    if !passenger_v.has_key?('destination')
      raise GameStateConsistencyCheckFailedError
    end

    destination = passenger_v['destination']

    if !destination.is_a?(Fixnum)
      raise GameStateConsistencyCheckFailedError
    end

    if !destination.between?(0, number_of_floors - 1)
      raise GameStateConsistencyCheckFailedError
    end

    if !passenger_v.has_key?('location')
      raise GameStateConsistencyCheckFailedError
    end

    location = passenger_v['location']

    if !location.is_a?(Hash)
      raise GameStateConsistencyCheckFailedError
    end

    if location.size != 1
      raise GameStateConsistencyCheckFailedError
    end

    is_location_of_type_at_floor =
      location.has_key?('at_floor')
    is_location_of_type_aboard_elevator =
      location.has_key?('aboard_elevator')
    is_location_valid =
      is_location_of_type_at_floor ||
      is_location_of_type_aboard_elevator

    if !is_location_valid
      raise GameStateConsistencyCheckFailedError
    end

    if is_location_of_type_at_floor
      at_floor = location['at_floor']

      if !at_floor.is_a?(Fixnum)
        raise GameStateConsistencyCheckFailedError
      end

      if !at_floor.between?(0, number_of_floors - 1)
        raise GameStateConsistencyCheckFailedError
      end

      if at_floor == destination
        raise GameStateConsistencyCheckFailedError
      end
    end

    if is_location_of_type_aboard_elevator
      aboard_elevator = location['aboard_elevator']

      if !aboard_elevator.is_a?(Fixnum)
        raise GameStateConsistencyCheckFailedError
      end

      if !aboard_elevator.between?(0, number_of_elevators - 1)
        raise GameStateConsistencyCheckFailedError
      end
    end
  end # passenger_k, passenger_v

  if !game_state.has_key?('elevators')
    raise GameStateConsistencyCheckFailedError
  end

  if !game_state['elevators'].is_a?(Hash)
    raise GameStateConsistencyCheckFailedError
  end

  if game_state['elevators'].size != number_of_elevators
    raise GameStateConsistencyCheckFailedError
  end

  passenger_count_per_elevator =
    extract_passenger_count_per_elevator(game_state)

  passenger_count_per_elevator.each do |elevator_id, p_count|
    if p_count > carrying_capacity_of_one_elevator
      raise GameStateConsistencyCheckFailedError
    end
  end

  game_state['elevators'].each do |elevator_k, elevator_v|
    if !elevator_k.is_a?(Fixnum)
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_k.between?(0, number_of_elevators - 1)
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_v.is_a?(Hash)
      raise GameStateConsistencyCheckFailedError
    end

    if elevator_v.size != 4
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_v.has_key?('location')
      raise GameStateConsistencyCheckFailedError
    end

    location = elevator_v['location']

    if !location.is_a?(Hash)
      raise GameStateConsistencyCheckFailedError
    end

    if location.size != 1
      raise GameStateConsistencyCheckFailedError
    end

    l_k = location.keys[0]
    l_v = location.values[0]

    possible_location_types = [
      'at_floor',
      'just_left_floor',
      'about_to_reach_floor'
    ]

    if !possible_location_types.include?(l_k)
      raise GameStateConsistencyCheckFailedError
    end

    if !l_v.is_a?(Fixnum)
      raise GameStateConsistencyCheckFailedError
    end

    if !l_v.between?(0, number_of_floors - 1)
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_v.has_key?('currently')
      raise GameStateConsistencyCheckFailedError
    end

    currently = elevator_v['currently']

    possible_values_for_currently = [
      'not_in_motion',
      'moving_at_full_speed',
      'moving_at_half_speed',
      'accelerating',
      'decelerating'
    ]

    if !possible_values_for_currently.include?(currently)
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_v.has_key?('direction')
      raise GameStateConsistencyCheckFailedError
    end

    direction = elevator_v['direction']

    possible_values_for_direction = [
      'not_in_motion',
      'up',
      'down'
    ]

    if !possible_values_for_direction.include?(direction)
      raise GameStateConsistencyCheckFailedError
    end

    if !elevator_v.has_key?('destination')
      raise GameStateConsistencyCheckFailedError
    end

    destination = elevator_v['destination']

    if !destination.is_a?(Fixnum)
      raise GameStateConsistencyCheckFailedError
    end

    if !destination.between?(0, number_of_floors - 1)
      raise GameStateConsistencyCheckFailedError
    end

    if direction == 'up' && destination < location.values[0]
      raise GameStateConsistencyCheckFailedError
    end

    if direction == 'down' && destination > location.values[0]
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'moving_at_half_speed' &&
       ![-2, -1, 0, 1, 2].include?(destination - location.values[0])
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'not_in_motion' &&
       direction != 'not_in_motion'
      raise GameStateConsistencyCheckFailedError
    end

    if direction == 'not_in_motion' &&
       currently != 'not_in_motion'
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'not_in_motion' &&
       location.keys[0] != 'at_floor'
      raise GameStateConsistencyCheckFailedError
    end

    if destination == location.values[0] &&
       !['at_floor','about_to_reach_floor'].include?(location.keys[0])
      raise GameStateConsistencyCheckFailedError
    end

    if location.has_key?('just_left_floor') &&
       !['accelerating','moving_at_half_speed'].include?(currently)
      raise GameStateConsistencyCheckFailedError
    end

    if location.has_key?('about_to_reach_floor') &&
       !['decelerating','moving_at_half_speed'].include?(currently)
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'accelerating' &&
       !location.has_key?('just_left_floor')
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'decelerating' &&
       !location.has_key?('about_to_reach_floor')
      raise GameStateConsistencyCheckFailedError
    end

    if currently == 'decelerating' &&
       destination != location['about_to_reach_floor']
      raise GameStateConsistencyCheckFailedError
    end

    if ['up','down'].include?(direction) &&
       currently == 'not_in_motion'
      raise GameStateConsistencyCheckFailedError
    end

    if location.has_key?('at_floor') &&
       ['accelerating','decelerating'].include?(currently)
      raise GameStateConsistencyCheckFailedError
    end
  end # elevator_k, elevator_v
end

