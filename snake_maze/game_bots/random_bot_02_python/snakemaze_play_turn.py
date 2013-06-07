import random
from copy import deepcopy

DIRECTIONS = ['right', 'left', 'up', 'down']

def locate_free_square(width, height, obstacles):

    square = {'x': 0, 'y': 0}

    while square in obstacles:

        square['x'] = random.choice( range(0,width) )
        square['y'] = random.choice( range(0,height) )

    return square

def play_turn(width, height, obstacles):

    snake = {
        'starts_at': locate_free_square(width, height, obstacles),
        'shape_segments': []
    }

    for direction in DIRECTIONS:

        next_square = deepcopy( snake['starts_at'] )

        # Python doesn't have case statements,
        # so the following few IFs are necessarily ugly

        if direction == 'right':
            next_square['x'] += 1

        if direction == 'left':
            next_square['x'] -= 1

        if direction == 'up':
            next_square['y'] -= 1

        if direction == 'down':
            next_square['y'] += 1

        next_square_out_of_bounds = \
            next_square['x'] > width - 1 or \
            next_square['x'] < 0 or \
            next_square['y'] < 0 or \
            next_square['y'] > height - 1

        if next_square not in obstacles and not next_square_out_of_bounds:

            snake['shape_segments'].append(direction)
            break

    return snake

