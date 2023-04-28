# frozen_string_literal: true

RSpec.describe Tibber::Client::Productions do
  subject(:productions) { described_class.new(demo_client) }

  describe "list methods" do
    it "returns an array with 10 records" do
      VCR.use_cassette("productions") do
        result = productions.last(10)

        expect(result.length).to eq(10)
      end
    end

    it "returns a record with a datetime attribute" do
      VCR.use_cassette("productions") do
        result = productions.last(10)

        expect(result.first.to).to be_a DateTime
      end
    end

    it "returns only one record" do
      VCR.use_cassette("productions_1") do
        result = productions.last

        expect(result.class).to eq(Tibber::Data::Production)
      end
    end
  end
end
