module Sports
  class Parser
    def soccer_parser input
      matches = []
      game_date = input.css('ul.game-dates').css('li#currentDate').text
      input.css('div.group-set').each do |line|
        game_name = line.css('div.mod-header').css('h2').text
        line.css('table tr').each do |tr|
          #puts "status:#{tr.xpath('./td[1]').text}"
          #puts "home team:#{tr.xpath('./td[2]').text}"
          #puts "score:#{tr.xpath('./td[3]').text}"
          #puts "away team:#{tr.xpath('./td[4]').text}"
          #puts "\n"
          soccer = Soccer.new
          soccer.date = Time.parse(game_date).strftime("%Y-%m-%d")
          soccer.time = tr.xpath('./td[1]').text
          soccer.time == 'FT'? soccer.status = 'Finished':soccer.status = 'Not start'
          soccer.home_team = tr.xpath('./td[2]').text
          soccer.score = tr.xpath('./td[3]').text
          soccer.away_team = tr.xpath('./td[4]').text

          soccer.game = game_name
          matches << soccer
        end
        #puts "***********************************************"
      end
      return matches
    end
  end
end