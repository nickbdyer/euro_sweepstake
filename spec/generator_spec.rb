require 'rspec'
require 'generator'

describe Generator do

  it "can assign a team to a player" do
    generator = Generator.new(["Spain"], {"Nick" => 1})
    generator.generatePlayers
    generator.assignTeams
    expect(generator.players[0].name).to eq "Nick"
    expect(generator.players[0].team_a).to eq "Spain"
  end

  it "can assign two teams to a player" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 2})
    generator.generatePlayers
    generator.assignTeams
    expect(generator.players[0].name).to eq "Nick"
    expect(generator.players[0].team_a).not_to eq ""
    expect(generator.players[0].team_b).not_to eq ""
  end

  it "will not assign two teams to a player expecting one team" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 1})
    generator.generatePlayers
    generator.assignTeams
    expect(generator.players[0].name).to eq "Nick"
    expect(generator.players[0].team_a).not_to eq ""
    expect(generator.players[0].team_b).to eq ""
  end

  it "knows if all the teams have been assigned" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 2})
    generator.generatePlayers
    generator.assignTeams
    expect(generator.all_teams_assigned?).to be true
  end

  it "knows if all the teams have not been assigned" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 1})
    generator.generatePlayers
    generator.assignTeams
    expect(generator.all_teams_assigned?).to be false
  end

  it "knows how many teams there are" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 1})
    expect(generator.num_teams).to eq 2
  end

  it "knows how many teams there are to be assigned" do
    generator = Generator.new(["Spain", "Germany"], {"Nick" => 1})
    generator.generatePlayers
    expect(generator.num_teams_to_be_assigned).to eq 1
  end

end
