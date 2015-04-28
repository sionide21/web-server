require 'webserver/client'

module WebServer
  class Server
    def initialize(port, interface: "0.0.0.0")
      @server = TCPServer.new(interface, port)
    end

    def run(&block)
      loop do
        Client.new(@server.accept).handle(&block)
      end
    end
  end
end
