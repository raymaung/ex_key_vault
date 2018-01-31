defmodule ExKeyVault.Config do

  def tenant_id do
    Application.get_env :ex_key_vault, :tenant_id
  end

  def application_id do
    Application.get_env :ex_key_vault, :application_id
  end

  def application_secret_key do
    Application.get_env :ex_key_vault, :application_secret_key
  end
end
