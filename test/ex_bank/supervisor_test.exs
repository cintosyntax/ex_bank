defmodule ExBank.SupervisorTest do
  use ExUnit.Case

  test "supervisor functional" do
    {:ok, spid} = ExBank.Supervisor.start_link
    assert spid != nil

    {:ok, bid} = ExBank.Supervisor.start_bank()
    assert bid != nil

    assert ExBank.what_are_you(bid) == "A BANK"
  end

end