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
          soccer.time == 'FT' ? soccer.status = 'Finished' : soccer.status = 'Not start'
          soccer.home_team = tr.xpath('./td[2]').text

          score = tr.xpath('./td[3]').text
          if (soccer.status == 'Finished')
            soccer.home_score = score.split("-")[0].to_i
            soccer.away_score = score.split("-")[1].to_i
          else
            soccer.away_score = 0
            soccer.home_score = 0

          end
          soccer.away_team = tr.xpath('./td[4]').text
          soccer.game = game_name
          matches << soccer
        end
        #puts "***********************************************"
      end
      return matches
    end

    def cricket_parser input
      @date
      matches = []
      input.css('table').search('table > tr').each do |row|
        if(!row.css('p.fixMnth').text.empty?)
          puts @date = Time.parse(row.css('p.fixMnth').text).strftime("%Y-%m-%d")
        elsif(row['class'] == 'ciResults')
          puts row.xpath('./td[1]').text
          puts row.xpath('./td[2]').text
          puts "\n"
          cricket = Cricket.new
          cricket.date = @date
          team = row.xpath('./td[2]').text.gsub(/ v /i, ",").split(",")
          puts team[0]
          cricket.home_team = team[0].gsub(/\r?\n/, '')
          cricket.away_team = team[1].gsub(/\r?\n/, '')
          matches << cricket
        end
      end
      return matches
    end
  end
end