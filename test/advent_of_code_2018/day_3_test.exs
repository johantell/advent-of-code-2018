defmodule Day3Test do
  use ExUnit.Case, async: true

  @real_input File.read!("test/support/fixtures/day_3.txt")
              |> String.trim()
              |> String.split("\n")

  describe "squares_claimed_by_many/1" do
    test "returns 4 with the example input" do
      claims = [
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ]

      assert 4 = Day3.squares_claimed_by_many(claims)
    end

    test "returns 113716 with real input" do
      assert 113716 = Day3.squares_claimed_by_many(@real_input)
    end
  end

  describe "non_overlapping_id/1" do
    test "returns 3 when passed the example input" do
      claims = [
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ]

      assert 3 = Day3.non_overlapping_id(claims)
    end

    test "returns 742 when passed real input" do
      assert 742 = Day3.non_overlapping_id(@real_input)
    end
  end

  describe "parse_claim/1" do
    test "parses a claim" do
      claim = "#1 @ 1,3: 4x5"

      assert %{id: 1, x: 1, y: 3, width: 4, height: 5} = Day3.parse_claim(claim)
    end
  end
end
