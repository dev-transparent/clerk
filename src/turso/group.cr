module Turso
  struct Group
    include JSON::Serializable

    property archived : Bool
    property locations : Array(String)
    property name : String
    property primary : String
    property uuid : String
    property version : String

    def self.create(location : String, name : String)
      response = Turso.pool.checkout do |client|
        client.post(
          path: "/v1/organizations/#{Turso.settings.organization}/groups",
          body: {
            "location" => location,
            "name" => name
          }.to_json
        )
      end

      (Turso::GroupResponse | Turso::ErrorResponse).from_json(response.body)
    end
  end
end
