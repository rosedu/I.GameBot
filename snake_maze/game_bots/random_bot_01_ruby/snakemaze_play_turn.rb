DIRECTIONS = ['right', 'left', 'up', 'down']

def locate_free_square(width, height, obstacles)
  square = {'x' => 0, 'y' => 0}

  while obstacles.include?(square) do
    square['x'] = (0..width-1).to_a.sample
    square['y'] = (0..height-1).to_a.sample
  end

  square
end

def play_turn(width, height, obstacles)
  snake = {
    'starts_at' => locate_free_square(width, height, obstacles),
    'shape_segments' => []
  }

  DIRECTIONS.each do |direction|
    next_square = snake['starts_at'].dup
    case direction
    when 'right'
      next_square['x'] += 1
    when 'left'
      next_square['x'] -= 1
    when 'up'
      next_square['y'] -= 1
    when 'down'
      next_square['y'] += 1
    end
    next_square_out_of_bounds =
      next_square['x'] > width - 1 ||
      next_square['x'] < 0 ||
      next_square['y'] < 0 ||
      next_square['y'] > height - 1
    if !obstacles.include?(next_square) &&
       !next_square_out_of_bounds
      snake['shape_segments'] << direction
      break
    end
  end

  snake
end

