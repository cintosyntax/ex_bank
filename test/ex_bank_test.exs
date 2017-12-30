defmodule ExBankTest do
  use ExUnit.Case

  setup do
    {:ok, bid} = start_supervised(ExBank)
    %{bid: bid}
  end

  test "test add customer", %{bid: bid} do
    customer_name = "Edwin"
    assert ExBank.check_balance(bid, customer_name) == :error

    ExBank.add_customer(bid, customer_name)
    {:ok, balance} = ExBank.check_balance(bid, customer_name)
    assert balance == 0
  end

end