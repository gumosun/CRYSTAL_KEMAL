require "http/client"
require "json"
require "./crystal_testing/*"
require "kemal"

module Joking

class Chucky
  def get_joke
    response = HTTP::Client.get "http://api.icndb.com/jokes/random/1"
    JSON.parse(response.body)["value"]
  end
  def get_all
    response = HTTP::Client.get "http://api.icndb.com/jokes/random/100"
    JSON.parse(response.body)["value"]
  end
end
  
get "/jokes" do 
  c = Chucky.new
  jokes = c.get_joke
  render "src/views/jokes.ecr"
end

get "/jokes/all" do 
  c = Chucky.new
  jokes = c.get_all
  render "src/views/alljokes.ecr"
end

Kemal.run
end