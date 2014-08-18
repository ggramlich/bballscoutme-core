# Events

Every information that the user of BBallScout.me enters leads to an event stored by the app.
Using the principle of [event sourcing](http://www.martinfowler.com/eaaDev/EventSourcing.html),
the history of all events is used to reconstruct the current state of the game.

The app handles the following events:

- Game Details Updated
- Team Details Updated
- Player Added
- Player Details Updated
- Game Action Added
- Game Action Removed
- Game Action Moved
