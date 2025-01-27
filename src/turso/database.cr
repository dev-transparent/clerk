module Turso
  struct Database
    include JSON::Serializable

    @[JSON::Field(key: "DbId")]
    property id : String

    @[JSON::Field(key: "Hostname")]
    property hostname : String

    @[JSON::Field(key: "Name")]
    property name : String
  end
end
