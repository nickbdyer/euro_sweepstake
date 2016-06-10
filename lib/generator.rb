class Generator
  
  attr_reader :players

  def initialize(teams, player_names)
    @teams = teams
    @player_names = player_names
    @players = []
  end

  def generate_players
    @player_names.each do |name, num_teams|
      @players << Player.new(name, num_teams)
    end
  end

  def assign_teams
    @teams.shuffle!
    assign_first_team()
    assign_second_team()
  end

  def all_teams_assigned?
    @teams.empty?
  end

  def num_teams
    @teams.length
  end

  def num_teams_to_be_assigned
    @players.reduce(0) {|sum, player| sum += player.num_teams}
  end

  private

  def assign_first_team
    @players.each do |player|
      player.team_a = @teams.shift if player.num_teams > 0
    end
  end

  def assign_second_team
    @players.each do |player|
      player.team_b = @teams.shift if player.num_teams == 2
    end
  end
    
end

class Player

  attr_accessor :team_a, :team_b
  attr_reader :name, :num_teams

  def initialize(name, num_teams)
    @name = name
    @num_teams = num_teams
    @team_a = ""
    @team_b = ""
  end

end

teams = ["Albania", "France", "Romania", "Switzerland", "England", "Russia",
         "Slovakia", "Wales", "Germany", "Northern Ireland", "Poland",
         "Ukraine", "Croatia", "Czech Republic", "Spain", "Turkey", "Belgium",
         "Italy", "Republic of Ireland", "Sweden", "Austria", "Hungary",
         "Iceland", "Portugal"]

players_home = {
  "Ando" => 2, 
  "Andrea" => 2, 
  "Ben" => 2, 
  "Adam" => 2, 
  "Nic" => 2, 
  "Nick" => 2, 
  "Percy" => 2, 
  "Pete" => 2, 
  "Rick" => 2, 
  "Wiley" => 2, 
  "Will" => 2, 
  "James" => 2, 
  "Rick" => 2}

players_work = {
  "Nick" => 2, 
  "James" => 2, 
  "Jim" => 2, 
  "Christoph" => 2, 
  "Mollie" => 2, 
  "Priya" => 2, 
  "Daniel" => 2, 
  "Makis" => 2, 
  "CJ" => 2, 
  "Mateu" => 2, 
  "Sarah" => 1, 
  "Georgina" => 1, 
  "Felipe" => 1, 
  "Enrique" => 1}

if $0 == __FILE__

  players = players_home if ARGV[0] == "home"
  players = players_work if ARGV[0] == "work"

generator = Generator.new(teams, players)
generator.generate_players
puts generator.num_teams.to_s + " teams fed into generator"
puts generator.num_teams_to_be_assigned.to_s + " teams expected by input players"
generator.assign_teams
generator.players.each do |player|
  puts player.name + "  ---  \n Team A: " + player.team_a + "\n Team B: " + player.team_b
end
puts "Success!" if generator.all_teams_assigned?

end
