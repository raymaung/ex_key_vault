defmodule ExKeyVault.Azure do

  alias HTTPoison.Response
  alias HTTPoison.Error

  alias ExKeyVault.Azure.AccessToken
  alias ExKeyVault.Azure.AccessTokenRequest

  alias ExKeyVault.Azure.Secret
  alias ExKeyVault.Azure.SecretRequest

  def get_access_token() do
    AccessTokenRequest.post()
    |> handle_response(&AccessToken.from_response/1)
  end

  def get_secret(%AccessToken{} = access_token) do
    access_token
    |> SecretRequest.get
    |> handle_response(&Secret.from_response/1)
  end

  defp handle_response({:ok, %Response{body: body}}, decoder) do
    with {:ok, response} <- Poison.decode(body),
      {:ok, resp} <- decode_response(response, decoder) do
      {:ok, resp}
    else
      {:error, error_description} ->
        {:error, error_description}
      _error ->
        raise("Unknown Error")
    end
  end

  defp handle_response({:error, %Error{reason: reason}}, _decoder) do
    {:error, reason}
  end

  defp decode_response(response, decoder) do
    case response do
      %{"error" => _error_type, "error_description" => error_description} ->
        {:error, error_description}
      response ->
        {:ok, decoder.(response)}
    end
  end
end

