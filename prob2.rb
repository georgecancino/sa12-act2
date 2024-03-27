require 'httparty'

def fetch_cryptocurrency_data
  url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'
  response = HTTParty.get(url)
  response.parsed_response
end

def display_top_cryptocurrencies(data, count)
  sorted_data = data.sort_by { |crypto| crypto['market_cap'] }.reverse.take(count)

  sorted_data.each_with_index do |crypto, index|
    puts "#{index + 1}. #{crypto['name']} - Price: $#{crypto['current_price']} - Market Cap: $#{crypto['market_cap']}"
  end
end

cryptocurrency_data = fetch_cryptocurrency_data
display_top_cryptocurrencies(cryptocurrency_data, 5)
