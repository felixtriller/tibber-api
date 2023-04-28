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

  describe "#productions" do
    it "returns an array with 10 records" do
      VCR.use_cassette("productions") do
        result = client.productions.last(10)

        expect(result.length).to eq(10)
      end
    end

    it "returns a record with a datetime attribute" do
      VCR.use_cassette("productions") do
        result = client.productions.last(10)

        expect(result.first.to).to be_a DateTime
      end
    end

    it "returns only one record" do
      VCR.use_cassette("productions_1") do
        result = client.productions.last

        expect(result.class).to eq(Tibber::Data::Production)
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

  describe ".to_cursor" do
    it "returns a cursor" do
      date_time = DateTime.parse("2023-04-01T00:00:00.000+02:00")

      expect(described_class.to_cursor(date_time)).to eq("MjAyMy0wNC0wMVQwMDowMDowMCswMjowMA==")
    end

    it "returns for nil param" do
      expect(described_class.to_cursor(nil)).to be_nil
    end
  end
end
