#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe Sports::Client do
  it "should return list of soccer matches", :vcr do
    games = Sports::Client.new.fetch_soccer_games(:date => 20130901)
    games.first.game.should == "Barclays Premier League"
    games.first.home_team.should == "Liverpool"
    games.first.away_team.should == "Manchester United"
    games.first.date.should == "2013-09-01"
    games.first.time.should == "FT"
    games.first.score.should == '1 - 0'
    games.first.status.should == 'Finished'
    games.second.home_team.should == "West Bromwich Albion"
    games.count.should == 131
  end

  it "should return list of soccer matches of a game", :vcr do
    games = Sports::Client.new.fetch_soccer_games(:date => 20130901, :game => "BarclaysPremierLeague")
    games.first.game.should == "Barclays Premier League"
    games.first.home_team.should == "Liverpool"
    games.first.away_team.should == "Manchester United"
    games.first.date.should == "2013-09-01"
    games.first.time.should == "FT"
    games.first.score.should == '1 - 0'
    games.count.should == 3
  end
end