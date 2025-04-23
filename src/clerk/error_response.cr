module Clerk
  struct Error
    include JSON::Serializable

    property message : String
    property long_message : String
    property code : String
  end

  struct ErrorResponse
    include JSON::Serializable

    property errors : Array(Error)
  end
end
