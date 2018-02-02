defmodule ExKeyVault.Azure.AccessTokenRequest do

  alias ExKeyVault.Config

  def post do
    url = "https://login.microsoftonline.com/#{Config.tenant_id}/oauth2/token"

    body = {:form,
      grant_type: "client_credentials",
      client_id: Config.application_id,
      client_secret: Config.application_secret_key,
      resource: "https://vault.azure.net"
    }

    HTTPoison.post(url, body)
  end
end
