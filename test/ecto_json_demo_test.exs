defmodule EctoJsonDemoTest do
  use ExUnit.Case
  doctest EctoJsonDemo

  test "greets the world" do
    EctoJsonDemo.User.changeset(%EctoJsonDemo.User{}, %{
      username: "char0n",
      email: "vladimir.gorej@gmail.com",
      profile: %{timezone: "Europe/Prague"}
    }) |> dbg
  end
end
