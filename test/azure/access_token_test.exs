defmodule ExKeyVault.Azure.AccessTokenTest do
  use ExUnit.Case

  alias ExKeyVault.Azure.AccessToken

  test "parse from response body" do

    response = %{
      "access_token" => "token-1",
      "expires_in" => "3599",
      "expires_on" => "1517532296",
      "ext_expires_in" => "0",
      "not_before" => "1517528396",
      "resource" => "https://vault.azure.net",
      "token_type" => "Bearer"
    }

    assert AccessToken.from_response(response) == %AccessToken{
      access_token: "token-1",
      expires_on: "1517532296",
      token_type: "Bearer"
    }
  end
end
