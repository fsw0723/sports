module Sports
  class Client
    def fetch_soccer_games  date
      Sports::Parser.new.soccer_parser(Sports::Fetcher.new.fetch_soccer(date))
    end
  end
end