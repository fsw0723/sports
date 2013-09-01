require 'spec_helper'

describe Sports::Client, :vcr do
  it "should return list of soccer games" do
    games = Sports::Client.new.fetch_soccer_games(20130901)
    games.first.home_team.should == "Liverpool"
    games.first.away_team.should == "Manchester United"
    games.second.home_team.should == "West Bromwich Albion"

  end
end