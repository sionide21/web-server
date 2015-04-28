RSpec.describe WebServer::Response do
  let(:socket) { FakeSocket.new }
  let(:response) { WebServer::Response.new(socket) }

  describe "#flush" do
    it "writes the response out" do
      response.flush
      expect(socket.written_value).to eq("HTTP/1.1 200 OK\r\nContent-Length: 0\r\n\r\n")
    end
  end

  describe "#write" do
    before(:each) do
      response.write("Hello ")
      response.write("World")
      response.flush
    end

    it "appends to the response body" do
      body = socket.written_value.split("\r\n\r\n").last
      expect(body).to eq("Hello World")
    end

    it "updates the content-length" do
      expect(socket.written_value).to include("Content-Length: 11")
    end
  end

  describe "#status=" do
    it "sets the status code and message" do
      response.status = 400
      response.flush
      expect(socket.written_value).to start_with("HTTP/1.1 400 Bad Request")
    end

    it "accepts custom codes" do
      response.status = 444
      response.flush
      expect(socket.written_value).to start_with("HTTP/1.1 444 444")
    end

    it "accepts strings" do
      response.status = "403"
      response.flush
      expect(socket.written_value).to start_with("HTTP/1.1 403 Forbidden")
    end

    it "can include the message" do
      response.status = "403 Leave Me Be"
      response.flush
      expect(socket.written_value).to start_with("HTTP/1.1 403 Leave Me Be")
    end
  end
end
