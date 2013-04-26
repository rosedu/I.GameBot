require 'test/unit'
require './src/snake_maze_game_engine.rb'

DEBUG = false

class TestSnakeMaze < Test::Unit::TestCase
  def test_that_a_snake_starting_at_an_obstacle_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 1, 'y' => 1},
      'shape_segments' => []
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_ran_over_an_obstacle,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake starts at an obstacle, the game does not end as expected'
    )
    assert_equal(
      {'x' => 1, 'y' => 1},
      game_state[:if_there_was_an_error_it_occured_at],
      failure_message = 'When the snake starts at an obstacle, the error is not reported correctly'
    )
    assert_equal(
      0,
      game_state[:score],
      failure_message = 'When the snake starts at an obstacle, the score is not computed correctly'
    )
  end

  def test_that_running_over_an_obstacle_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => [
        'right',
        'down'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_ran_over_an_obstacle,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake runs over an obstacle, the game does not end as expected'
    )
    assert_equal(
      2,
      game_state[:score],
      failure_message = 'When the snake runs over an obstacle, the score is not computed correctly'
    )
  end

  def test_that_a_snake_intersecting_with_itself_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => [
        'right',
        'right',
        'down',
        'down',
        'left',
        'left',
        'up',
        'up'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_has_intersected_with_itself,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake intersects with itself, the game does not end as expected'
    )
  end

  def test_that_exiting_the_grid_to_the_right_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 2, 'y' => 0},
      'shape_segments' => [
        'right'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_exited_the_grid,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake exits the grid to the right, the game does not end as expected'
    )
    assert_equal(
      {'x' => 3, 'y' => 0},
      game_state[:if_there_was_an_error_it_occured_at],
      failure_message = 'When the snake exits the grid to the right, the error is not reported correctly'
    )
    assert_equal(
      1,
      game_state[:score],
      failure_message = 'When the snake exits the grid to the right, the score is not computed correctly'
    )
  end

  def test_that_exiting_the_grid_to_the_left_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => [
        'left'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_exited_the_grid,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake exits the grid to the left, the game does not end as expected'
    )
    assert_equal(
      1,
      game_state[:score],
      failure_message = 'When the snake exits the grid to the left, the score is not computed correctly'
    )
  end

  def test_that_exiting_the_grid_through_the_top_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => [
        'up'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_exited_the_grid,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake exits the grid through the top, the game does not end as expected'
    )
    assert_equal(
      1,
      game_state[:score],
      failure_message = 'When the snake exits the grid through the top, the score is not computed correctly'
    )
  end

  def test_that_exiting_the_grid_through_the_bottom_causes_invalidation
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    snake = {
      'starts_at' => {'x' => 0, 'y' => 2},
      'shape_segments' => [
        'down'
      ]
    }

    # Apply transformation
    game_state = game_state_after_building_snake(snake, topology)

    # State our expectation about the result of the transformation
    assert_equal(
      :snake_exited_the_grid,
      game_state[:why_the_game_ended],
      failure_message = 'When the snake exits the grid through the bottom, the game does not end as expected'
    )
    assert_equal(
      1,
      game_state[:score],
      failure_message = 'When the snake exits the grid through the bottom, the score is not computed correctly'
    )
  end

  def test_correctness_of_verify_topology_01
    # Define input
    topology = []

    # State our expectation about the result of the transformation
    assert_raise(TopologyDataIsNotAHashError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_02
    # Define input
    topology = {}

    # State our expectation about the result of the transformation
    assert_raise(TopologyDataIsAHashOfSizeOtherThanTwoError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_03
    # Define input
    topology = {
      'abc' => 1,
      'def' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyHashHasNoSuchKeyRectangleError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_04
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'def' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyHashHasNoSuchKeyObstaclesError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_05
    # Define input
    topology = {
      'rectangle' => 1,
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleIsNotAHashError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_06
    # Define input
    topology = {
      'rectangle' => {},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleHashIsNotSizeTwoError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_07
    # Define input
    topology = {
      'rectangle' => {'abc' => [], 'def' => []},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleHashHasNoSuchKeyWidthError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_08
    # Define input
    topology = {
      'rectangle' => {'width' => [], 'def' => []},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleWidthIsNotOfTypeFixnumError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_09
    # Define input
    topology = {
      'rectangle' => {'width' => 0, 'def' => []},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleWidthIsNotGreaterThanZeroError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_10
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'def' => []},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleHashHasNoSuchKeyHeightError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_11
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => []},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleHeightIsNotOfTypeFixnumError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_12
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 0},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyRectangleHeightIsNotGreaterThanZeroError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_13
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesIsNotAnArrayError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_14
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [1]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesAreNotAllHashesError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_15
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesAreNotAllHashesOfSizeTwoError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_16
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'abc' => [], 'y' => 1}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashesDoNotAllHaveTheXKeyError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_17
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'x' => [], 'y' => 1}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashXIsNotOfTypeFixnumError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_18
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'x' => 11, 'y' => 1}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashXIsOutOfBoundsError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_19
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'x' => 1, 'def' => []}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashesDoNotAllHaveTheYKeyError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_20
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'x' => 1, 'y' => []}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashYIsNotOfTypeFixnumError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_topology_21
    # Define input
    topology = {
      'rectangle' => {'width' => 10, 'height' => 10},
      'obstacles' => [{'x' => 1, 'y' => 11}]
    }

    # State our expectation about the result of the transformation
    assert_raise(TopologyObstaclesHashYIsOutOfBoundsError) do
      verify_topology(topology)
    end
  end

  def test_correctness_of_verify_readiness_of_game_bot_1
    # Define input
    parsed_response = []

    # State our expectation about the result of the transformation
    assert_raise(ParsedResponseIsNotAHashError) do
      verify_readiness_of_game_bot(parsed_response)
    end
  end

  def test_correctness_of_verify_readiness_of_game_bot_2
    # Define input
    parsed_response = {}

    # State our expectation about the result of the transformation
    assert_raise(ParsedResponseHashHasNoSuchKeyStatusError) do
      verify_readiness_of_game_bot(parsed_response)
    end
  end

  def test_correctness_of_verify_readiness_of_game_bot_3
    # Define input
    parsed_response = {'status' => 'not ready'}

    # State our expectation about the result of the transformation
    assert_raise(ParsedResponseStatusNotReadyError) do
      verify_readiness_of_game_bot(parsed_response)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_01
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = []

    # State our expectation about the result of the transformation
    assert_raise(SnakeDataIsNotAHashError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_02
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {}

    # State our expectation about the result of the transformation
    assert_raise(SnakeDataIsAHashOfSizeOtherThanTwoError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_03
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {'abc' => 1, 'shape_segments' => []}

    # State our expectation about the result of the transformation
    assert_raise(SnakeHashHasNoSuchKeyStartsAtError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_04
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {'starts_at' => 1, 'shape_segments' => []}

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtIsNotAHashError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_05
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtHashIsNotSizeTwoError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_06
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'abc' => [], 'y' => 1},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtHashHasNoSuchKeyXError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_07
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => [], 'y' => 1},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtXIsNotOfTypeFixnumError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_08
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 5, 'y' => 1},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtXIsOutOfBoundsError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_09
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'def' => []},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtHashHasNoSuchKeyYError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_10
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'y' => []},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtYIsNotOfTypeFixnumError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_11
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'y' => 5},
      'shape_segments' => []
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeStartsAtYIsOutOfBoundsError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_12
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => 1
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeShapeSegmentsNotAnArrayError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_13
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => [1]
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeShapeSegmentsAreNotAllStringsError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end

  def test_correctness_of_verify_validity_of_snake_data_14
    # Define input
    topology = {
      'rectangle' => {'width' => 3, 'height' => 3},
      'obstacles' => [{'x' => 1, 'y' => 1}]
    }
    parsed_snake = {
      'starts_at' => {'x' => 0, 'y' => 0},
      'shape_segments' => ['right', 'right', 'abc']
    }

    # State our expectation about the result of the transformation
    assert_raise(SnakeShapeSegmentsDoNotAllHaveCorrectValuesError) do
      verify_validity_of_snake_data(parsed_snake, topology)
    end
  end
end

