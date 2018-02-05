defmodule KeyVaultTest do
  use ExUnit.Case

  alias ExKeyVault.KeyVault

  @secret_uris [
    "https://secret-uri-1",
    "https://secret-uri-2",
  ]

  test "fetch secrets" do
    key_vault =
      @secret_uris
      |> KeyVault.new
      |> KeyVault.fetch

    assert key_vault.access_token != nil
    assert key_vault.secrets |> Enum.count == 2
  end
end
