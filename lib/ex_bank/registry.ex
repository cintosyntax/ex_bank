defmodule ExBank.Registry do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    data = %{}
    refs  = %{}
    {:ok, {data, refs}}
  end

  def lookup(bank_name) do
  
    GenServer.call(__MODULE__, {:get, bank_name})
  end

  def register_bank(bank_name) do    
    GenServer.cast(__MODULE__, {:register, bank_name})
  end

  def handle_call({:get, bank_name}, _from, {data, _} = state) do
    {:reply, Map.fetch(data, bank_name), state}
  end

  def handle_cast({:register, name}, {data, refs}) do
    if Map.has_key?(data, name) do
      {:noreply, {data, refs}}
    else
      {:ok, pid} = ExBank.BankSupervisor.start_bank
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      data = Map.put(data, name, pid)
      {:noreply, {data, refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {data, refs}) do
    {name, refs} = Map.pop(refs, ref)
    data = Map.delete(data, name)

    {:noreply, {data, refs}}
  end
  
  def handle_info(_msg, state) do
    {:noreply, state}
  end

end