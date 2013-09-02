require 'open-uri'
require 'nokogiri'

module Sports
  class Fetcher
    def fetch_soccer date
      Nokogiri::HTML(open("http://espnfc.com/scores?cc=4716&date=#{date}&league=all&xhr=1"))
    end

    def fetch_mlb
      Nokogiri::HTML(open("http://scores.espn.go.com/mlb/scoreboard"))
    end
  end
end

#require 'nokogiri'
#require 'open-uri'
#doc = Nokogiri::HTML(open("http://espn.go.com/sports/scores#upcoming"))
#doc.css('div.group-set').each do |line|
#  puts "Name:#{doc.xpath("//div[@id='completed']").text}"
#  line.css('table tr').each do |tr|
#    puts "status:#{tr.xpath('./td[1]').text}"
#    puts "home team:#{tr.xpath('./td[2]').text}"
#    puts "score:#{tr.xpath('./td[3]').text}"
#    puts "away team:#{tr.xpath('./td[4]').text}"
#    puts "\n"
#  end
#  puts "***********************************************"
#end
#
#require 'nokogiri'
#require 'open-uri'
#doc = Nokogiri::HTML(open("http://scores.espn.go.com/mlb/scoreboard"))
#doc.css('div#gamesLeft-1').css('div.mod-content').each do |line|
#  puts "home team:#{line.css('div.team.home').css('div.team-capsule').css('a').text }"
#  puts "away team:#{line.css('div.team.away').css('div.team-capsule').css('a').text }"
#  puts "away team score:#{line.css('div.team.away').css('ul').xpath("li[1]").text }"
#end

