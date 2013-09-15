require 'spec_helper'

describe Sports::Parser do
  context "soccer parser" do
    it "should return array of finished soccer matches" do
      games = Sports::Parser.new(File.open("spec/inputs/finished_soccer.txt")).soccer_parser
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

    it "should return array of future soccer matches" do
      games = Sports::Parser.new(File.open("spec/inputs/future_soccer.txt")).soccer_parser
      games.first.game.should == "Barclays Premier League"
      games.first.home_team.should == "Manchester United"
      games.first.away_team.should == "Crystal Palace"
      games.first.date.should == "2013-09-14"
      games.first.time.should == "11:45"
      games.first.home_score.should == 0
      games.first.status.should == 'Not start'
      games.count.should == 231
    end
  end

  context "cricket parser" do
    it "should return array of cricket match schedules" do
      games = Sports::Parser.new(File.open("spec/inputs/cricket_schedule.txt")).cricket_schedule_parser
      games.first.home_team.should == "Zimbabwe"
      games.first.away_team.should == "Pakistan at Harare"
      games.first.date.should == "2013-09-10"
      games.first.gmt_time.should == "08:00"
      games[2].date.should == "2013-09-11"
    end
    it "should return array of cricket match results from file" do
      games = Sports::Parser.new(File.open("spec/inputs/cricket_result.txt")).cricket_result_parser
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