defmodule ExKeyVault.KeyVault do

  alias __MODULE__

  @azure_api Application.get_env :ex_key_vault, :azure_api

  defstruct [
    access_token: nil,
    secret_uris: nil,
    secrets: nil
  ]

  def new(secret_uris) do
    %KeyVault{secret_uris: secret_uris}
  end

  def fetch(%KeyVault{} = key_vault) do
    key_vault
    |> fetch_access_token
    |> fetch_secrets
  end

  defp fetch_access_token(%KeyVault{} = key_vault) do
    {:ok, access_token} = azure_config() |> @azure_api.get_access_token()
    %KeyVault{key_vault | access_token: access_token}
  end

  defp fetch_secrets(%KeyVault{} = key_vault) do
    secrets =
      key_vault.secret_uris
      |> Enum.map(
        fn uri ->
          {:ok, secret} = @azure_api.get_secret(key_vault.access_token, uri)
          secret
        end)

    %KeyVault{key_vault | secrets: secrets}
  end

  defp azure_config do
    %{
      tenant_id: Application.get_env(:ex_key_vault, :tenant_id),
      application_id: Application.get_env(:ex_key_vault, :application_id),
      application_secret_key: Application.get_env(:ex_key_vault, :application_secret_key)
    }
  end
end
