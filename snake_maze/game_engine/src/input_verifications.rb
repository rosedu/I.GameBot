def verify_number_of_cmd_line_arguments(nr_args)
  if nr_args != 3
    $stderr.puts 'NUMBER OF ARGUMENTS: ' + nr_args.to_s if DEBUG
    raise WrongNumberOfArgumentsError
  end
end

def verify_that_argument_is_a_named_pipe(arg)
  valid_arg = File.exists?(arg) && File.ftype(arg) == 'fifo'
  if !valid_arg
    $stderr.puts 'ARGUMENT: ' + arg if DEBUG
    raise ArgumentIsNotANamedPipeError
  end
end

def verify_that_topology_file_exists(file_handle)
  valid_arg = File.exists?(file_handle) && File.file?(file_handle)
  if !valid_arg
    $stderr.puts 'TOPOLOGY FILE: ' + file_handle if DEBUG
    raise TopologyFileNotFoundError
  end
end

def verify_topology(parsed_topology_json)
  if !parsed_topology_json.is_a?(Hash)
    raise TopologyDataIsNotAHashError
  end

  if parsed_topology_json.size != 2
    raise TopologyDataIsAHashOfSizeOtherThanTwoError
  end

  if !parsed_topology_json.has_key?('rectangle')
    raise TopologyHashHasNoSuchKeyRectangleError
  end

  if !parsed_topology_json['rectangle'].is_a?(Hash)
    raise TopologyRectangleIsNotAHashError
  end

  if parsed_topology_json['rectangle'].size != 2
    raise TopologyRectangleHashIsNotSizeTwoError
  end

  if !parsed_topology_json['rectangle'].has_key?('width')
    raise TopologyRectangleHashHasNoSuchKeyWidthError
  end

  if !parsed_topology_json['rectangle']['width'].is_a?(Fixnum)
    raise TopologyRectangleWidthIsNotOfTypeFixnumError
  end

  if parsed_topology_json['rectangle']['width'] <= 0
    raise TopologyRectangleWidthIsNotGreaterThanZeroError
  end

  if !parsed_topology_json['rectangle'].has_key?('height')
    raise TopologyRectangleHashHasNoSuchKeyHeightError
  end

  if !parsed_topology_json['rectangle']['height'].is_a?(Fixnum)
    raise TopologyRectangleHeightIsNotOfTypeFixnumError
  end

  if parsed_topology_json['rectangle']['height'] <= 0
    raise TopologyRectangleHeightIsNotGreaterThanZeroError
  end

  if !parsed_topology_json.has_key?('obstacles')
    raise TopologyHashHasNoSuchKeyObstaclesError
  end

  if !parsed_topology_json['obstacles'].is_a?(Array)
    raise TopologyObstaclesIsNotAnArrayError
  end

  parsed_topology_json['obstacles'].each do |obstacle|
    if !obstacle.is_a?(Hash)
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesAreNotAllHashesError
    end

    if obstacle.size != 2
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesAreNotAllHashesOfSizeTwoError
    end

    if !obstacle.has_key?('x')
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashesDoNotAllHaveTheXKeyError
    end

    if !obstacle['x'].is_a?(Fixnum)
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashXIsNotOfTypeFixnumError
    end

    if obstacle['x'] < 0 ||
       obstacle['x'] > parsed_topology_json['rectangle']['width'] - 1
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashXIsOutOfBoundsError
    end

    if !obstacle.has_key?('y')
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashesDoNotAllHaveTheYKeyError
    end

    if !obstacle['y'].is_a?(Fixnum)
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashYIsNotOfTypeFixnumError
    end

    if obstacle['y'] < 0 ||
       obstacle['y'] > parsed_topology_json['rectangle']['height'] - 1
      $stderr.puts 'OBSTACLE: ' + obstacle.to_s if DEBUG
      raise TopologyObstaclesHashYIsOutOfBoundsError
    end
  end
end

def verify_readiness_of_game_bot(parsed_response)
  if !parsed_response.is_a?(Hash)
    raise ParsedResponseIsNotAHashError
  end

  if !parsed_response.has_key?('status')
    raise ParsedResponseHashHasNoSuchKeyStatusError
  end

  if parsed_response['status'] != 'ready'
    raise ParsedResponseStatusNotReadyError
  end
end

def verify_validity_of_snake_data(parsed_snake, topology)
  if !parsed_snake.is_a?(Hash)
    raise SnakeDataIsNotAHashError
  end

  if parsed_snake.size != 2
    raise SnakeDataIsAHashOfSizeOtherThanTwoError
  end

  if !parsed_snake.has_key?('starts_at')
    raise SnakeHashHasNoSuchKeyStartsAtError
  end

  if !parsed_snake['starts_at'].is_a?(Hash)
    raise SnakeStartsAtIsNotAHashError
  end

  if parsed_snake['starts_at'].size != 2
    raise SnakeStartsAtHashIsNotSizeTwoError
  end

  if !parsed_snake['starts_at'].has_key?('x')
    raise SnakeStartsAtHashHasNoSuchKeyXError
  end

  if !parsed_snake['starts_at']['x'].is_a?(Fixnum)
    raise SnakeStartsAtXIsNotOfTypeFixnumError
  end

  if parsed_snake['starts_at']['x'] < 0 ||
     parsed_snake['starts_at']['x'] > topology['rectangle']['width'] - 1
    raise SnakeStartsAtXIsOutOfBoundsError
  end

  if !parsed_snake['starts_at'].has_key?('y')
    raise SnakeStartsAtHashHasNoSuchKeyYError
  end

  if !parsed_snake['starts_at']['y'].is_a?(Fixnum)
    raise SnakeStartsAtYIsNotOfTypeFixnumError
  end

  if parsed_snake['starts_at']['y'] < 0 ||
     parsed_snake['starts_at']['y'] > topology['rectangle']['height'] - 1
    raise SnakeStartsAtYIsOutOfBoundsError
  end

  if !parsed_snake.has_key?('shape_segments')
    raise SnakeHashHasNoSuchKeyShapeSegmentsError
  end

  if !parsed_snake['shape_segments'].is_a?(Array)
    raise SnakeShapeSegmentsNotAnArrayError
  end

  parsed_snake['shape_segments'].each do |segment|
    if !segment.is_a?(String)
      raise SnakeShapeSegmentsAreNotAllStringsError
    end

    if !['up','down','left','right'].include?(segment)
      raise SnakeShapeSegmentsDoNotAllHaveCorrectValuesError
    end
  end
end

