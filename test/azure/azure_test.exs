defmodule ExKeyVault.AzureTest do
  use ExUnit.Case

  alias ExKeyVault.Azure
  alias ExKeyVault.Azure.AccessToken

  @tag :azure_api
  test "request access token" do
    assert {:ok, %AccessToken{}} = Azure.get_access_token()
  end

  @tag :azure_api_wip
  test "request secret" do
    {:ok, access_token} = Azure.get_access_token()
    assert {:ok, _} = Azure.get_secret(access_token)
  end
end