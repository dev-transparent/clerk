require "../spec_helper"

describe Clerk::User do
  describe ".get" do
    it "retrieves a user" do
      WebMock.stub(:get, "https://api.clerk.com/v1/users/1")
        .with(
          headers: {
            "Authorization" => "Bearer token",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          body: <<-BODY
            {
              "id": "1",
              "object": "user",
              "email_addresses": []
            }
          BODY
        )

      Clerk.configure do |settings|
        settings.token = "token"
      end

      user = Clerk::User.get("1")
      user.should be_a(Clerk::User)

      user.id.should eq("1")
      user.object.should eq("user")
    end

    it "handles errors" do
      WebMock.stub(:get, "https://api.clerk.com/v1/users/1")
        .with(
          headers: {
            "Authorization" => "Bearer token",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          status: 400,
          body: <<-BODY
            {
              "errors": [
                {
                  "message": "Error occurred",
                  "long_message": "A really long error occurred",
                  "code": "ERROR"
                }
              ]
            }
          BODY
        )

      Clerk.configure do |settings|
        settings.token = "token"
      end

      expect_raises Clerk::BadRequestError do
        Clerk::User.get("1")
      end
    end
  end
end
