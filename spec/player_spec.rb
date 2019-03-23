require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek")
  end

  it "assigns the name" do
    expect(player.name).to eq("Nick the Greek")
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) { double("hand", :return_cards => nil) }

    before(:each) { player.hand = hand }

    it "returns player's cards to the deck" do
      expect(hand).to receive(:return_cards).with(deck)
      player.return_cards(deck)
    end

    it "resets hand to nil" do
      player.return_cards(deck)
      expect(player.hand).to be_nil
    end
  end
end