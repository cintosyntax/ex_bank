defmodule ExBank.BankTest do
  use ExUnit.Case

  test "are temporary workers" do
    assert Supervisor.child_spec(ExBank.Bank, []).restart == :temporary
  end

end