defmodule ExKeyVault.Azure.Secret do

  defstruct [
    id: nil,
    value: nil,
    recovery_level: nil,
    enabled: nil,
    updated_at: nil,
    created_at: nil
  ]

  alias __MODULE__

  def from_response(%{"attributes" => attributes} = response)do
    %Secret{
      id: response["id"],
      value: response["value"],
      recovery_level: attributes["recoveryLevel"],
      enabled: attributes["enabled"],
      created_at: attributes["created"],
      updated_at: attributes["updated"]
    }
  end
end
