module Turso
  struct Token
    include JSON::Serializable

    property jwt : String

    def self.create(database : String)
      response = Turso.pool.checkout do |client|
        client.post(
          path: "/v1/organizations/#{Turso.settings.organization}/databases/#{database}/auth/tokens",
        )
      end

      response = (Turso::Token | Turso::ErrorResponse).from_json(response.body)

      case response
      in Turso::Token
        response
      in Turso::ErrorResponse
        raise Turso::Error.new(response.error)
      end
    end
  end
end
