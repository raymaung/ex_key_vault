defmodule ExKeyVault.Azure do

  alias HTTPoison.Response
  alias HTTPoison.Error

  alias ExKeyVault.Config

  def get_access_token() do
    with {:ok, %Response{body: body}} <- post_auth_token(),
         {:ok, response} <- Poison.decode(body),
         {:ok, access_token} <- decode_response(response) do
          {:ok, access_token}
    else
      {:error, %Error{reason: reason}} ->
        {:error, reason}
      {:error, error_description} ->
        {:error, error_description}
      _error ->
        raise("Unknown Error")
    end
  end

  defp post_auth_token() do
    url = "https://login.microsoftonline.com/#{Config.tenant_id}/oauth2/token"

    body = {:form,
      grant_type: "client_credentials",
      client_id: Config.application_id,
      client_secret: Config.application_secret_key,
      resource: "https://vault.azure.net"
    }

    HTTPoison.post(url, body)
  end

  defp decode_response(response) do
    case response do
      %{"error" => _error_type, "error_description" => error_description} ->
        {:error, error_description}
      success_response ->
        {:ok, response["access_token"]}
    end
  end
end
