#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe Sports::Client, :vcr do
  context "soccer search" do
    it "should return list of soccer matches" do
      games = Sports::Client.new.fetch_soccer_games(:date => 20130901)
      games.count.should > 0
    end

    it "should return list of soccer matches of a game" do
      soccer_games = Sports::Client.new.fetch_soccer_games(:date => 20130901, :game => "BarclaysPremierLeague")
      game = soccer_games.map!{|soccer| soccer.game}
      game.reject{|game| game == 'Barclays Premier League'}.empty?.should be_true
    end

    it "should return list of not started soccer matches" do
      games = Sports::Client.new.fetch_soccer_games(:date => 20130914)
      games.count.should >0
    end
  end

  context "cricket searh" do
    it "should show match schedule" do
      games = Sports::Client.new.fetch_cricket_games_schedule date_range:7
      games.size.should > 0
    end

    it "should fetch array of match results" do
      games = Sports::Client.new.fetch_cricket_games_result
      games.size.should > 0
    end
  end

end