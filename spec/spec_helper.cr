require "spec"
require "webmock"
require "../src/clerk"

Spec.before_each do
  WebMock.reset
end
