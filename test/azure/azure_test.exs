defmodule ExKeyVault.AzureTest do
  use ExUnit.Case

  alias ExKeyVault.Config
  alias ExKeyVault.Azure
  alias ExKeyVault.Azure.AccessToken
  alias ExKeyVault.Azure.Secret

  @azure_config %{
    tenant_id: Config.tenant_id,
    application_id: Config.application_id,
    application_secret_key: Config.application_secret_key
  }

  @tag :azure_api
  test "request access token" do
    assert {:ok, %AccessToken{}} = Azure.get_access_token(@azure_config)
  end

  @tag :azure_api
  test "request secret" do
    secret_uri = "https://wow-exd-dev-key-mgt-aae.vault.azure.net/secrets/exd-dbp-ServiceUser-dv0/f235b5082017475a94f55447243af3b4"
    {:ok, access_token} = Azure.get_access_token(@azure_config)
    assert {:ok, %Secret{}} = Azure.get_secret(access_token, secret_uri)
  end
end
