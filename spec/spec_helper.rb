require 'webserver'
require 'fake_socket'

PROJECT_ROOT = File.expand_path("..", File.dirname(__FILE__))

def fixture_path(path)
  File.expand_path("spec/fixtures/#{path}", PROJECT_ROOT)
end

def load_request(file)
  StringIO.new(File.read(fixture_path("requests/#{file}.req")))
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed
end
