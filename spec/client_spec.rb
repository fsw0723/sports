#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe Sports::Client, :vcr do
  context "soccer search" do
    it "should return list of soccer matches" do
      games = Sports::Client.new.fetch_soccer_games(:date => 20130901)
      games.first.game.should == "Barclays Premier League"
      games.first.home_team.should == "Liverpool"
      games.first.away_team.should == "Manchester United"
      games.first.date.should == "2013-09-01"
      games.first.time.should == "FT"
      games.first.home_score.should == 1
      games.first.status.should == 'Finished'
      games.second.home_team.should == "West Bromwich Albion"
      games.count.should == 136
    end

    it "should return list of soccer matches of a game" do
      games = Sports::Client.new.fetch_soccer_games(:date => 20130901, :game => "BarclaysPremierLeague")
      games.first.game.should == "Barclays Premier League"
      games.first.home_team.should == "Liverpool"
      games.first.away_team.should == "Manchester United"
      games.first.date.should == "2013-09-01"
      games.first.time.should == "FT"
      games.first.home_score.should == 1
      games.count.should == 3
    end

    it "should return list of not started soccer matches", :vcr do
      games = Sports::Client.new.fetch_soccer_games(:date => 20130904)
      games.first.game.should == "Johnstone's Paint Trophy"
      games.first.home_team.should == "Bristol City"
      games.first.away_team.should == "Bristol Rovers"
      games.first.date.should == "2013-09-04"
      games.first.time.should == "FT"
      games.first.home_score.should == 2
      games.count.should == 18
    end
  end

  context "cricket searh" do
    it "should show match schedule" do
      games = Sports::Client.new.fetch_cricket_games_schedule(:date_range => 14)
      games.first.home_team.should == "England"
      games.first.away_team.should == "Australia at Manchester"
      games.first.date.should == "2013-09-08"
      games.first.gmt_time.should == "09:15"
      games[2].date.should == "2013-09-10"
    end

    it "should fetch array of match results" do
      games = Sports::Client.new.fetch_cricket_games_result
      games.size.should_not be_zero
    end
  end

end