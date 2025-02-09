require "./database"

module Turso
  struct DatabaseResponse
    include JSON::Serializable

    property database : Database
  end
end
