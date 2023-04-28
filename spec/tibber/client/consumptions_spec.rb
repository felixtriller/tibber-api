# frozen_string_literal: true

RSpec.describe Tibber::Client::Consumptions do
  subject(:consumptions) { described_class.new(demo_client) }

  describe "list methods" do
    it "returns an array with 10 records" do
      VCR.use_cassette("consumptions") do
        result = consumptions.last(10)

        expect(result.length).to eq(10)
      end
    end

    it "returns a record with a datetime attribute" do
      VCR.use_cassette("consumptions") do
        result = consumptions.last(10)

        expect(result.first.to).to be_a DateTime
      end
    end

    it "returns only one record" do
      VCR.use_cassette("consumptions_1") do
        result = consumptions.first

        expect(result.class).to eq(Tibber::Data::Consumption)
      end
    end
  end
end
