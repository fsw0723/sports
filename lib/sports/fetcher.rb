require 'open-uri'
require 'nokogiri'
require 'tempfile'

module Sports
  class Fetcher
    def fetch_soccer date
      Nokogiri::HTML(open("http://espnfc.com/scores?cc=4716&date=#{date}&league=all&xhr=1"))
    end

    def fetch_mlb
      Nokogiri::HTML(open("http://scores.espn.go.com/mlb/scoreboard"))
    end

    def fetch_cricket date_range
      Nokogiri::HTML(open("http://www.espncricinfo.com/ci/content/current/match/fixtures/index.html?wrappertype=print;days=#{date_range};all=0;live=0;team=0"))
    end

    def fetch_cricket_result
      fetch_content "http://www.espncricinfo.com/ci/engine/match/scores/recent.html?days=7"
    end

    private
    def fetch_content file_uri
      file = Tempfile.new("file")
      open(file_uri) {|uri| file.write(uri.read)}
      file
    end
  end
end
