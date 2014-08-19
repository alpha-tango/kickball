require 'csv'
require 'pry'

players = []
CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
  players << row.to_hash
end

# [
#   {:first_name=>"Bart",
#     :last_name=>"Simpson",
#     :position=>"Catcher",
#     :team=>"Simpson Slammers"},
# ]

teams = []
players.each do |player|
  teams << player[:team]
end
teams.uniq!

positions = []
players.each do |player|
  positions << player[:position]
end
positions.uniq!

league = {}
league[:team]=teams
league[:position]=positions

binding.pry
