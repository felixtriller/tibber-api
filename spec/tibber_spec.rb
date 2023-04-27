# frozen_string_literal: true

RSpec.describe Tibber do
  it "has a version number" do
    expect(Tibber::VERSION).not_to be_nil
  end

  describe "configuration" do
    it "sets the configuration" do
      described_class.configure do |config|
        config.token = "my-token"
      end

      expect(described_class.configuration.token).to eq("my-token")
    end
  end
end
