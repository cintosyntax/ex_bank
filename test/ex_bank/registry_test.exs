defmodule Exbank.RegistryTest do
  use ExUnit.Case
  
  setup do
    start_supervised(ExBank.Registry)
    %{}
  end

  test "registering a new bank" do
    ExBank.Registry.register_bank("chase")

    {:ok, bid} = ExBank.Registry.lookup("chase")
    assert bid != nil
  end

end