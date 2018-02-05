defmodule ExKeyVault.AzureMock do

  alias ExKeyVault.Azure.AccessToken
  alias ExKeyVault.Azure.Secret

  def get_access_token(_params) do
    {:ok, %AccessToken{}}
  end

  def get_secret(%AccessToken{}, _secret_uri) do
    {:ok, %Secret{}}
  end
end

