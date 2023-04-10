defmodule GiphyScrapperTest do
  use ExUnit.Case
  doctest GiphyScrapper

  test "greets the world" do
    assert GiphyScrapper.hello() == :world
  end
end
