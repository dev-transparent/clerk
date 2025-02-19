module Turso
  struct Database
    include JSON::Serializable

    @[JSON::Field(key: "DbId")]
    property uuid : String

    @[JSON::Field(key: "Hostname")]
    property hostname : String

    @[JSON::Field(key: "Name")]
    property name : String

    def self.create(group : String, name : String) : Turso::Database
      response = Turso.pool.checkout do |client|
        client.post(
          path: "/v1/organizations/#{Turso.settings.organization}/databases",
          body: {
            "group" => group,
            "name" => name
          }.to_json
        )
      end

      response = (Turso::DatabaseResponse | Turso::ErrorResponse).from_json(response.body)

      case response
      in Turso::DatabaseResponse
        response.database
      in Turso::ErrorResponse
        raise Turso::Error.new(response.error)
      end
    end
  end
end
