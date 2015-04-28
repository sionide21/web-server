require 'webserver/server'

module WebServer
  def self.new(*args)
    Server.new(*args)
  end
end
