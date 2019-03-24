require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek")
  end

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Nick the Greek")
    end
  end

  describe "#request_cards" do
  end
end