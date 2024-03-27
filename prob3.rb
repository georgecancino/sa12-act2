require 'httparty'

def fetch_current_time(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)
  data = JSON.parse(response.body)
  current_time = data['datetime']
  formatted_time = DateTime.parse(current_time).strftime('%Y-%m-%d %H:%M:%S')
  puts "The current time in #{area}/#{location} is #{formatted_time}"
end

fetch_current_time("Europe", "London")
