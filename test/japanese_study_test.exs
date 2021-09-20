defmodule JapaneseStudyTest do
  use ExUnit.Case
  doctest JapaneseStudy

  test "greets the world" do
    assert JapaneseStudy.hello() == :world
  end
end
