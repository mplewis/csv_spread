defmodule CsvSpreadTest do
  use ExUnit.Case
  doctest CsvSpread

  test "transformation" do
    actual = CsvSpread.spread("test/input.csv")

    expected =
      File.stream!("test/expected.csv")
      |> CSV.decode
      |> CSV.encode
      |> Enum.to_list

    assert actual == expected
  end
end
