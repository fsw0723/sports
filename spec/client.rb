require 'spec_helper'

describe Sports::Client, :vcr do
  it "should return list of soccer games" do
    client = Sports::Client.new
    client.fetch_soccer_games.first.home_team.should == "Liverpool"
    client.fetch_soccer_games.first.away_team.should == "Manchester United"
    client.fetch_soccer_games.second.home_team.should == "West Bromwich Albion"

  end
end