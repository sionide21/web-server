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
end
