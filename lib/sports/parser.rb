require 'nokogiri'
require 'tempfile'
module Sports
  class Parser
    def initialize input_file
      @input = Nokogiri::HTML(open(input_file))
    end

    def soccer_parser
      matches = []
      game_date = @input.css('ul.game-dates').css('li#currentDate').text
      @input.css('div.group-set').each do |line|
        game_name = line.css('div.mod-header').css('h2').text
        line.css('table tr').each do |tr|
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
      end
      matches
    end

    def cricket_schedule_parser
      @date
      matches = []
      @input.css('table').search('table > tr').each do |row|
        if (!row.css('p.fixMnth').text.empty?)
          @date = Time.parse(row.css('p.fixMnth').text).strftime("%Y-%m-%d")
        elsif (row['class'] == 'ciResults')
          cricket = Cricket.new
          cricket.date = @date
          teams = row.xpath('./td[2]').text.gsub(/ v /, ',').split(",")
          cricket.home_team = clean_text teams[0]
          cricket.away_team = clean_text teams[1]
          cricket.gmt_time = row.xpath('./td[1]').text.split(" ")[0]
          matches << cricket
        end
      end
      matches
    end

    def cricket_result_parser
      matches = []
      series, cricket = nil
      @input.css('div.div630Pad').css('p').each do |row|
        if (row['class'] == 'potMatchSeriesHeading')
          series = row.text
          next
        end
        if (row['class'] == 'potMatchHeading')
          cricket = Cricket.new
          cricket.series = series
          match_info_text = row.css('a.potMatchLink').text.gsub(/ v /i, ' at ').split(' at ')
          cricket.home_team = clean_text match_info_text[0]
          cricket.away_team = clean_text match_info_text[1]
          cricket.location = clean_text match_info_text[2]
          cricket.date = clean_text row.text.split(' - ')[1]
          next
        end
        if (row['class'] == 'potMatchText mat_status')
          cricket.winner = find_winner row.text
          matches << cricket
        end
      end
      matches
    end

    private
    def clean_text text
      text.gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '').strip
    end

    def find_winner input
      if (input.include? 'won')
        winner = input.split(" ")[0]
      elsif (input.include? 'drawn')
        winner = 'drawn'
      elsif (input.include? 'abandoned')
        winner = 'abandoned'
      end
      winner
    end
  end
end