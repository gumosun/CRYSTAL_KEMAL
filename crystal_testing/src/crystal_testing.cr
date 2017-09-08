require "./crystal_testing/*"
require "kemal"

module CrystalTesting
get "/" do
  "Hello we are Bri and Hao!!"
end

get "/:name" do |env|
  name = env.params.url["name"].capitalize
  render "src/views/hello.ecr"
end

Kemal.run
end
