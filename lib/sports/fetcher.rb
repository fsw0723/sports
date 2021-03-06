require 'open-uri'
require 'tempfile'

module Sports
  class Fetcher
    def fetch_soccer date
      fetch_content "http://espnfc.com/scores?cc=4716&date=#{date}&league=all&xhr=1"
    end

    #def fetch_mlb
    #  Nokogiri::HTML(open("http://scores.espn.go.com/mlb/scoreboard"))
    #end

    def fetch_cricket date_range
      fetch_content "http://www.espncricinfo.com/ci/content/current/match/fixtures/index.html?wrappertype=print;days=#{date_range};all=0;live=0;team=0"
    end

    def fetch_cricket_result
      fetch_content "http://www.espncricinfo.com/ci/engine/match/scores/recent.html?days=7"
    end

    private
    def fetch_content file_uri
      file = Tempfile.new("file")
      open(file_uri) { |uri| file.write(uri.read) }
      #out_file = File.new("out.txt", "w")
      #open(file_uri) { |uri| out_file.puts(uri.read) }
      #out_file.close
      file
    end
  end
end
