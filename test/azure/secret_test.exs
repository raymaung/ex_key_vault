defmodule ExKeyVault.Azure.SecretTest do
  use ExUnit.Case

  alias ExKeyVault.Azure.Secret

  test "parse from response body" do
    response = %{
      "id" => "https://example.vault.azure.net/secrets/secret-1/version-1",
      "value" => "value-1",
      "attributes" => %{
        "enabled" => true,
        "created" => 1508897406,
        "updated" => 1508897406,
        "recoveryLevel" => "Purgeable"
      }
    }

    assert Secret.from_response(response) == %Secret{
      id: "https://example.vault.azure.net/secrets/secret-1/version-1",
      value: "value-1",
      recovery_level: "Purgeable",
      enabled: true,
      updated_at: 1508897406,
      created_at: 1508897406
    }
  end
end
