# frozen_string_literal: true

RSpec.describe Tibber::Client::Prices do
  subject(:prices) { described_class.new(demo_client) }

  describe "day methods" do
    it "returns the current price object" do
      VCR.use_cassette("prices_current") do
        result = prices.current

        expect(result.class).to eq(Tibber::Data::Price)
      end
    end

    it "returns and array for todays prices" do
      VCR.use_cassette("prices_today") do
        result = prices.today

        expect(result.first.starts_at).to be_a DateTime
      end
    end

    it "returns and array for tomorrows prices" do
      VCR.use_cassette("prices_tomorrow") do
        result = prices.tomorrow

        expect(result).to be_a Array
      end
    end
  end

  describe "list methods" do
    it "returns an array with 10 records" do
      VCR.use_cassette("prices") do
        result = prices.last(10)

        expect(result.length).to eq(10)
      end
    end

    it "returns a record with a datetime attribute" do
      VCR.use_cassette("prices") do
        result = prices.last(10)

        expect(result.first.starts_at).to be_a DateTime
      end
    end

    it "returns only one record" do
      VCR.use_cassette("prices_1") do
        result = prices.first

        expect(result.class).to eq(Tibber::Data::Price)
      end
    end
  end
end
