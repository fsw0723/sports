module Sports
  class Client
    def fetch_soccer_games  params
      matches = Sports::Parser.new.soccer_parser(Sports::Fetcher.new.fetch_soccer(params[:date]))
      if(params[:game])
         matches = matches.select{|match| match.game.gsub(/\s+/, "") == params[:game]}
      end
      return matches
    end
  end
end