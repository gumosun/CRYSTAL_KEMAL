# CRYSTAL_KEMAL

## What is Crystal?
Crystal started out as an experiment to see what compiled Ruby would look like. And now Crystal is a programming language that aims to be friendly for both humans and computers alike - make developers enjoy writing code, and make code run as efficiently as it can. Statically typed, compiled language with a really heavy type inference to make it feel as scripting. 

Crystal compiles down to efficient code, which means Crystal programs are much faster than Ruby programs.

Crystal don’t work on Windows. So you have to use a Mac or a Linux based system.

Use the Crystal extension to provide support for the Crystal programming language.

![crystal](./assets/1.png)

## What is Kemal?
Kemal is the standard the facto web framework for Crystal, lightning fast and super simple.

![kemal](./assets/2.png)



## How to install
1. Install Crystal 
```
brew install crystal-lang
```
2. Create your application
```
crystal init app your_app_name
cd your_app
```
3. Add kemal to the shard.yml file as a dependency.
```
dependencies:
  kemal:
    github: kemalcr/kemal
    branch: master
```
4. Run shards to get dependencies:
```
shards install
```
## First hello world app by using crystal 
In src/your_app_name put these codes
```
require "kemal"

get "/" do
  "Hello World!"
end

Kemal.run
```
* Run the app
```
crystal run src/your_app.cr
```
* You should see some logs like these:
```
[development] Kemal is ready to lead at http://0.0.0.0:3000
```
* Go to localhost:3000
You should be able to see "Hello World!" on your browser

### HTTP Parameters
Kemal allows you to use variables in your route path as placeholders for passing data. To access URL parameters, you use env.params.url.

You can create something like this as your route

```
get "/:name" do |env|
  name = env.params.url["name"].capitalize
  puts "Hello back to #{name}"
end
```
### Templates
You can use ERB-like built-in ECR to render dynamic views.
In your routes.cr, you can directly render that ECR file.
So we can modify the codes we just wrote and render the template like this
```
get "/:name" do |env|
  name = env.params.url["name"].capitalize
  render "src/views/hello.ecr"
end
```
Then, we create a views folder under src

### Request API
In Kemal, if you want to request API you have to require some modules first
```
require "http/client"
require "json"
require "./crystal_testing/*"
require "kemal"
```
Here we used the Chuck Norris jokes API to create a sample app
```
class Chucky
  def get_joke
    response = HTTP::Client.get "http://api.icndb.com/jokes/random/1"
    JSON.parse(response.body)["value"]
  end
```


