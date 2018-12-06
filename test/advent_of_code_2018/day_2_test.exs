defmodule AdventOfCode2018.Day2Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2018.Day2

  @real_input File.read!("test/support/fixtures/day_2.txt")

  describe "create_checksum/1" do
    test "returns 4 when passed `aab abb ccc ddd`" do
      assert 4 = Day2.create_checksum("aab abb ccc ddd")
    end

    test "returns 12 from the provided example" do
      input = ~s(abcdef bababc abbcde abcccd aabcdd abcdee ababab)

      assert 12 = Day2.create_checksum(input)
    end

    test "returns x when provided @real_input" do
      assert 5478 = Day2.create_checksum(@real_input)
    end
  end
end
