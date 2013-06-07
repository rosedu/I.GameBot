BOARD = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']

def play_turn(
      player_role,
      owned_by_x,
      owned_by_zero
    )
  turn = (BOARD - owned_by_x - owned_by_zero).sample
end

