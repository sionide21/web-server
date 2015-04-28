RSpec.describe WebServer::Request do
  let(:request_fixture) { load_request("basic_get") }
  let(:request) { WebServer::Request.new(request_fixture) }


  describe "#request_method" do
    it "is the HTTP method of the request" do
      expect(request.request_method).to eq("GET")
    end
  end

  describe "#uri" do
    it "is the parsed request uri" do
      expect(request.uri.path).to eq("/")
    end
  end

  describe "#headers" do
    it "is the parsed HTTP headers" do
      expect(request.headers).to include("Host" => "example.com")
    end
  end

  describe "#body" do
    let(:request_fixture) { load_request("basic_post") }

    it "responds to gets" do
      expect(request.body.gets).to eq("Test 123")
      expect(request.body.gets).to be_nil
    end

    it "responds to read" do
      expect(request.body.read).to eq("Test 123")
    end

    it "responds to rewind" do
      expect(request.body.gets).to eq("Test 123")
      request.body.rewind
      expect(request.body.gets).to eq("Test 123")
    end
  end
end
