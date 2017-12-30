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

  test "removes bank on crash" do
    ExBank.Registry.register_bank("chase")

    {:ok, bid} = ExBank.Registry.lookup("chase")

    Agent.stop(bid, :shutdown)

    assert ExBank.Registry.lookup("chase") == :error
  end

end