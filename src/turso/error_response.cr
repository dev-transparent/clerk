module Turso
  struct ErrorResponse
    include JSON::Serializable

    property error : String
  end
end