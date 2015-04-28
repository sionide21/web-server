RSpec.describe WebServer::Client do
  let(:socket) { load_request("basic_get") }
  let(:client) { WebServer::Client.new(socket) }

  describe "#handle" do
    it "flushes the response" do
      expect(client.response).to receive(:flush)
      client.handle
    end

    it "closes the socket after it" do
      expect(socket).to receive(:close)
      client.handle
    end

    it "yields itself to a passed in block" do
      expect { |b| client.handle(&b) }.to yield_with_args(client)
    end
  end

  describe "#request" do
    it "is the parsed request" do
      expect(client.request.request_method).to eq("GET")
      expect(client.request.headers).not_to be_empty
    end
  end

  describe "response" do
    let(:socket) { FakeSocket.new }

    it "is the response that will write to the client" do
      client.response.write("test")
      client.response.flush

      expect(socket.written_value).to end_with("test")
    end
  end
end
