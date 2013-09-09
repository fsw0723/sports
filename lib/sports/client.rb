module Sports
  class Client
    def fetch_soccer_games params
      matches = Sports::Parser.new(Sports::Fetcher.new.fetch_soccer(params[:date])).soccer_parser
      if (params[:game])
        matches = matches.select { |match| match.game.gsub(/\s+/, "") == params[:game] }
      end
      return matches
    end

    def fetch_cricket_games_schedule params
      matches = Sports::Parser.new(Sports::Fetcher.new.fetch_cricket(params[:date_range])).cricket_schedule_parser
      return matches
    end

    def fetch_cricket_games_result
      Sports::Parser.new(Sports::Fetcher.new.fetch_cricket_result).cricket_result_parser
    end
  end
end