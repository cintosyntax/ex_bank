defmodule ExBank.BankTest do
  use ExUnit.Case

  setup do
    {:ok, bid} = start_supervised(ExBank.Bank)
    # Set Initial State
    customer_name = "Edwin"
    ExBank.Bank.set_balance(bid, customer_name, 500)

    %{bid: bid, customer_name: customer_name}
  end

  test "check balance", %{bid: bid, customer_name: customer_name} do
    {:ok, value} = ExBank.Bank.check_balance(bid, customer_name)
    assert value == 500
  end

  test "subtract balance", %{bid: bid, customer_name: customer_name} do
    ExBank.Bank.sub_balance(bid, customer_name, 50)

    {:ok, value} = ExBank.Bank.check_balance(bid, customer_name)
    assert value == 450
  end

  test "add balance", %{bid: bid, customer_name: customer_name} do
    ExBank.Bank.add_to_balance(bid, customer_name, 500)
    {:ok, value} = ExBank.Bank.check_balance(bid, customer_name)

    assert value == 1000
  end


end