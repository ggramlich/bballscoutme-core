# Game Actions

We call the actions that are tracked in BBallScout.me `game actions`.
All `game actions` are caused by a `player`.

A `game action` can optionally contain

- a `position`, describing where on the court the action took place
- the `game time`, describing when the action took place

The following `game actions` can be tracked by BBallScout.me:

- field goal made
- field goal missed
- free throw made
- free throw missed
- three-point field goal made
- three-point field goal missed
- offensive rebound
- defensive rebound
- assist
- steal
- block
- turnover
- personal foul, optionally contains the following information
    - the fouled player
    - foul was on the shot
    - foul was unsportsmanlike
    - foul was disqualifying
- substitution into the game (must not contain `position`), also used for the first five
- substitution out of the game (must not contain `position`)

# Comments

A `comment` is a simple text that can optionally contain a the `game time` and appears in the history
along with the `game actions`.

# Adjustments

It should be possible to adjust simple statistics like the points scored by a player.
It is not clear yet, if this should be handled by a `game action` as well.
An adjustment might reduce the ability to create a detailed statistical report, but allows the user
to track e.g. only one of the two teams or only a single player in detail, but still have some basic stats
for the other players.

# Tracking the game time

The game time will probably be tracked and adjusted by the write model alone and not persisted.

