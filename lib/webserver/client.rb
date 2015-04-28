require 'webserver/request'
require 'webserver/response'

module WebServer
  class Client
    def initialize(socket)
      @socket = socket
    end

    def handle
      yield(self) if block_given?
      response.flush
      @socket.close
    end

    def request
      @request ||= Request.new(@socket)
    end

    def response
      @repsonse ||= Response.new(@socket)
    end
  end
end
