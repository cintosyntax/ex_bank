defmodule ExBank do
  use GenServer
  @moduledoc """
  Documentation for ExBank.
  """

  @doc """
  Starts the Bank process server that handles retaining the state of the bank totals
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, {:ok, %{}}, opts)
  end
  
  # User-friendly interfaces
  # ------------------------

  def what_are_you(bank) do
    GenServer.call(bank, {:whoami})
  end

  def check_balance(bank, customer_name) do
    GenServer.call(bank, {:check_balance, customer_name})
  end

  def change_balance(bank, customer_name, new_balance) do
    GenServer.cast(bank, {:change_balance, customer_name, new_balance})
  end

  def add_customer(bank, customer_name) do
    GenServer.cast(bank, {:add_customer, customer_name})
  end

  def has_customer(bank, customer_name) do
    GenServer.call(bank, {:has_customer, customer_name})
  end

  # Server Callbacks
  # -----------------------

  @doc """
  Defines the initialization state of the Bank
  """
  def init({:ok, init_data}) do
    {:ok, init_data}
  end

  @doc """
  Handles calls to the server to return the balance of a customer
  """
  def handle_call({:check_balance, customer_name}, _from, data) do
    {:reply, Map.fetch(data, customer_name), data}
  end

  @doc """
  Handles calls to return if there is a record for the customer name provided
  """
  def handle_call({:has_customer, customer_name}, _from, data) do
    {:reply, Map.has_key?(data, customer_name), data}
  end

  def handle_call({:whoami}, _from, data) do
    {:reply, "A BANK", data}
  end

  def handle_cast({:change_balance, customer_name, new_balance}, data) do
    case Map.fetch(data, customer_name) do
      :error -> 
        {:noreply, data}
      _ -> 
        {:noreply, Map.put(data, customer_name, new_balance)}
    end
  end

  def handle_cast({:add_customer, customer_name}, data) do
    case Map.fetch(data, customer_name) do
      :error -> 
        {:noreply, Map.put(data, customer_name, 0)}
      _ -> 
        {:noreply, data}
    end
  end
  
end
