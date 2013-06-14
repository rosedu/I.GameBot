class GameBotError < StandardError
end

class WrongNumberOfArgumentsError < GameBotError
  MESSAGE = "ERROR: I was expecting exactly #{EXPECTED_NR_ARGS.to_s} command line arguments."
end

class ArgumentIsNotANamedPipeError < GameBotError
  MESSAGE = 'ERROR: The argument is not a named pipe.'
end

class UnexpectedFileAccessError < GameBotError
  MESSAGE = 'ERROR: Unexpected file access error.'
end

class RequestNotInJSONFormatError < GameBotError
  MESSAGE = 'ERROR: Request from game engine not in JSON format.'
end

