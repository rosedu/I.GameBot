class GameEngineError < StandardError
end

class WrongNumberOfArgumentsError < GameEngineError
  MESSAGE = 'ERROR: I was expecting exactly 3 command line arguments.'
end

class ArgumentIsNotANamedPipeError < GameEngineError
  MESSAGE = 'ERROR: At least one of the first two arguments is not a named pipe.'
end

class TopologyFileNotFoundError < GameEngineError
  MESSAGE = 'ERROR: Could not locate specified topology file.'
end

class UnexpectedFileAccessError < GameEngineError
  MESSAGE = 'ERROR: Unexpected file access error.'
end

class ContentsOfTopologyFileNotInJSONFormatError < GameEngineError
  MESSAGE = 'ERROR: The contents of the topology file are not in JSON format.'
end

class ResponseNotInJSONFormatError < GameEngineError
  MESSAGE = 'ERROR: Response from player not in JSON format.'
end

class TopologyDataIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Topology data is not a hash.'
end

class TopologyDataIsAHashOfSizeOtherThanTwoError < GameEngineError
  MESSAGE = 'ERROR: Topology data is a hash of size other than 2.'
end

class TopologyHashHasNoSuchKeyRectangleError < GameEngineError
  MESSAGE = 'ERROR: Topology hash has no such key: rectangle.'
end

class TopologyHashHasNoSuchKeyObstaclesError < GameEngineError
  MESSAGE = 'ERROR: Topology hash has no such key: obstacles.'
end

class TopologyRectangleIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle is not a hash.'
end

class TopologyRectangleHashIsNotSizeTwoError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle is a hash of size other than 2.'
end

class TopologyRectangleHashHasNoSuchKeyWidthError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle hash has no such key: width.'
end

class TopologyRectangleWidthIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle width is not of type Fixnum (integer).'
end

class TopologyRectangleWidthIsNotGreaterThanZeroError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle width is not greater than zero.'
end

class TopologyRectangleHashHasNoSuchKeyHeightError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle hash has no such key: height.'
end

class TopologyRectangleHeightIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle height is not of type Fixnum (integer).'
end

class TopologyRectangleHeightIsNotGreaterThanZeroError < GameEngineError
  MESSAGE = 'ERROR: Topology rectangle height is not greater than zero.'
end

class TopologyObstaclesIsNotAnArrayError < GameEngineError
  MESSAGE = 'ERROR: Topology obstacles is not an array.'
end

class TopologyObstaclesAreNotAllHashesError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle that is not a hash.'
end

class TopologyObstaclesAreNotAllHashesOfSizeTwoError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash that is not of size 2.'
end

class TopologyObstaclesHashesDoNotAllHaveTheXKeyError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash that has no such key: x.'
end

class TopologyObstaclesHashXIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash where x is not of type Fixnum (integer).'
end

class TopologyObstaclesHashXIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash where x is out of bounds.'
end

class TopologyObstaclesHashesDoNotAllHaveTheYKeyError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash that has no such key: y.'
end

class TopologyObstaclesHashYIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash where y is not of type Fixnum (integer).'
end

class TopologyObstaclesHashYIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: Found a topology obstacle hash where y is out of bounds.'
end

class ParsedResponseIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Parsed response is not a hash.'
end

class ParsedResponseHashHasNoSuchKeyStatusError < GameEngineError
  MESSAGE = 'ERROR: Parsed response hash has no such key: status.'
end

class ParsedResponseStatusNotReadyError < GameEngineError
  MESSAGE = 'ERROR: Parsed response status is not ready.'
end

class SnakeDataIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Snake data is not a hash.'
end

class SnakeDataIsAHashOfSizeOtherThanTwoError < GameEngineError
  MESSAGE = 'ERROR: Snake data is a hash of size other than 2.'
end

class SnakeHashHasNoSuchKeyStartsAtError < GameEngineError
  MESSAGE = 'ERROR: Snake hash has no such key: starts_at.'
end

class SnakeStartsAtIsNotAHashError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at is not a hash.'
end

class SnakeStartsAtHashIsNotSizeTwoError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at is a hash of size other than 2.'
end

class SnakeStartsAtHashHasNoSuchKeyXError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at hash has no such key: x.'
end

class SnakeStartsAtXIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at x is not of type Fixnum (integer).'
end

class SnakeStartsAtXIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at x is out of bounds.'
end

class SnakeStartsAtHashHasNoSuchKeyYError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at hash has no such key: y.'
end

class SnakeStartsAtYIsNotOfTypeFixnumError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at y is not of type Fixnum (integer).'
end

class SnakeStartsAtYIsOutOfBoundsError < GameEngineError
  MESSAGE = 'ERROR: Snake starts_at y is out of bounds.'
end

class SnakeHashHasNoSuchKeyShapeSegmentsError < GameEngineError
  MESSAGE = 'ERROR: Snake hash has no such key: shape_segments.'
end

class SnakeShapeSegmentsNotAnArrayError < GameEngineError
  MESSAGE = 'ERROR: Snake shape_segments is not an array.'
end

class SnakeShapeSegmentsAreNotAllStringsError < GameEngineError
  MESSAGE = 'ERROR: Found a snake shape segment that is not a string.'
end

class SnakeShapeSegmentsDoNotAllHaveCorrectValuesError < GameEngineError
  MESSAGE = 'ERROR: Found a snake shape segment that does not have a correct value.'
end

