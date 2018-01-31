defmodule ExKeyVaultTest do
  use ExUnit.Case
  doctest ExKeyVault

  test "greets the world" do
    assert ExKeyVault.hello() == :world
  end
end
