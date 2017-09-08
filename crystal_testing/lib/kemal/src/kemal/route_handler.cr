require "radix"

module Kemal
  # Kemal::RouteHandler is the main handler which handles all the HTTP requests. Routing, parsing, rendering e.g
  # are done in this handler.
  class RouteHandler
    include HTTP::Handler
    INSTANCE = new

    property http_routes
    property ws_routes

    def initialize
      @http_routes = Radix::Tree(Route).new
      @ws_routes = Radix::Tree(String).new
    end

    def call(context : HTTP::Server::Context)
      process_request(context)
    end

    # Adds a given route to routing tree. As an exception each `GET` route additionaly defines
    # a corresponding `HEAD` route.
    def add_http_route(method : String, path : String, &handler : HTTP::Server::Context -> _)
      add_to_http_radix_tree method, path, Route.new(method, path, &handler)
      add_to_http_radix_tree("HEAD", path, Route.new("HEAD", path) { |ctx| "" }) if method == "GET"
    end

    def add_ws_route(path : String)
      add_to_ws_radix_tree path
    end

    # Check if a route is defined and returns the lookup
    def lookup_route(verb : String, path : String)
      @http_routes.find radix_path(verb, path)
    end

    def lookup_ws_route(path : String)
      @ws_routes.find "/ws#{path}"
    end

    # Processes the route if it's a match. Otherwise renders 404.
    private def process_request(context)
      raise Kemal::Exceptions::RouteNotFound.new(context) unless context.route_defined?
      content = context.route.handler.call(context)
    ensure
      if Kemal.config.error_handlers.has_key?(context.response.status_code)
        raise Kemal::Exceptions::CustomException.new(context)
      end
      context.response.print(content)
      context
    end

    private def radix_path(method, path)
      "/#{method.downcase}#{path}"
    end

    private def add_to_http_radix_tree(method, path, route)
      node = radix_path method, path
      @http_routes.add node, route
    end

    private def add_to_ws_radix_tree(path)
      node = radix_path "ws", path
      @ws_routes.add node, node
    end
  end
end
