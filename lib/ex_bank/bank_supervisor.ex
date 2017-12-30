defmodule ExBank.BankSupervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_bank do
    Supervisor.start_child(__MODULE__, [])
  end
  
  def init(:ok) do
    children = [
      ExBank.Bank
    ]

    Supervisor.init(children, strategy: :simple_one_for_one)
  end

end