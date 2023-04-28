# frozen_string_literal: true

RSpec.describe Tibber::Client do
  subject(:client) do
    described_class.new(token: demo_token)
  end

  describe "#homes" do
    it "returns the instance" do
      expect(client.homes).to be_an_instance_of(Tibber::Client::Homes)
    end

    it "knows the client" do
      expect(client.homes.client).to eq(client)
    end
  end

  describe "#prices" do
    it "returns the instance" do
      expect(client.prices).to be_an_instance_of(Tibber::Client::Prices)
    end

    it "knows the client" do
      expect(client.prices.client).to eq(client)
    end
  end

  describe "#consumptions" do
    it "returns the instance" do
      expect(client.consumptions).to be_an_instance_of(Tibber::Client::Consumptions)
    end

    it "knows the client" do
      expect(client.consumptions.client).to eq(client)
    end
  end

  describe "#productions" do
    it "returns the instance" do
      expect(client.productions).to be_an_instance_of(Tibber::Client::Productions)
    end

    it "knows the client" do
      expect(client.productions.client).to eq(client)
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
