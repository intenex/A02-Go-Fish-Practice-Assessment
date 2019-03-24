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

* This is a multiplayer version of Go Fish. If the game is played with three or fewer players, each player begins with 7 cards. If the game is played with more than three players, each player begins with 5 cards.
* The goal of the game is to win the most 'books', or sets, of cards. A book of cards is any four of a kind of any value/rank of card, such as kings, jacks, 2s, etc.
* Cards have ranks, with 2s having the lowest rank and aces having the highest rank. Suits are not important in this game.
* A player can request any rank of card from any other player, such as all the kings from another player's hand, so long as they have at least one card of that rank in their hand. If the other player has any of the rank of card requested, they must hand over all the cards they have of that rank. If they do not, they tell the requesting player to "Go fish" and that player draws one card from the deck and places it in their hand.
* If a player successfully requests one or more cards from another player, they are entitled to continue their turn and ask any player again for any rank of card that they currently hold at least one copy of. As long as a player successfully continues to request cards, their turn continues.
* When a player gets a full book of four cards, they place it on the table in front of them and play again.
* Once a player fails to successfully make a catch/request a card from another player and has to 'go fishing' for a card in the deck, their turn ends and the turn passes to the next player.
* The game ends when all thirteen books of cards have been claimed. The player with the most books wins.
* If at any point a player has no cards in their hand, they may draw a card from the deck and ask the other player for any cards of the same rank as the card they drew. If there are no remaining cards in the deck, the player is out of the game.
