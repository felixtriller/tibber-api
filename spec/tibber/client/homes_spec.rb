# frozen_string_literal: true

RSpec.describe Tibber::Client::Homes do
  subject(:homes) { described_class.new(demo_client) }

  describe "list methods" do
    it "returns 1 record" do
      VCR.use_cassette("homes") do
        result = homes.list

        expect(result.length).to eq(1)
      end
    end

    it "returns the record with the correct id" do
      VCR.use_cassette("homes") do
        result = homes.list

        expect(result.first.id).to eq("96a14971-525a-4420-aae9-e5aedaa129ff")
      end
    end
  end
end
