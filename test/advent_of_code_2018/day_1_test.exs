defmodule AdventOfCode2018.Day1Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2018.Day1

  @real_input File.read!("test/support/fixtures/day_1.txt")

  describe "read_frequency/1" do
    test "returns 7 when passed `+5 +2`" do
      assert 7 = Day1.parse_input("+5 +2")
    end

    test "returns 3 when passed `+5 -2`" do
      assert 3 = Day1.parse_input("+5 -2")
    end

    test "returns 30 when passed `+15 +15`" do
      assert 30 = Day1.parse_input("+15 +15")
    end

    test "allows `\n` as separator" do
      assert 30 = Day1.parse_input("+15\n+15")
    end

    test "returns 522 when passed the real input" do
      assert 522 = Day1.parse_input(@real_input)
    end
  end

  describe "first_frequency_reached_twice/1" do
    test "returns 2 when passed `+2 +2 -2`" do
      assert 2 = Day1.first_frequency_reached_twice("+2 +2 -2")
    end

    test "returns 10 when passed `+3 +3 +4 -2 -4`" do
      assert 10 = Day1.first_frequency_reached_twice("+3 +3 +4 -2 -4")
    end

    test "returns 0 when passed `+1 -1`" do
      assert 0 = Day1.first_frequency_reached_twice("+1 -1")
    end

    test "returns 15 when passed `+7 +7 -2 -7 -4`" do
      assert 14 = Day1.first_frequency_reached_twice("+7 +7 -2 -7 -4")
    end

    test "returns 5 when passed `-6 +3 +8 +5 -6`" do
      assert 5 = Day1.first_frequency_reached_twice("-6 +3 +8 +5 -6")
    end

    test "returns 73364 when passed the real input" do
      assert 73364 = Day1.first_frequency_reached_twice(@real_input)
    end
  end
end
