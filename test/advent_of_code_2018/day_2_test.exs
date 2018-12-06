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

  describe "calculate_match_score" do
    test "returns a score based on the similarities of the different lists" do
      input1 = ~w(a b c d)
      input2 = ~w(a b c d)

      assert 4 = Day2.calculate_match_score(input1, input2)
    end
  end

  describe "match_ids" do
    test "returns the best matching ids" do
      list1 = ~w(a b c d e f g)
      list2 = ~w(a b c d e g g)

      list_of_ids = [
        list1,
        ~w(a b n u e f g),
        ~w(a b l d j f g),
        list2
      ]

      assert {^list1, ^list2, 6} = Day2.match_ids(list_of_ids)
    end
  end

  describe "find_two_similar_ids" do
    test "returns the two most similar ids" do
      input = ~s(abcd ahdu aoeu mduq sjqs abvd iuqo)

      assert {'abcd', 'abvd', 3} = Day2.find_two_similar_ids(input)
    end
  end

  describe "similarities_of_best_match" do
    test "returns similarities of the two  most similar ids" do
      input = ~s(abcd ahdu aoeu mduq sjqs abvd iuqo)

      assert "abd" = Day2.similarities_of_best_match(input)
    end

    test "returns similarities of the two  most similar ids when passed the real data" do
      assert "qyzphxoiseldjrntfygvdmanu" = Day2.similarities_of_best_match(@real_input)
    end
  end
end
