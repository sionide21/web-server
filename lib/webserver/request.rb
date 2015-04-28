require "stringio"
require "uri"

module WebServer
  class Request
    def initialize(reader)
      @raw_headers = extract_headers(reader)
      @body_reader = reader
    end

    def request_method
      status_line[0]
    end

    def uri
      URI.parse(status_line[1])
    end

    def headers
      @headers ||= parse_headers
    end

    def body
      @body ||= read_body
    end

    private

    def content_length
      headers["Content-Length"].to_i
    end

    def status_line
      @status_line ||= @raw_headers.first.split(/\s/)
    end

    def extract_headers(reader)
      lines = Enumerator.new { |y| loop { y << reader.readline.strip } }
      lines.take_while { |line| !line.empty? }
    end

    def parse_headers
      Hash[@raw_headers.drop(1).map { |line| line.split(/:/, 2).map(&:strip) }]
    end

    def read_body
      StringIO.new(@body_reader.read(content_length))
    end
  end
end
