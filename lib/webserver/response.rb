module WebServer
  class Response
    def initialize(writer)
      @writer = writer
      @body = ""
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

    def status_line
      "HTTP/1.1 200 OK"
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
