# frozen_string_literal: true

module ClientHelpers
  DEMO_TOKEN = "5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE"

  def demo_token
    DEMO_TOKEN
  end

  def demo_client
    Tibber::Client.new(token: demo_token)
  end
end
