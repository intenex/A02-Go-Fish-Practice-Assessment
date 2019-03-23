# Go Fish

## Rules

* You have **1 hour** for the assessment. Do not worry if you do not
  complete all the assessment; finish as much as you can.
* Descriptions of each method to implement are written into the `lib/`
  files. For each `lib/` file, there is a corresponding `spec/` file.
* Run the specs as you solve the assessment. Solve the assessment in
  this order:

```
bundle exec rspec spec/deck_spec.rb
bundle exec rspec spec/hand_spec.rb
bundle exec rspec spec/player_spec.rb
```

* To run one specific spec, add `:line_number` at the end.  For example, `bundle exec rspec spec/deck_spec.rb:30`

* Wait until you finish to run `rspec spec`, which will run all the
  tests. Do this as a final check that you have them all passing.

## Game Rules

* This is a two player version of Go Fish. The real version of the game may have many more players. In that version of the game, the key things to note are that a player may request any rank of card from any other player on their turn, and they may continue to request any rank of card (including the one they just requested) from any other player (including one they have already requested from) so long as they successfully continue to make a 'catch'/receive one or more cards from a player on every request.
* The goal of the game is to win the most sets of cards. A set of cards is any four of a kind of any value/rank of card, such as kings, jacks, 2s, etc.
* Cards have ranks, with 2s having the lowest rank and Aces having the highest rank. Suits are not important in this game.
* Each player is dealt seven cards (in this two-player version of the game - if there are more than three players, players are generally dealt five cards.).
* A player can request any rank of card from the player, such as all the kings from another player's hand. If the other player has any of the rank of card requested, they must hand over all the cards they have of that rank. If they do not, they tell the requesting player to "Go fish" and that player draws one card from the deck and places it in their hand.
* If a player successfully requests one or more cards from the other player, they are entitled to continue their turn and asking that player again for any rank of card. As long as a player successfully continues to request cards, their turn continues.
* When a player successfully requests one or more cards (a 'catch'), they must reveal those cards to the other player.
* When a player gets a full set of four cards, they place it on the table in front of them and play again.
* Once a player fails to successfully make a catch/request a card from the other player and has to 'go fishing' for a card in the deck, their turn ends and the turn passes to the other player.
* The game ends when all thirteen sets of cards have been claimed. The player with the most sets wins.
* If at any point a player has no cards in their hand, they may draw a card from the deck and ask the other player for any cards of the same rank as the card they drew.
