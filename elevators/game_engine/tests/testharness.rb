require 'test/unit'
require './src/elevators_game_engine.rb'

DEBUG = false

class TestElevators < Test::Unit::TestCase
  def test_correctness_of_verify_scenario_01
    # Define input
    scenario = []

    # State our expectation about the result of the transformation
    assert_raise(ScenarioIsNotAHashError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_02
    # Define input
    scenario = {}

    # State our expectation about the result of the transformation
    assert_raise(ScenarioIsAHashOfSizeOtherThanFourError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_03
    # Define input
    scenario = {
      'abc' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyNumberOfFloorsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_04
    # Define input
    scenario = {
      'number_of_floors' => [],
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NumberOfFloorsIsNotOfTypeFixnumError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_05
    # Define input
    scenario = {
      'number_of_floors' => 1,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NumberOfFloorsIsNotGreaterThanOneError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_06
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'abc' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyNumberOfElevatorsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_07
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => [],
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NumberOfElevatorsIsNotOfTypeFixnumError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_08
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 0,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NumberOfElevatorsIsNotGreaterThanZeroError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_09
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'abc' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyCarryingCapacityError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_10
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => [],
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(CarryingCapacityIsNotOfTypeFixnumError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_11
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 0,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(CarryingCapacityIsNotGreaterThanZeroError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_12
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'abc' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyTrafficPatternsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_13
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TrafficPatternsNotAHashError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_14
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        1 => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(TrafficPatternKeyNotAStringError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_15
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => 1
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(TrafficPatternValueNotAnArrayError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_16
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [{}, 1]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(FoundANonHashWhereAWaveShouldBeError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_17
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            1 => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(FoundANonStringWhereAPassengerIDShouldBeError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_18
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerIDHasWrongLengthError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_19
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            '#assenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerIDHasWrongPrefixError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_20
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => []
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerDataIsNotAHashError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_21
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {}
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerDataHashIsNotOfSizeTwoError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_22
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'abc' => {'at_floor' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyLocationError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_23
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => 1,
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(LocationIsNotAHashError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_24
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(LocationHashIsNotOfSizeOneError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_25
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'abc' => 91},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyAtFloorError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_26
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => []},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(AtFloorIsNotAFixnumError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_27
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 111},
              'destination' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(AtFloorIsOutOfBoundsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_28
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'abc' => 0
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyDestinationError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_29
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => []
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(DestinationIsNotAFixnumError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_30
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 111
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(DestinationIsOutOfBoundsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_30a
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 8},
              'destination' => 8
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 81
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengersAlreadyAtTheirDestinationsError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_scenario_31
    # Define input
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'traffic_patterns' => {
        'morning_rush' => [
          {
            'passenger_e889144ef05d5956' => {
              'location' => {'at_floor' => 0},
              'destination' => 18
            },
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 91},
              'destination' => 0
            }
          },
          {
            'passenger_3e8515d956424e5e' => {
              'location' => {'at_floor' => 52},
              'destination' => 71
            }
          }
        ]
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerIDsAreNotUniqueAcrossWavesError) do
      verify_scenario(scenario)
    end
  end

  def test_correctness_of_verify_standby_locations_01
    # Define input
    standby_locations = []
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(StandbyLocationsDataIsNotAHashError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_02
    # Define input
    standby_locations = {}
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(StandbyLocationsHashIsOfWrongSizeError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_03
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      'a' => {'set_standby_location' => 0}
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(WrongElevatorIDError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_04
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      '7' => []
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(ElevatorIDDoesNotPointToAHashError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_05
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      '7' => {}
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(ElevatorHashIsOfWrongSizeError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_06
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      '7' => {'abc' => 0}
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeySetStandbyLocationError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_07
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      '7' => {'set_standby_location' => []}
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(StandbyLocationIsNotOfTypeFixnumError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_verify_standby_locations_08
    # Define input
    standby_locations = {
      '0' => {'set_standby_location' => 0},
      '1' => {'set_standby_location' => 0},
      '2' => {'set_standby_location' => 0},
      '3' => {'set_standby_location' => 0},
      '4' => {'set_standby_location' => 0},
      '5' => {'set_standby_location' => 0},
      '6' => {'set_standby_location' => 0},
      '7' => {'set_standby_location' => 111}
    }
    scenario = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8
    }

    # State our expectation about the result of the transformation
    assert_raise(StandbyLocationIsOutOfBoundsError) do
      verify_standby_locations(
        standby_locations,
        scenario
      )
    end
  end

  def test_correctness_of_input_from_game_bot_is_needed_01
    # Define input
    game_state = {
      'elevators' => {}
    }

    # Apply transformation
    needed = input_from_game_bot_is_needed(game_state)

    # State our expectation about the result of the transformation
    assert(
      needed.is_a?(TrueClass) || needed.is_a?(FalseClass),
      failure_message =
        "Method input_from_game_bot_is_needed does not return a boolean as expected"
    )
  end

  def test_correctness_of_input_from_game_bot_is_needed_02
    # Define input
    game_state = {
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        }
      }
    }

    # Apply transformation
    needed = input_from_game_bot_is_needed(game_state)

    # State our expectation about the result of the transformation
    assert(
      needed,
      failure_message =
        "Method input_from_game_bot_is_needed does not return true as expected"
    )
  end

  def test_correctness_of_verify_eped_01
    # Define input
    parsed_response = []
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4
    }

    # State our expectation about the result of the transformation
    assert_raise(EmbarkDataIsNotAHashError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_02
    # Define input
    parsed_response = {
      'a' => {}
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 8,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(WrongElevatorIDError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_03
    # Define input
    parsed_response = {
      '0' => {}
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(SpecifiedElevatorIsCurrentlyInMotionError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_04
    # Define input
    parsed_response = {
      '1' => []
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(ElevatorIDDoesNotPointToAHashError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_05
    # Define input
    parsed_response = {
      '1' => {}
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(ElevatorHashIsOfWrongSizeError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_06
    # Define input
    parsed_response = {
      '1' => {
        'abc' => [],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeyEmbarkPassengersError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_07
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => 1,
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(EmbarkPassengersValueNotAnArrayError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_08
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [
          'passenger_e889144ef05d5956',
          'passenger_5088e9bad0b9f2c0'
        ],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 9},
          'destination' => 18
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(CarryingCapacityExceededError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_09
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [
          'passenger_0000000000000000'
        ],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 9},
          'destination' => 18
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerToEmbarkNotFoundError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_10
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [
          'passenger_e889144ef05d5956',
          'passenger_e889144ef05d5956'
        ],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 9},
          'destination' => 18
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(DuplicatePassengersToEmbarkError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_11
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [
          'passenger_e889144ef05d5956'
        ],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'aboard_elevator' => 0},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerToEmbarkIsAlreadyAboardAnElevatorError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_12
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [
          'passenger_e889144ef05d5956'
        ],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(PassengerToEmbarkIsNotWhereTheElevatorIsError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_13
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [],
        'abc' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(NoSuchKeySetDestinationError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_14
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [],
        'set_destination' => []
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(SetDestinationIsNotOfTypeFixnumError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_verify_eped_15
    # Define input
    parsed_response = {
      '1' => {
        'embark_passengers' => [],
        'set_destination' => 111
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {}
    }

    # State our expectation about the result of the transformation
    assert_raise(SetDestinationIsOutOfBoundsError) do
      verify_embarked_passengers_and_elevator_destinations(
        parsed_response,
        game_state
      )
    end
  end

  def test_correctness_of_incorporate_input_from_game_bot_01
    # Define input
    p_id = 'passenger_e889144ef05d5956'
    embarked_passengers_and_elevator_destinations = {
      '1' => {
        'embark_passengers' => [p_id],
        'set_destination' => 0
      }
    }
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        p_id => {
          'location' => {'at_floor' => 9},
          'destination' => 15
        }
      }
    }

    # Apply transformation
    game_state =
      incorporate_input_from_game_bot(
        game_state,
        embarked_passengers_and_elevator_destinations
      )

    # State our expectation about the result of the transformation
    assert_equal(
      {'aboard_elevator' => 1},
      game_state['passengers'][p_id]['location'],
      failure_message =
        "After incorporating input from game bot, the passenger is not aboard the elevator as expected"
    )
    assert_equal(
      0,
      game_state['elevators'][1]['destination'],
      failure_message =
        "After incorporating input from game bot, the destination is not set as expected"
    )
  end

  def test_correctness_of_verify_game_state_consistency_01
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'abc' => [],
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_02
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => [],
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_03
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        '0' => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_04
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        111 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_05
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => [],
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_06
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {},
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_07
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'abc' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_08
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => [],
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_09
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_10
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'abc' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_11
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => '3'},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_12
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 111},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_13
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'abc' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_14
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'abc',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_15
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'abc' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_16
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'abc',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_17
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'abc' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_18
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => '15'
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_19
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 111
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_20
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 3},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 15
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_21
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 1
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_22
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'moving_at_full_speed',
          'direction' => 'down',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_23
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'moving_at_half_speed',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_24
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'not_in_motion',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_25
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'moving_at_full_speed',
          'direction' => 'not_in_motion',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_26
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'just_left_floor' => 33},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_28
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'just_left_floor' => 33},
          'currently' => 'accelerating',
          'direction' => 'up',
          'destination' => 33
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_29
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'just_left_floor' => 33},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_30
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'about_to_reach_floor' => 88},
          'currently' => 'moving_at_full_speed',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_31
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'accelerating',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_32
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_33
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'about_to_reach_floor' => 33},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_34
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'not_in_motion',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_35
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'accelerating',
          'direction' => 'up',
          'destination' => 88
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_36
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 33},
          'currently' => 'accelerating',
          'direction' => 'up',
          'destination' => 33
        },
        1 => {
          'location' => {'at_floor' => 9},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 9
        },
        2 => {
          'location' => {'just_left_floor' => 55},
          'currently' => 'accelerating',
          'direction' => 'down',
          'destination' => 23
        },
        3 => {
          'location' => {'about_to_reach_floor' => 30},
          'currently' => 'decelerating',
          'direction' => 'up',
          'destination' => 30
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'at_floor' => 9},
          'destination' => 36
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 83
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 91
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_verify_game_state_consistency_37
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 1
        },
        1 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 2
        },
        2 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 3
        },
        3 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 4
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 8
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 2
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 2},
          'destination' => 3
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 3},
          'destination' => 4
        }
      }
    }

    # State our expectation about the result of the transformation
    assert_raise(GameStateConsistencyCheckFailedError) do
      verify_game_state_consistency(game_state)
    end
  end

  def test_correctness_of_on_clock_tick_01
    # Define input
    game_state = {
      'number_of_floors' => 100,
      'number_of_elevators' => 4,
      'carrying_capacity_of_one_elevator' => 4,
      'elevators' => {
        0 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 1
        },
        1 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 2
        },
        2 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 3
        },
        3 => {
          'location' => {'at_floor' => 1},
          'currently' => 'not_in_motion',
          'direction' => 'not_in_motion',
          'destination' => 4
        }
      },
      'passengers' => {
        'passenger_e889144ef05d5956' => {
          'location' => {'at_floor' => 8},
          'destination' => 15
        },
        'passenger_5088e9bad0b9f2c0' => {
          'location' => {'at_floor' => 9},
          'destination' => 69
        },
        'passenger_ad1022db8e72279e' => {
          'location' => {'aboard_elevator' => 1},
          'destination' => 2
        },
        'passenger_3f0c2ad8fe65831b' => {
          'location' => {'aboard_elevator' => 2},
          'destination' => 3
        },
        'passenger_81259694f038d55f' => {
          'location' => {'aboard_elevator' => 3},
          'destination' => 4
        }
      }
    }

    verify_game_state_consistency(game_state)

    # Apply first transformation
    game_state = on_clock_tick(game_state)

    verify_game_state_consistency(game_state)

    elevators = game_state['elevators']
    e0 = elevators[0]
    e1 = elevators[1]
    e2 = elevators[2]
    e3 = elevators[3]

    passengers = game_state['passengers']

    # State our expectation about the result of the first transformation
    expected_e0 = {
      'location' => {'at_floor' => 1},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 1
    }

    expected_e1 = {
      'location' => {'about_to_reach_floor' => 2},
      'currently' => 'moving_at_half_speed',
      'direction' => 'up',
      'destination' => 2
    }

    expected_e2 = {
      'location' => {'just_left_floor' => 1},
      'currently' => 'moving_at_half_speed',
      'direction' => 'up',
      'destination' => 3
    }

    expected_e3 = {
      'location' => {'just_left_floor' => 1},
      'currently' => 'accelerating',
      'direction' => 'up',
      'destination' => 4
    }

    assert_equal(
      expected_e0,
      e0,
      failure_message =
        "Unexpected inconsistency in e0 elevator data after the first call to on_clock_tick"
    )

    assert_equal(
      expected_e1,
      e1,
      failure_message =
        "Unexpected inconsistency in e1 elevator data after the first call to on_clock_tick"
    )

    assert_equal(
      expected_e2,
      e2,
      failure_message =
        "Unexpected inconsistency in e2 elevator data after the first call to on_clock_tick"
    )

    assert_equal(
      expected_e3,
      e3,
      failure_message =
        "Unexpected inconsistency in e3 elevator data after the first call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_ad1022db8e72279e'),
      failure_message =
        "Unexpected inconsistency in passenger data after the first call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_3f0c2ad8fe65831b'),
      failure_message =
        "Unexpected inconsistency in passenger data after the first call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_81259694f038d55f'),
      failure_message =
        "Unexpected inconsistency in passenger data after the first call to on_clock_tick"
    )

    # Apply second transformation
    game_state = on_clock_tick(game_state)

    verify_game_state_consistency(game_state)

    elevators = game_state['elevators']
    e0 = elevators[0]
    e1 = elevators[1]
    e2 = elevators[2]
    e3 = elevators[3]

    passengers = game_state['passengers']

    # State our expectation about the result of the second transformation
    expected_e0 = {
      'location' => {'at_floor' => 1},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 1
    }

    expected_e1 = {
      'location' => {'at_floor' => 2},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 2
    }

    expected_e2 = {
      'location' => {'at_floor' => 2},
      'currently' => 'moving_at_half_speed',
      'direction' => 'up',
      'destination' => 3
    }

    expected_e3 = {
      'location' => {'at_floor' => 2},
      'currently' => 'moving_at_full_speed',
      'direction' => 'up',
      'destination' => 4
    }

    assert_equal(
      expected_e0,
      e0,
      failure_message =
        "Unexpected inconsistency in e0 elevator data after the second call to on_clock_tick"
    )

    assert_equal(
      expected_e1,
      e1,
      failure_message =
        "Unexpected inconsistency in e1 elevator data after the second call to on_clock_tick"
    )

    assert_equal(
      expected_e2,
      e2,
      failure_message =
        "Unexpected inconsistency in e2 elevator data after the second call to on_clock_tick"
    )

    assert_equal(
      expected_e3,
      e3,
      failure_message =
        "Unexpected inconsistency in e3 elevator data after the second call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_ad1022db8e72279e'),
      failure_message =
        "Unexpected inconsistency in passenger data after the second call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_3f0c2ad8fe65831b'),
      failure_message =
        "Unexpected inconsistency in passenger data after the second call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_81259694f038d55f'),
      failure_message =
        "Unexpected inconsistency in passenger data after the second call to on_clock_tick"
    )

    # Apply third transformation
    game_state = on_clock_tick(game_state)

    verify_game_state_consistency(game_state)

    elevators = game_state['elevators']
    e0 = elevators[0]
    e1 = elevators[1]
    e2 = elevators[2]
    e3 = elevators[3]

    passengers = game_state['passengers']

    # State our expectation about the result of the third transformation
    expected_e0 = {
      'location' => {'at_floor' => 1},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 1
    }

    expected_e1 = {
      'location' => {'at_floor' => 2},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 2
    }

    expected_e2 = {
      'location' => {'about_to_reach_floor' => 3},
      'currently' => 'moving_at_half_speed',
      'direction' => 'up',
      'destination' => 3
    }

    expected_e3 = {
      'location' => {'at_floor' => 3},
      'currently' => 'moving_at_full_speed',
      'direction' => 'up',
      'destination' => 4
    }

    assert_equal(
      expected_e0,
      e0,
      failure_message =
        "Unexpected inconsistency in e0 elevator data after the third call to on_clock_tick"
    )

    assert_equal(
      expected_e1,
      e1,
      failure_message =
        "Unexpected inconsistency in e1 elevator data after the third call to on_clock_tick"
    )

    assert_equal(
      expected_e2,
      e2,
      failure_message =
        "Unexpected inconsistency in e2 elevator data after the third call to on_clock_tick"
    )

    assert_equal(
      expected_e3,
      e3,
      failure_message =
        "Unexpected inconsistency in e3 elevator data after the third call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_ad1022db8e72279e'),
      failure_message =
        "Unexpected inconsistency in passenger data after the third call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_3f0c2ad8fe65831b'),
      failure_message =
        "Unexpected inconsistency in passenger data after the third call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_81259694f038d55f'),
      failure_message =
        "Unexpected inconsistency in passenger data after the third call to on_clock_tick"
    )

    # Apply fourth transformation
    game_state = on_clock_tick(game_state)

    verify_game_state_consistency(game_state)

    elevators = game_state['elevators']
    e0 = elevators[0]
    e1 = elevators[1]
    e2 = elevators[2]
    e3 = elevators[3]

    passengers = game_state['passengers']

    # State our expectation about the result of the fourth transformation
    expected_e0 = {
      'location' => {'at_floor' => 1},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 1
    }

    expected_e1 = {
      'location' => {'at_floor' => 2},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 2
    }

    expected_e2 = {
      'location' => {'at_floor' => 3},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 3
    }

    expected_e3 = {
      'location' => {'about_to_reach_floor' => 4},
      'currently' => 'decelerating',
      'direction' => 'up',
      'destination' => 4
    }

    assert_equal(
      expected_e0,
      e0,
      failure_message =
        "Unexpected inconsistency in e0 elevator data after the fourth call to on_clock_tick"
    )

    assert_equal(
      expected_e1,
      e1,
      failure_message =
        "Unexpected inconsistency in e1 elevator data after the fourth call to on_clock_tick"
    )

    assert_equal(
      expected_e2,
      e2,
      failure_message =
        "Unexpected inconsistency in e2 elevator data after the fourth call to on_clock_tick"
    )

    assert_equal(
      expected_e3,
      e3,
      failure_message =
        "Unexpected inconsistency in e3 elevator data after the fourth call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_ad1022db8e72279e'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fourth call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_3f0c2ad8fe65831b'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fourth call to on_clock_tick"
    )

    assert(
      passengers.has_key?('passenger_81259694f038d55f'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fourth call to on_clock_tick"
    )

    # Apply fifth transformation
    game_state = on_clock_tick(game_state)

    verify_game_state_consistency(game_state)

    elevators = game_state['elevators']
    e0 = elevators[0]
    e1 = elevators[1]
    e2 = elevators[2]
    e3 = elevators[3]

    passengers = game_state['passengers']

    # State our expectation about the result of the fifth transformation
    expected_e0 = {
      'location' => {'at_floor' => 1},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 1
    }

    expected_e1 = {
      'location' => {'at_floor' => 2},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 2
    }

    expected_e2 = {
      'location' => {'at_floor' => 3},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 3
    }

    expected_e3 = {
      'location' => {'at_floor' => 4},
      'currently' => 'not_in_motion',
      'direction' => 'not_in_motion',
      'destination' => 4
    }

    assert_equal(
      expected_e0,
      e0,
      failure_message =
        "Unexpected inconsistency in e0 elevator data after the fifth call to on_clock_tick"
    )

    assert_equal(
      expected_e1,
      e1,
      failure_message =
        "Unexpected inconsistency in e1 elevator data after the fifth call to on_clock_tick"
    )

    assert_equal(
      expected_e2,
      e2,
      failure_message =
        "Unexpected inconsistency in e2 elevator data after the fifth call to on_clock_tick"
    )

    assert_equal(
      expected_e3,
      e3,
      failure_message =
        "Unexpected inconsistency in e3 elevator data after the fifth call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_ad1022db8e72279e'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fifth call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_3f0c2ad8fe65831b'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fifth call to on_clock_tick"
    )

    assert(
      !passengers.has_key?('passenger_81259694f038d55f'),
      failure_message =
        "Unexpected inconsistency in passenger data after the fifth call to on_clock_tick"
    )
  end
end

