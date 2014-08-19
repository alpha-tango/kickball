require 'sinatra'
require 'csv'
# require 'pry'

#####################
#Get info from CSV
######################

league = []
CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
  league << row.to_hash
end

# [
#   {:first_name=>"Bart",
#     :last_name=>"Simpson",
#     :position=>"Catcher",
#     :team=>"Simpson Slammers"},
# ]

########################
#Arrange into usable arrays
########################

teams = []
league.each do |player|
  teams << player[:team]
end
teams.uniq!

positions = []
league.each do |player|
  positions << player[:position]
end
positions.uniq!

############################
# Create home page that lists teams and positions
############################

get '/' do
  @teams = teams
  @positions = positions
  erb :index
end

########################
#Create page for each team & list players
########################

get '/team/:team_name' do
  @teams = teams
  @league = league
  erb :team_show
end

#######################
#Creat page for each position & players
#######################

get '/position/:position' do
  @position = positions
  @league = league
  erb :position_show
end


# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
