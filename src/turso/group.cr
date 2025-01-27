module Turso
  struct Group
    include JSON::Serializable

    property archived : Bool
    property locations : Array(String)
    property name : String
    property primary : String
    property uuid : String
    property version : String
  end
end
