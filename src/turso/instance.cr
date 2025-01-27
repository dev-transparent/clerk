module Turso
  struct Instance
    include JSON::Serializable

    property hostname : String
    property name : String
    property region : String
    property type : String
    property uuid : String
  end
end
