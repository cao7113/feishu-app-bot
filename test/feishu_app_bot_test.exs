defmodule FeishuAppBotTest do
  use ExUnit.Case
  doctest FeishuAppBot

  test "greets the world" do
    assert FeishuAppBot.hello() == :world
  end
end
