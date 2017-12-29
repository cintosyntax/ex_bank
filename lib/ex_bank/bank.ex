defmodule ExBank.Bank do
  use Agent

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def check_balance(bank, customer_name) do
    GenServer.call(bank, {:get, customer_name})
  end

  def set_balance(bank, customer_name, amount) do
    GenServer.cast(bank, {:set, customer_name, amount})
  end

  def sub_balance(bank, customer_name, amount) do
    GenServer.cast(bank, {:subtract, customer_name, amount})
  end

  def add_to_balance(bank, customer_name, add_amount) do
    GenServer.cast(bank, {:add, customer_name, add_amount})
  end

  def handle_cast({:set, customer_name, amount}, map) do
    map = Map.put_new(map, customer_name, amount)
    {:noreply, map}
  end

  def handle_cast({:subtract, customer_name, sub_amount}, map) do
    amount = Map.fetch(map, customer_name)
    map = Map.update(map, customer_name, amount, &(&1 - sub_amount))

    {:noreply, map}
  end

  def handle_cast({:add, customer_name, add_amount}, map) do
    balance = Map.fetch(map, customer_name)
    map = Map.update(map, customer_name, balance, &(&1 + add_amount))
    
    {:noreply, map}  
  end

  def handle_call({:get, customer_name}, _from, map) do
    balance = Map.fetch(map, customer_name)
    {:reply, balance, map}
  end
  

end