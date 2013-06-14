def set_standby_locations(
        number_of_floors,
        number_of_elevators,
        carrying_capacity_of_one_elevator
    ):

    response = {}

    for elevator_id in range(0, number_of_elevators):

        response[elevator_id] = {'set_standby_location': 0}

    return response

def embark_passengers_and_set_destinations(
        number_of_floors,
        number_of_elevators,
        carrying_capacity_of_one_elevator,
        passengers,
        elevators
    ):

    response = {}

    passengers_per_elevator = {}
    passengers_per_floor = {}

    for elevator_id in elevators.keys():

        passengers_per_elevator[elevator_id] = []

    for floor_id in range(0, number_of_floors):

        passengers_per_floor[floor_id] = []

    for passenger_k, passenger_v in passengers.items():

        if 'aboard_elevator' in passenger_v['location']:

            elevator_id = passenger_v['location']['aboard_elevator']

            passengers_per_elevator[elevator_id].append(passenger_k)

        else:

            floor_id = passenger_v['location']['at_floor']

            passengers_per_floor[floor_id].append(passenger_k)

    elevators_not_in_motion = {
        elevator_id: elevator_hash
        for elevator_id, elevator_hash in elevators.items()
        if elevator_hash['currently'] == 'not_in_motion'
    }

    for elevator_id, elevator_hash in elevators_not_in_motion.items():

        passenger_list = \
            passengers_per_elevator[elevator_id]

        if len(passenger_list) > 0:

            passenger_who_is_aboard = passenger_list[0]

            destination = \
                passengers[passenger_who_is_aboard]['destination']

            response[elevator_id] = {
                'embark_passengers': [],
                'set_destination': destination
            }

            return response

    for elevator_id, elevator_hash in elevators_not_in_motion.items():

        elevator_is_at_floor = elevator_hash['location']['at_floor']

        if len(passengers_per_floor[elevator_is_at_floor]) > 0:
            passenger_to_embark = passengers_per_floor[elevator_is_at_floor][0]

            destination = passengers[passenger_to_embark]['destination']

            response[elevator_id] = {
                'embark_passengers': [passenger_to_embark],
                'set_destination': destination
            }

            return response

    elevator_id = elevators_not_in_motion.keys()[0]

    response[elevator_id] = {
        'embark_passengers': [],
        'set_destination': 0
    }

    for floor_id, passenger_list in passengers_per_floor.items():

        if len(passenger_list) > 0:

            response[elevator_id]['set_destination'] = floor_id

    return response

