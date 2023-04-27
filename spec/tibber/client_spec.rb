# frozen_string_literal: true

RSpec.describe Tibber::Client do
  let(:client) do
    described_class.new(token: "5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE")
  end

  describe "#consumptions" do
    it "returns an array with 10 records" do
      VCR.use_cassette("consumptions") do
        result = client.consumptions.last(10)

        expect(result.length).to eq(10)
      end
    end

    it "returns a record with a datetime attribute" do
      VCR.use_cassette("consumptions") do
        result = client.consumptions.last(10)

        expect(result.first.to).to be_a DateTime
      end
    end

    it "returns only one record" do
      VCR.use_cassette("consumptions_1") do
        result = client.consumptions.first

        expect(result.class).to eq(Tibber::Data::Consumption)
      end
    end
  end

  describe "#homes" do
    it "returns 1 record" do
      VCR.use_cassette("homes") do
        result = client.homes.list

        expect(result.length).to eq(1)
      end
    end

    it "returns the record with the correct id" do
      VCR.use_cassette("homes") do
        result = client.homes.list

        expect(result.first.id).to eq("96a14971-525a-4420-aae9-e5aedaa129ff")
      end
    end
  end

  describe "error handling" do
    it "catches parameter errors" do
      VCR.use_cassette("consumptions_error") do
        expect do
          client.consumptions.last(resolution: "BIWEEKLY")
        end.to raise_error(Tibber::Error, /invalid value/)
      end
    end

    it "catches hidden errors" do
      VCR.use_cassette("consumptions_hidden_error") do
        expect { client.consumptions.list }.to raise_error(Tibber::Error, /"first" or "last"/)
      end
    end
  end
end
