require "db"
require "habitat"
require "json"
require "http/client"

module Turso
  Habitat.create do
    setting url : String = "https://api.turso.tech"
    setting organization : String
    setting token : String
  end

  @@pool : DB::Pool(HTTP::Client)? = nil

  def self.pool : DB::Pool(HTTP::Client)
    @@pool ||= DB::Pool.new {
      client = HTTP::Client.new(URI.parse(Turso.settings.url))

      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{Turso.settings.token}"
        request.headers["Content-Type"] = "application/json"
      end

      client
    }
  end
end

require "./turso/*"