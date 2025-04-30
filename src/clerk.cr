require "db"
require "habitat"
require "json"
require "http/client"

module Clerk
  Habitat.create do
    setting url : String = "https://api.clerk.com"
    setting token : String
  end

  @@pool : DB::Pool(HTTP::Client)? = nil

  def self.pool : DB::Pool(HTTP::Client)
    @@pool ||= DB::Pool.new(initial_pool_size: 0, max_idle_pool_size: 25) {
      client = HTTP::Client.new(URI.parse(Clerk.settings.url))

      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{Clerk.settings.token}"
        request.headers["Content-Type"] = "application/json"
      end

      client
    }
  end
end

require "./clerk/*"
