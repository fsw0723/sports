module Sports
  class Client
    def fetch_soccer_games params
      matches = Sports::Parser.new.soccer_parser(Sports::Fetcher.new.fetch_soccer(params[:date]))
      if (params[:game])
        matches = matches.select { |match| match.game.gsub(/\s+/, "") == params[:game] }
      end
      return matches
    end

    def fetch_cricket_games_schedule params
      matches = Sports::Parser.new.cricket_schedule_parser(Sports::Fetcher.new.fetch_cricket(params[:date_range]))
      return matches
    end

    def fetch_cricket_games_result
      Sports::Parser.new.cricket_result_parser(Sports::Fetcher.new.fetch_cricket_result)
    end
  end
end