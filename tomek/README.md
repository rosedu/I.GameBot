### Game Engine for tomek tictactoe

Tomek TictacToe is a modified variant of the traditional game of TicTacToe, played by two game bots. The rules of Tomek have been enhanced in order to make it a more interesting strategy game. The game is played on a 4x4 table and, at the start of the game, a token(T) is placed somewhere on the board. To win the game, you have to allign 4 X's/zeros or 3 X's/zeros and the token T. 

The goal is not necessarily to win the game (although that helps). The goal is to score as many points as possible. Winning the game is just one of several possible ways to score points. Playing a match consists of 3 games with different pozitions for the token T. The overall score (and the winner) is calculated by adding each game score.

This is how points are scored:
- The game bot that wins a game scores 10 points
- The game bot that makes the opening move of a game has the option to immediately score 3 points, provided it places its `X` token on one of the edge middles (more specifically, at either one of the board positions 'a2','a3','b1','b4','c1','c4','d2','d3')
-The game bot that makes the opening move can gain 3 more points by not alligning with T.
- A game bot that successfully defends itself against a direct attack scores 1 point
- A game bot that complies with all the rules, only makes legal moves, plays fair and doesn't crash, scores 3 bonus points at the end of the game

### How to get started

**Software prerequisites:** Python 2.7

**Step 1:** Request to be added as a contributor at [https://github.com/dserban/aichallenge](https://github.com/dserban/aichallenge).  
**Important note:** Steps 2 and 9 will only work as expected if you have been made an aichallenge contributor as per step 1.

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
cd ~/I.GameBot/tomek/game_bots
cp -r random_bot_02_python your_chosen_screen_name
mv your_chosen_screen_name ~/aichallenge/tomek/
```

**Step 5:** Open four new terminal sessions.

**Step 6:** In the first terminal session, start your own game bot as player `X`:
```
cd ~/aichallenge/tomek/your_chosen_screen_name
./run_tomek_game_bot_as_player_1.sh
```
As a result of starting your own game bot, you should see the message:
```
INFO: Accepting requests ...
```

**Step 7:** In the second terminal session, start the random bot as player `O`:
```
cd ~/I.GameBot/tomek/game_bots/random_bot_02_python
./run_tomek_game_bot_as_player_2.sh
```
As a result of starting the random bot, you should also see the message:
```
INFO: Accepting requests ...
```

**Step 8:** In the third terminal session, start the game engine:
```
cd ~/I.GameBot/tomek/game_engine
./start_tomek_game_engine.sh
```
As a result of starting the game engine, you should see some output that ends with:

Overall score X : <some_number>

Overall score O : <another_number>

Match winner

```

**Step 9:** At this point, if everything went well, in the fourth terminal session, push your game bot code to GitHub:
```
cd ~/aichallenge
git add .
git commit -m "My copy of the starter pack"
git pull
git push
```

**Step 10:** Start making changes to the `play_turn` function, in order to truly make the game bot your own:
```
vim ~/aichallenge/tomek/your_chosen_screen_name/tomek_play_turn.py
```
The `play_turn` function takes the three arguments listed below, and returns a token.
- `player_role` - with two possible values: `x` or `zero`
- `owned_by_x` - a list of tokens owned by player 1
- `owned_by_zero` - a list of tokens owned by player 2
- `occupied_by_t` - a string containing the pozition occupied by T

The token (return value) needs to be either one of the board positions `'a1'`, `'a2'`, `'a3'`,`'a4'`, `'b1'`, `'b2'`, `'b3'`, `'b4'`, `'c1'`, `'c2'`, `'c3'`, `'c4'`, `'d1'`, `'d2'`, `'d3'`, `'d4'`, provided that position is empty.

The starter pack's default `play_turn` function computes a list of all empty board squares, picks one at random, and returns it.

**Have fun coding!**

