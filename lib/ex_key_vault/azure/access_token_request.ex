defmodule ExKeyVault.Azure.AccessTokenRequest do

  def post(%{
    tenant_id: tenant_id,
    application_id: application_id,
    application_secret_key: application_secret_key
  }) do
    url = "https://login.microsoftonline.com/#{tenant_id}/oauth2/token"

    body = {:form,
      grant_type: "client_credentials",
      client_id: application_id,
      client_secret: application_secret_key,
      resource: "https://vault.azure.net"
    }

    HTTPoison.post(url, body)
  end
end
