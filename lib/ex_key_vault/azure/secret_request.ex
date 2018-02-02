defmodule ExKeyVault.Azure.SecretRequest do

  alias ExKeyVault.Azure.AccessToken

  def get(%AccessToken{} = access_token, secret_uri) do
    headers = [
      "Authorization": "Bearer #{access_token.access_token}",
      "Accept": "Application/json; Charset=utf-8"
    ]

    params = [
      {"api-version", "2016-10-01"}
    ]

    HTTPoison.get(secret_uri, headers, params: params)
  end
end
