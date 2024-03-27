require 'httparty'
require 'json'

def fetch_user_repositories(username)
  response = HTTParty.get("https://api.github.com/users/#{username}/repos")
  if response.success?
    JSON.parse(response.body)
  else
    puts "Error fetching: #{response.code} - #{response.message}"
    nil
  end
end

def analyze_repositories(repositories)
  return unless repositories

  most_starred_repo = repositories.max_by { |repo| repo['stargazers_count'] }
  {
    name: most_starred_repo['name'],
    description: most_starred_repo['description'],
    stars: most_starred_repo['stargazers_count'],
    url: most_starred_repo['html_url']
  }
end

def display_most_starred_repository(repository)
  return unless repository

  puts "Most Starred Repository:"
  puts "Name: #{repository[:name]}"
  puts "Description: #{repository[:description]}"
  puts "Stars: #{repository[:stars]}"
  puts "URL: #{repository[:url]}"
end

username = 'georgecancino'
repositories = fetch_user_repositories(username)
most_starred_repository = analyze_repositories(repositories)
display_most_starred_repository(most_starred_repository)
