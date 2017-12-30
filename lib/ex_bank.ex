defmodule ExBank do
  use GenServer
  @moduledoc """
  Documentation for ExBank.
  """

  @doc """
  Starts the Bank process server that handles retaining the state of the bank totals
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end
  
  # User-friendly interfaces

  def check_balance(bank, customer_name) do
    GenServer.call(bank, {:check_balance, customer_name})
  end

  def add_customer(bank, customer_name) do
    GenServer.cast(bank, {:add_customer, customer_name})
  end


  # Server Callbacks
  @doc """
  Defines the initialization state of the Bank
  """
  def init(:ok) do
    {:ok, MapSet.new}
  end

  @doc """
  Handles calls to the server to return the balance of a customer
  """
  def handle_call({:check_balance, customer_name}, _from, data) do
    {:reply, Map.fetch(data, customer_name), data}
  end
  
  def handle_cast({:add_customer, customer_name}, data) do
    case Map.fetch(data, customer_name) do
      :error -> 
        IO.puts("Added new customer record for #{customer_name}")
        {:noreply, Map.put(data, customer_name, 0)}
      _ -> 
        {:noreply, data}
      end
  end
  
end
