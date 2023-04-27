# frozen_string_literal: true

RSpec.describe Tibber::Data::Home do
  subject(:home) { described_class.new(id: "96a14971-525a-4420-aae9-e5aedaa129ff", app_nickname: "Home") }

  it "returns attributes" do
    expect(home.attributes.keys).to contain_exactly(:id, :app_nickname)
  end
end
