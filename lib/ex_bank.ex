defmodule ExBank do
  use Application

  def start(_type, _args) do
    ExBank.Supervisor.start_link(name: ExBank.Supervisor)
  end

end