class GameEngineError < StandardError
end

class ArgumentIsNotANamedPipeError < GameEngineError
  MESSAGE = 'ERROR: At least one of the first two arguments is not a named pipe.'
end

class UnexpectedFileAccessError < GameEngineError
  MESSAGE = 'ERROR: Unexpected file access error.'
end

class ResponseNotInJSONFormatError < GameEngineError
  MESSAGE = 'ERROR: The response I received from the game bot is not in JSON format.'
end

class ScenarioFileNotFoundError < GameEngineError
  MESSAGE = 'ERROR: Could not locate specified scenario file.'
end

class ScenarioIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: The data stored in the scenario file is not a hash.'
end

class ScenarioIsAHashOfSizeOtherThanFourError < GameEngineError
  MESSAGE = 'ERROR: Scenario data is a hash of size other than 4.'
end

class NoSuchKeyNumberOfFloorsError < GameEngineError
  MESSAGE = 'ERROR: No such key: number_of_floors.'
end

class NumberOfFloorsIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: number_of_floors is not of type Fixnum (integer).'
end

class NumberOfFloorsIsNotGreaterThanOneError < GameEngineError
  MESSAGE = 'ERROR: number_of_floors is not greater than one.'
end

class NoSuchKeyNumberOfElevatorsError < GameEngineError
  MESSAGE = 'ERROR: No such key: number_of_elevators.'
end

class NumberOfElevatorsIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: number_of_elevators is not of type Fixnum (integer).'
end

class NumberOfElevatorsIsNotGreaterThanZeroError < GameEngineError
  MESSAGE = 'ERROR: number_of_elevators is not greater than zero.'
end

class NoSuchKeyCarryingCapacityError < GameEngineError
  MESSAGE = 'ERROR: No such key: carrying_capacity_of_one_elevator.'
end

class CarryingCapacityIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: carrying_capacity_of_one_elevator is not of type Fixnum (integer).'
end

class CarryingCapacityIsNotGreaterThanZeroError < GameEngineError
  MESSAGE = 'ERROR: carrying_capacity_of_one_elevator is not greater than zero.'
end

class NoSuchKeyTrafficPatternsError < GameEngineError
  MESSAGE = 'ERROR: No such key: traffic_patterns.'
end

class TrafficPatternsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: The traffic_patterns key does not point to a hash.'
end

class TrafficPatternKeyNotAStringError < GameEngineError
  MESSAGE = 'ERROR: At least one traffic pattern key is not a string.'
end

class TrafficPatternValueNotAnArrayError < GameEngineError
  MESSAGE = 'ERROR: At least one traffic pattern key does not point to an array.'
end

class FoundANonHashWhereAWaveShouldBeError < GameEngineError
  MESSAGE = 'ERROR: Found a non-hash where a passenger wave should be.'
end

class FoundANonStringWhereAPassengerIDShouldBeError < GameEngineError
  MESSAGE = 'ERROR: Found a non-string where a passenger ID should be.'
end

class PassengerIDHasWrongLengthError < GameEngineError
  MESSAGE = 'ERROR: Found a passenger ID of wrong length.'
end

class PassengerIDHasWrongPrefixError < GameEngineError
  MESSAGE = 'ERROR: Found a passenger ID with the wrong prefix.'
end

class PassengerDataIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Found passenger data that is not a hash.'
end

class PassengerDataHashIsNotOfSizeTwoError < GameEngineError
  MESSAGE = 'ERROR: Found a passenger data hash with a size other than 2.'
end

class NoSuchKeyLocationError < GameEngineError
  MESSAGE = 'ERROR: No such key: location.'
end

class LocationIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: The location does not point to a hash.'
end

class LocationHashIsNotOfSizeOneError < GameEngineError
  MESSAGE = 'ERROR: The location hash is not of size 1.'
end

class NoSuchKeyAtFloorError < GameEngineError
  MESSAGE = 'ERROR: No such key: at_floor.'
end

class AtFloorIsNotAFixnumError < GameEngineError
  MESSAGE = 'ERROR: at_floor is not a Fixnum (integer).'
end

class AtFloorIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: at_floor is out of bounds.'
end

class NoSuchKeyDestinationError < GameEngineError
  MESSAGE = 'ERROR: No such key: destination.'
end

class DestinationIsNotAFixnumError < GameEngineError
  MESSAGE = 'ERROR: destination is not a Fixnum (integer).'
end

class DestinationIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: destination is out of bounds.'
end

class PassengersAlreadyAtTheirDestinationsError < GameEngineError
  MESSAGE = 'ERROR: Found passengers who are already at their destination.'
end

class PassengerIDsAreNotUniqueAcrossWavesError < GameEngineError
  MESSAGE = 'ERROR: Passenger IDs are not unique across waves.'
end

class StandbyLocationsDataIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Standby locations data is not a hash.'
end

class StandbyLocationsHashIsOfWrongSizeError < GameEngineError
  MESSAGE = 'ERROR: Standby locations hash is of wrong size.'
end

class WrongElevatorIDError < GameEngineError
  MESSAGE = 'ERROR: Wrong elevator ID.'
end

class ElevatorIDDoesNotPointToAHashError < GameEngineError
  MESSAGE = 'ERROR: Elevator ID does not point to a hash.'
end

class ElevatorHashIsOfWrongSizeError < GameEngineError
  MESSAGE = 'ERROR: Elevator hash is of wrong size.'
end

class NoSuchKeySetStandbyLocationError < GameEngineError
  MESSAGE = 'ERROR: No such key: set_standby_location.'
end

class StandbyLocationIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: set_standby_location is not of type Fixnum (integer).'
end

class StandbyLocationIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: Out of bounds: set_standby_location.'
end

class EmbarkDataIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Embark and destination data received from game bot is not a hash.'
end

class SpecifiedElevatorIsCurrentlyInMotionError < GameEngineError
  MESSAGE = 'ERROR: The specified elevator is currently in motion.'
end

class NoSuchKeyEmbarkPassengersError < GameEngineError
  MESSAGE = 'ERROR: No such key: embark_passengers.'
end

class EmbarkPassengersValueNotAnArrayError < GameEngineError
  MESSAGE = 'ERROR: At least one embark_passengers key does not point to an array.'
end

class CarryingCapacityExceededError < GameEngineError
  MESSAGE = 'ERROR: Carrying capacity exceeded.'
end

class PassengerToEmbarkNotFoundError < GameEngineError
  MESSAGE = 'ERROR: Passenger to embark not found.'
end

class DuplicatePassengersToEmbarkError < GameEngineError
  MESSAGE = 'ERROR: Duplicate passengers to embark.'
end

class PassengerToEmbarkIsAlreadyAboardAnElevatorError < GameEngineError
  MESSAGE = 'ERROR: Passenger to embark is already aboard an elevator.'
end

class PassengerToEmbarkIsNotWhereTheElevatorIsError < GameEngineError
  MESSAGE = 'ERROR: Passenger to embark is not at the same floor as the elevator.'
end

class NoSuchKeySetDestinationError < GameEngineError
  MESSAGE = 'ERROR: No such key: set_destination.'
end

class SetDestinationIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: set_destination is not of type Fixnum (integer).'
end

class SetDestinationIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: set_destination is out of bounds.'
end

class GameStateConsistencyCheckFailedError < GameEngineError
  MESSAGE = 'ERROR: Game state consistency check failed.'
end


