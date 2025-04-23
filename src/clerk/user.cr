module Clerk
  struct EmailAddress
    include JSON::Serializable

    property id : String
    property object : String
    property email_address : String
  end

  struct User
    include JSON::Serializable

    property id : String
    property object : String
    property username : String?
    property first_name : String?
    property last_name : String?
    property email_addresses : Array(EmailAddress)

    def self.get(user_id : String) : Clerk::User
      response = Clerk.pool.checkout do |client|
        client.get(
          path: "/users/#{user_id}"
        )
      end

      case response.status_code.to_i
      when 200
        Clerk::User.from_json(response.body)
      when 400
        raise BadRequestError.new
      when 401
        raise UnauthorizedRequestError.new
      when 404
        raise ResourceNotFoundError.new
      else
        raise RequestError.new
      end
    end
  end
end
