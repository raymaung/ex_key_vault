defmodule KeyVaultTest do
  use ExUnit.Case

  alias ExKeyVault.KeyVault

  @secret_uris [
    "https://wow-exd-dev-key-mgt-aae.vault.azure.net/secrets/exd-dbp-ServiceUser-dv0/f235b5082017475a94f55447243af3b4"
  ]

  @tag :integration
  test "fetch secrets" do
    key_vault =
      @secret_uris
      |> KeyVault.new
      |> KeyVault.fetch

    assert key_vault.access_token != nil
    assert key_vault.secrets |> Enum.count == 1
  end
end
