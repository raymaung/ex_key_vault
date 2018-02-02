defmodule ExKeyVault.Azure.SecretRequest do

  alias ExKeyVault.Azure.AccessToken

  def get(%AccessToken{} = access_token) do

    url = "https://wow-exd-dev-key-mgt-aae.vault.azure.net/secrets/exd-dbp-ServiceUser-dv0/f235b5082017475a94f55447243af3b4"

    headers = [
      "Authorization": "Bearer #{access_token.access_token}",
      "Accept": "Application/json; Charset=utf-8"
    ]

    params = [
      {"api-version", "2016-10-01"}
    ]

    HTTPoison.get(url, headers, params: params)
  end
end
