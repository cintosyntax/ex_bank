defmodule ExBank.Registry do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: :bank_registry)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def lookup(bank_name) do
    GenServer.call(:bank_registry, {:get, bank_name})
  end

  def register_bank(bank_name) do    
    GenServer.cast(:bank_registry, {:register, bank_name})
  end

  def handle_call({:get, bank_name}, _from, data) do    
    {:reply, Map.fetch(data, bank_name), data}
  end

  def handle_cast({:register, bank_name}, data) do
    {:ok, bid} = ExBank.start_link()
    {:noreply, Map.put_new(data, bank_name, bid)}
  end


end