import unittest
execfile('src/tictactoe_game_engine.py')

DEBUG = False

class TicTacToeTestSuite(unittest.TestCase):

    def test_correctness_of_verify_game_state_consistency_1(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        who_moves_next = 2

        # State our expectation about the result of the transformation
        with self.assertRaises(CrossCheckFailedError):
            verify_game_state_consistency(game_state, who_moves_next)

    def test_correctness_of_verify_game_state_consistency_2(self):

        # Define input
        game_state = {
            'owned_by_x':    ['a1'],
            'owned_by_zero': []
        }
        who_moves_next = 1

        # State our expectation about the result of the transformation
        with self.assertRaises(CrossCheckFailedError):
            verify_game_state_consistency(game_state, who_moves_next)

    def test_correctness_of_verify_game_state_consistency_3(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': ['a2']
        }
        who_moves_next = 1

        # State our expectation about the result of the transformation
        with self.assertRaises(GameStateInconsistencyError):
            verify_game_state_consistency(game_state, who_moves_next)

    def test_correctness_of_verify_game_state_consistency_4(self):

        # Define input
        game_state = {
            'owned_by_x':    ['a1', 'a2'],
            'owned_by_zero': []
        }
        who_moves_next = 2

        # State our expectation about the result of the transformation
        with self.assertRaises(GameStateInconsistencyError):
            verify_game_state_consistency(game_state, who_moves_next)

    def test_correctness_of_verify_ready_response_1(self):

        # Define input
        parsed_response = []

        # State our expectation about the result of the transformation
        with self.assertRaises(ReadyResponseIsNotAHashError):
            verify_ready_response(parsed_response)

    def test_correctness_of_verify_ready_response_2(self):

        # Define input
        parsed_response = {}

        # State our expectation about the result of the transformation
        with self.assertRaises(ReadyResponseHashIsNotOfSizeOneError):
            verify_ready_response(parsed_response)

    def test_correctness_of_verify_ready_response_3(self):

        # Define input
        parsed_response = {'abc': 'abc'}

        # State our expectation about the result of the transformation
        with self.assertRaises(NoSuchKeyStatusError):
            verify_ready_response(parsed_response)

    def test_correctness_of_verify_ready_response_4(self):

        # Define input
        parsed_response = {'status': 'abc'}

        # State our expectation about the result of the transformation
        with self.assertRaises(PlayerIsNotReadyError):
            verify_ready_response(parsed_response)

    def test_correctness_of_verify_turn_response_1(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        parsed_response = []

        # State our expectation about the result of the transformation
        with self.assertRaises(TurnResponseIsNotAHashError):
            verify_turn_response(game_state, parsed_response)

    def test_correctness_of_verify_turn_response_2(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        parsed_response = {}

        # State our expectation about the result of the transformation
        with self.assertRaises(TurnResponseHashIsNotOfSizeOneError):
            verify_turn_response(game_state, parsed_response)

    def test_correctness_of_verify_turn_response_3(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        parsed_response = {'abc': 'abc'}

        # State our expectation about the result of the transformation
        with self.assertRaises(NoSuchKeyTurnError):
            verify_turn_response(game_state, parsed_response)

    def test_correctness_of_verify_turn_response_4(self):

        # Define input
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        parsed_response = {'turn': 'zz'}

        # State our expectation about the result of the transformation
        with self.assertRaises(IllegalMoveError):
            verify_turn_response(game_state, parsed_response)

    def test_correctness_of_verify_turn_response_5(self):

        # Define input
        game_state = {
            'owned_by_x':    ['a1'],
            'owned_by_zero': []
        }
        parsed_response = {'turn': 'a1'}

        # State our expectation about the result of the transformation
        with self.assertRaises(IllegalMoveError):
            verify_turn_response(game_state, parsed_response)

    def test_correctness_of_compute_points_scored_1(self):

        # Define input
        turn = 1
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        who_just_moved = 1
        token_placed = 'a1'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(0, return_code)
        self.assertEqual(0, points_scored_by_x)
        self.assertEqual(0, points_scored_by_zero)

    def test_correctness_of_compute_points_scored_2(self):

        # Define input
        turn = 1
        game_state = {
            'owned_by_x':    [],
            'owned_by_zero': []
        }
        who_just_moved = 1
        token_placed = 'a2'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(0, return_code)
        self.assertEqual(3, points_scored_by_x)
        self.assertEqual(0, points_scored_by_zero)

    def test_correctness_of_compute_points_scored_3(self):

        # Define input
        turn = 5
        game_state = {
            'owned_by_x':    ['a3', 'b3'],
            'owned_by_zero': ['b1', 'b2']
        }
        who_just_moved = 1
        token_placed = 'c3'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(1, return_code)
        self.assertEqual(10, points_scored_by_x)
        self.assertEqual(0, points_scored_by_zero)

    def test_correctness_of_compute_points_scored_4(self):

        # Define input
        turn = 6
        game_state = {
            'owned_by_x':    ['a1', 'a3', 'c1'],
            'owned_by_zero': ['b1', 'b2']
        }
        who_just_moved = 2
        token_placed = 'b3'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(1, return_code)
        self.assertEqual(0, points_scored_by_x)
        self.assertEqual(10, points_scored_by_zero)

    def test_correctness_of_compute_points_scored_5(self):

        # Define input
        turn = 4
        game_state = {
            'owned_by_x':    ['a1', 'a3'],
            'owned_by_zero': ['b1']
        }
        who_just_moved = 2
        token_placed = 'a2'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(0, return_code)
        self.assertEqual(0, points_scored_by_x)
        self.assertEqual(1, points_scored_by_zero)

    def test_correctness_of_compute_points_scored_6(self):

        # Define input
        turn = 5
        game_state = {
            'owned_by_x':    ['a1', 'a3'],
            'owned_by_zero': ['b1', 'b2']
        }
        who_just_moved = 1
        token_placed = 'b3'

        # Apply transformation
        return_code, points_scored_by_x, points_scored_by_zero = \
            compute_points_scored(
                turn,
                game_state,
                who_just_moved,
                token_placed
            )

        # State our expectation about the result of the transformation
        self.assertEqual(0, return_code)
        self.assertEqual(1, points_scored_by_x)
        self.assertEqual(0, points_scored_by_zero)

unittest.main()

