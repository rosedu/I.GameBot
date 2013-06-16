### Snake Maze

The "snake maze" simulator is based on the same idea as the classic game of "Snake".

The difference here is that you start with a rectangular grid that is sprinkled with obstacles.
The objective is to draw the longest possible snake that:
* stays within the confines of the rectangular grid
* doesn't run through obstacles
* doesn't intersect with itself

At the end of the game, you score a number of points that is equal to however many valid grid squares your snake has covered.

### How to get started

**Software prerequisites:** Python 2.7, Ruby 1.9.3 (gem install json)

**Step 1:** Request to be added as a contributor at [https://github.com/dserban/aichallenge](https://github.com/dserban/aichallenge).  
**Important note:** Steps 2 and 8 will only work as expected if you have been made an aichallenge contributor as per step 1.

**Step 2:** Place a copy of each one of the required GitHub repositories in your home directory:

```
cd
git clone https://github.com/rosedu/I.GameBot.git
git clone git@github.com:dserban/aichallenge.git
```

**Step 3:** Create the required named pipes:
```
~/I.GameBot/create_named_pipes.sh
```

**Step 4:** Choose a screen name for your game bot and make a copy of the Python starter pack (random bot) under that name (assuming you want to code your bot in Python).  
(Your screen name can be your GitHub account ID for instance, otherwise you may use any identifier you want, provided it doesn't conflict with other people's screen names.)  
**Important note:** Don't forget to actually replace the string `your_chosen_screen_name` in the commands below with your actual GitHub account ID (or another unique identifier of your choice).
```
cd ~/I.GameBot/snake_maze/game_bots
cp -r random_bot_02_python your_chosen_screen_name
mv your_chosen_screen_name ~/aichallenge/snake_maze/
```

**Step 5:** Open three new terminal sessions.

**Step 6:** In the first terminal session, start your game bot:
```
cd ~/aichallenge/snake_maze/your_chosen_screen_name
./run_snakemaze_game_bot.sh
```
As a result of starting your game bot, you should see the message:
```
INFO: Accepting requests ...
```

**Step 7:** In the second terminal session, start the game engine:
```
cd ~/I.GameBot/snake_maze/game_engine
./start_snakemaze_game_engine.sh
```
As a result of starting the game engine, you should see some output that ends with:
```
Overall score: 10
```

**Step 8:** At this point, if everything went well, in the third terminal session, push your game bot code to GitHub:
```
cd ~/aichallenge
git add .
git commit -m "My copy of the starter pack"
git push
```

**Step 9:** Start making changes to the `play_turn` function, in order to truly make the game bot your own:
```
vim ~/aichallenge/snake_maze/your_chosen_screen_name/snakemaze_play_turn.py
```

The `play_turn` function takes the following three arguments:
- `width` - the width of the grid
- `height` - the height of the grid
- `obstacles` - a list of dictionaries that represent obstacles. Each dictionary in the list has exactly two keys: one called `'x'` and one called `'y'`

The return value of the `play_turn` function is a nested data structure that represents a snake. It's a dictionary with exactly two keys: one called `'starts_at'` and another one called `'shape_segments'`.  
The `'starts_at'` key points to a dictionary with exactly two keys: one called `'x'` and another one called `'y'`. This dictionary represents the snake's starting point.  
In order to represent the shape of the snake, your game bot needs to "draw" it little by little, by specifying a list called `'shape_segments'`. One such list might look like this:
```
['right', 'right', 'down', 'left', 'down', 'right']
```

To summarize, the return value of the `play_turn` function is a structure that looks like this:
```
{
  'starts_at': {'x': 0, 'y': 0},
  'shape_segments': ['right', 'right', 'down', 'left', 'down', 'right']
}
```

The starter pack's default `play_turn` function picks a random, non-obstacle grid square and designates it as the snake's starting point. It then draws a snake shape consisting of exactly one segment. Therefore this function will always score two points per test case, and if there are five test cases, the overall score will be 10.

**Have fun coding!**

