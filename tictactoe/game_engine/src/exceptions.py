class GameEngineError(Exception):
    pass

class ArgumentIsNotANamedPipeError(GameEngineError):
    def __str__(self):
        return 'ERROR: At least one of the first four arguments is not a named pipe.'

class UnexpectedFileAccessError(GameEngineError):
    def __str__(self):
        return 'ERROR: Unexpected file access error.'

class ResponseNotInJSONFormatError(GameEngineError):
    def __str__(self):
        return 'ERROR: The response I received from the game bot is not in JSON format.'

class CrossCheckFailedError(GameEngineError):
    def __str__(self):
        return 'ERROR: Cross-check failed.'

class GameStateInconsistencyError(GameEngineError):
    def __str__(self):
        return 'ERROR: Game state inconsistency.'

class IllegalMoveError(GameEngineError):
    def __str__(self):
        return 'ERROR: The player made an illegal move.'

class ReadyResponseIsNotAHashError(GameEngineError):
    def __str__(self):
        return 'ERROR: Ready response is not a hash.'

class ReadyResponseHashIsNotOfSizeOneError(GameEngineError):
    def __str__(self):
        return 'ERROR: Ready response hash is not of size 1.'

class NoSuchKeyStatusError(GameEngineError):
    def __str__(self):
        return 'ERROR: No such key: status.'

class PlayerIsNotReadyError(GameEngineError):
    def __str__(self):
        return 'ERROR: Player is not ready.'

class TurnResponseIsNotAHashError(GameEngineError):
    def __str__(self):
        return 'ERROR: Turn response is not a hash.'

class TurnResponseHashIsNotOfSizeOneError(GameEngineError):
    def __str__(self):
        return 'ERROR: Turn response hash is not of size 1.'

class NoSuchKeyTurnError(GameEngineError):
    def __str__(self):
        return 'ERROR: No such key: turn.'


