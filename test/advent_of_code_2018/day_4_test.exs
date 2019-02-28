defmodule AdventOfCode2018.Day4test do
  use ExUnit.Case, async: true

  alias AdventOfCode2018.Day4

  @real_input File.read!("test/support/fixtures/day_4.txt")
              |> String.trim()
              |> String.split("\n")

  describe "most_sleepy_guard_times_most_common_sleep_minute/1" do
    test "returns 350 when passed a predefined list of records" do
      records = [
        "[1518-11-03 00:28] Guard #10 begins shift",
        "[1518-11-03 00:30] falls asleep",
        "[1518-11-03 00:36] wakes up",
        "[1518-11-04 00:29] Guard #99 begins shift",
        "[1518-11-04 00:30] falls asleep",
        "[1518-11-04 00:40] wakes up",
        "[1518-11-05 00:28] Guard #10 begins shift",
        "[1518-11-05 00:35] falls asleep",
        "[1518-11-05 00:45] wakes up"
      ]

      assert unquote(10 * 35) = Day4.most_sleepy_guard_times_most_common_sleep_minute(records)
    end

    test "runs the real input" do
      assert 101262 = Day4.most_sleepy_guard_times_most_common_sleep_minute(@real_input)
    end
  end

  describe "most_sleepy_guard/1" do
    test "returns a value when passed real input" do
      sleep_patterns = [
        %{
          began_shift: ~N[1518-11-05 00:28:00],
          id: 10,
          sleep_patterns: [30..36]
        },
        %{
          began_shift: ~N[1518-11-04 00:30:00],
          id: 99,
          sleep_patterns: [33..34]
        },
        %{
          began_shift: ~N[1518-11-03 00:28:00],
          id: 10,
          sleep_patterns: [30..30]
        }
      ]

      assert 10 = Day4.most_sleepy_guard(sleep_patterns)
    end
  end

  describe "sleep_patterns/1" do
    test "returns the sleep patterns of guards by shift" do
      records = [
        "[1518-11-03 00:28] Guard #10 begins shift",
        "[1518-11-03 00:31] wakes up",
        "[1518-11-04 00:30] Guard #99 begins shift",
        "[1518-11-04 00:35] wakes up",
        "[1518-11-04 00:33] falls asleep",
        "[1518-11-03 00:30] falls asleep",
        "[1518-11-05 00:28] Guard #10 begins shift",
        "[1518-11-05 00:30] falls asleep",
        "[1518-11-05 00:37] wakes up"
      ]

      assert [
               %{
                 began_shift: ~N[1518-11-05 00:28:00],
                 id: 10,
                 sleep_patterns: [30..36]
               },
               %{
                 began_shift: ~N[1518-11-04 00:30:00],
                 id: 99,
                 sleep_patterns: [33..34]
               },
               %{
                 began_shift: ~N[1518-11-03 00:28:00],
                 id: 10,
                 sleep_patterns: [30..30]
               }
             ] = Day4.sleep_patterns(records)
    end
  end

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
