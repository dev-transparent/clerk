module Clerk
  struct EmailAddress
    include JSON::Serializable

    property id : String
    property object : String
    property email_address : String
  end
end
