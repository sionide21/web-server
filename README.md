# Ruby Web Server

A very simple HTTP server implementation to teach how HTTP works.

## How to navigate the project

 * `lib/webserver/server.rb` - The server loop responsible for accepting new connections
 * `lib/webserver/client.rb` - An individual HTTP connection from a client
 * `lib/webserver/request.rb` - Handles parsing the request sent to us by the client
 * `lib/webserver/response.rb` - Handles writing a response to the client
 * `bin/run_server` - A very simple web server that says hello at http://localhost:8080

## How to use the server

**Note:** This project is for teaching about HTTP. It is not production code. You should not run your webapp on it.

You can write a handler by creating a new `WebServer` and passing a block to it. That block will be called for each incoming connection:

```ruby
WebServer.new(8080).run do |client|
  request, response = client.request, client.response

  response.write("Hello from #{request.uri.path}\n")

  if request.request_method == "POST"
    response.write("\nYou said:\n")
    response.write(request.body.read)
    response.write("\n")
  end
end
```
 You can see what methods are available on `request` and `response` in their respective files. More functionality will be added to these files as the project continues.

## Rack

[Rack](http://rack.github.io/) is an common interface that allows ruby web apps to run on many ruby servers.
Examples of Rack apps are [Rails](http://rubyonrails.org/) and [Sinatra](http://www.sinatrarb.com/).
The eventual goal of this project is to support enough HTTP and Rack that you can get a Rails application running on it.
