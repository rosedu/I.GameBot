def set_standby_locations(
      number_of_floors,
      number_of_elevators,
      carrying_capacity_of_one_elevator
    )
  response = {}

  (0..number_of_elevators-1).to_a.each do |elevator_id|
    response[elevator_id] = {'set_standby_location' => 0}
  end

  response
end

def embark_passengers_and_set_destinations(
      number_of_floors,
      number_of_elevators,
      carrying_capacity_of_one_elevator,
      passengers,
      elevators
    )

  response = {}

  passengers_per_elevator = {}
  passengers_per_floor = {}

  elevators.keys.each do |elevator_id|
    passengers_per_elevator[elevator_id.to_i] = []
  end

  (0..number_of_floors-1).to_a.each do |floor_id|
    passengers_per_floor[floor_id] = []
  end

  passengers.each do |passenger_k, passenger_v|
    if passenger_v['location'].has_key?('aboard_elevator')
      elevator_id = passenger_v['location']['aboard_elevator']

      passengers_per_elevator[elevator_id] << passenger_k
    else
      floor_id = passenger_v['location']['at_floor']

      passengers_per_floor[floor_id] << passenger_k
    end
  end

  elevators_not_in_motion =
    elevators.select do |elevator_id, elevator_hash|
      elevator_hash['currently'] == 'not_in_motion'
    end

  elevators_not_in_motion.each do |elevator_id, elevator_hash|
    passenger_list = passengers_per_elevator[elevator_id.to_i]
    if !passenger_list.empty?
      passenger_who_is_aboard = passenger_list[0]

      destination = passengers[passenger_who_is_aboard]['destination']

      response[elevator_id] = {
        'embark_passengers' => [],
        'set_destination' => destination
      }

      return response
    end
  end

  elevators_not_in_motion.each do |elevator_id, elevator_hash|
    elevator_is_at_floor = elevator_hash['location']['at_floor']

    if !passengers_per_floor[elevator_is_at_floor].empty?
      passenger_to_embark = passengers_per_floor[elevator_is_at_floor][0]

      destination = passengers[passenger_to_embark]['destination']

      response[elevator_id] = {
        'embark_passengers' => [passenger_to_embark],
        'set_destination' => destination
      }

      return response
    end
  end

  elevator_id = elevators_not_in_motion.keys[0]
  response[elevator_id] = {
    'embark_passengers' => [],
    'set_destination' => 0
  }
  passengers_per_floor.each do |floor_id, passenger_list|
    if !passenger_list.empty?
      response[elevator_id]['set_destination'] = floor_id
    end
  end

  response
end

