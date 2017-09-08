require "./crystal_testing/*"
require "kemal"

module CrystalTesting
get "/" do
  "Hello World"
end

get "/:name" do |env|
  name = env.params.url["name"].capitalize
  render "src/views/hello.ecr"
end

Kemal.run
end