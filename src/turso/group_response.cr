require "./group"

module Turso
  struct GroupResponse
    include JSON::Serializable

    property group : Group
  end
end
