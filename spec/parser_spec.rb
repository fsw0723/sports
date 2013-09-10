require 'spec_helper'

describe Sports::Parser do
  context "cricket parser" do
    it "should return array of parsed cricket match results from file" do
      games = Sports::Parser.new(File.open("out.txt")).cricket_result_parser
      games.first.series.should == "Test matches"
      games.first.home_team.should == 'Zimbabwe'
      games.first.away_team.should == 'Pakistan'
      games.first.location.should == 'Harare'
      games.first.winner.should == 'Pakistan'
      games.first.date.should == 'Sep 3-7, 2013'
      games[4].winner.should == 'abandoned'

    end
  end
end