module Sports
  class Parser
    def soccer_parser input
      games = []
      input.css('div.group-set').each do |line|
        game_name = line.css('div.mod-header').text
        line.css('table tr').each do |tr|
          #puts "status:#{tr.xpath('./td[1]').text}"
          #puts "home team:#{tr.xpath('./td[2]').text}"
          #puts "score:#{tr.xpath('./td[3]').text}"
          #puts "away team:#{tr.xpath('./td[4]').text}"
          #puts "\n"
          soccer = Soccer.new
          soccer.away_team = tr.xpath('./td[4]').text
          soccer.home_team = tr.xpath('./td[2]').text
          soccer.game = game_name
          games << soccer
        end
        #puts "***********************************************"
      end
      return games
    end
  end
end