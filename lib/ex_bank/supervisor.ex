defmodule ExBank.Supervisor do
  use Supervisor
  

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_bank(opts \\ []) do
    Supervisor.start_child(__MODULE__, opts)
  end

  def init(:ok) do
    Supervisor.init([ExBank], strategy: :simple_one_for_one)
  end

end