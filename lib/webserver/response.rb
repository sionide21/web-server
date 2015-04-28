require 'webserver/status_codes'

module WebServer
  class Response
    attr_accessor :status

    def initialize(writer)
      @writer = writer
      @body = ""
      self.status = 200
    end

    def flush
      writeln(status_line)
      writeln(encode_headers)
      writeln
      write_body
    end

    def write(data)
      @body << data
    end

    private

    def status_message
      if status.respond_to?(:split) && status.split[1]
        status.split[1]
      else
        HTTP_STATUS_CODES.fetch(status.to_i, status)
      end
    end

    def status_line
      ["HTTP/1.1", status, status_message].join(" ")
    end

    def encode_headers
      headers.map { |header| header.join(": ") }.join("\r\n")
    end

    def write_body
      @writer.write(@body)
    end

    def headers
      { "Content-Length" => @body.length }
    end

    def writeln(line="")
      @writer.write(line)
      @writer.write("\r\n")
    end
  end
end
