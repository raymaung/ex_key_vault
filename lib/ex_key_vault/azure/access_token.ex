defmodule ExKeyVault.Azure.AccessToken do

  defstruct [
    access_token: nil,
    expires_on: nil,
    token_type: nil
  ]

  alias __MODULE__

  def from_response(response) when is_map(response) do
    %AccessToken{
      access_token: response["access_token"],
      expires_on: response["expires_on"],
      token_type: response["token_type"]
    }
  end
end
