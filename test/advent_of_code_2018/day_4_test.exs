defmodule AdventOfCode2018.Day4test do
  use ExUnit.Case, async: true

  alias AdventOfCode2018.Day4

  describe "parse_record/1" do
    test "parses the record for begins shift" do
      record = "[1518-11-03 00:29] Guard #10 begins shift"

      expected_timestamp = ~N[1518-11-03 00:29:00]
      assert %{
        action: :begins_shift,
        id: 10,
        timestamp: ^expected_timestamp
      } = Day4.parse_record(record)
    end

    test "parses the record for falls asleep" do
      record = "[1518-11-03 00:24] falls asleep"

      expected_timestamp = ~N[1518-11-03 00:24:00]
      assert %{
        action: :falls_asleep,
        id: :unknown,
        timestamp: ^expected_timestamp
      } = Day4.parse_record(record)
    end

    test "parses the record for wakes up" do
      record = "[1518-11-03 00:29] wakes up"

      expected_timestamp = ~N[1518-11-03 00:29:00]
      assert %{
        action: :wakes_up,
        id: :unknown,
        timestamp: ^expected_timestamp
      } = Day4.parse_record(record)
    end
  end
end
