defmodule ExBankTest do
  use ExUnit.Case

  setup do
    {:ok, bid} = start_supervised(ExBank.Bank)
    %{bid: bid}
  end

  test "add customer", %{bid: bid} do
    customer_name = "Edwin"
    assert ExBank.Bank.check_balance(bid, customer_name) == :error

    ExBank.Bank.add_customer(bid, customer_name)
    {:ok, balance} = ExBank.Bank.check_balance(bid, customer_name)
    assert balance == 0
  end

  test "has customer", %{bid: bid} do
    customer_name = "Edwin"
          
    res = ExBank.Bank.has_customer(bid, customer_name)
    assert res == false

    ExBank.Bank.add_customer(bid, customer_name)
    res = ExBank.Bank.has_customer(bid, customer_name)
    assert res == true
  end

  test "change balance", %{bid: bid} do
    customer_name = "Edwin"
          
    ExBank.Bank.add_customer(bid, customer_name)    
    {:ok, balance} = ExBank.Bank.check_balance(bid, customer_name)
    assert balance == 0

    ExBank.Bank.change_balance(bid, customer_name, 500)
    {:ok, balance} = ExBank.Bank.check_balance(bid, customer_name)
    assert balance == 500
  end

end