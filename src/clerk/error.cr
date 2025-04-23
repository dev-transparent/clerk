require "./error_response"

module Clerk
  class RequestError < Exception
  end

  class BadRequestError < RequestError
  end

  class UnauthorizedRequestError < RequestError
  end

  class ResourceNotFoundError < RequestError
  end

  class UnexpectedError < Exception
  end
end
