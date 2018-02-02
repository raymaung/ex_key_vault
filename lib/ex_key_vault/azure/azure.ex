defmodule ExKeyVault.Azure do

  alias HTTPoison.Response
  alias HTTPoison.Error

  alias ExKeyVault.Azure.AccessToken
  alias ExKeyVault.Azure.AccessTokenRequest
  alias ExKeyVault.Azure.SecretRequest

  def get_access_token() do
    with {:ok, %Response{body: body}} <- AccessTokenRequest.post(),
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

  def get_secret(%AccessToken{} = access_token) do
    SecretRequest.get(access_token)
  end

  defp decode_response(response) do
    case response do
      %{"error" => _error_type, "error_description" => error_description} ->
        {:error, error_description}
      response ->
        {:ok, AccessToken.from_response(response)}
    end
  end
end

