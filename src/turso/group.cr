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

      response = (Turso::GroupResponse | Turso::ErrorResponse).from_json(response.body)

      case response
      in Turso::GroupResponse
        response.group
      in Turso::ErrorResponse
        raise Turso::Error.new(response.error)
      end
    end
  end
end
