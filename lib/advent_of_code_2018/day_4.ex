defmodule AdventOfCode2018.Day4 do
  def most_sleepy_guard_times_most_common_sleep_minute(records) do
    sleep_patterns = sleep_patterns(records)

    guard_id = most_sleepy_guard(sleep_patterns)

    {minute, _amount} =
      sleep_patterns
      |> Enum.filter(fn %{id: id} -> guard_id == id end)
      |> count_sleep_occurrencies_by_minute
      |> Enum.max_by(&elem(&1, 1))

    guard_id * minute
  end

  def most_sleepy_guard(sleep_patterns) do
    {guard_id, _minutes} =
      sleep_patterns
      |> Enum.reduce(%{}, &count_sleep_minutes/2)
      |> Enum.max_by(fn {_key, sleep_in_minutes} -> sleep_in_minutes end)

    guard_id
  end

  def sleep_patterns(records) do
    records
    |> Enum.map(&parse_record/1)
    |> Enum.sort(&sort_by_timestamp/2)
    |> group_shifts()
  end

  def parse_record(record) do
    splitters = ["[", "]", "-", " ", ":", "#"]
    [year, month, day, hour, minute | action] = String.split(record, splitters, trim: true)

    {:ok, timestamp} =
      NaiveDateTime.new(
        String.to_integer(year),
        String.to_integer(month),
        String.to_integer(day),
        String.to_integer(hour),
        String.to_integer(minute),
        0
      )

    {id, action} = parse_action(action)

    %{
      timestamp: timestamp,
      id: id,
      action: action
    }
  end

  defp group_shifts(shifts), do: group_shifts(shifts, [])

  defp group_shifts([%{action: :begins_shift, id: id, timestamp: timestamp} | rest], acc) do
    group_shifts(rest, [%{id: id, began_shift: timestamp, sleep_patterns: []} | acc])
  end

  defp group_shifts(
         [
           %{action: :falls_asleep, timestamp: fell_asleep},
           %{action: :wakes_up, timestamp: awoke} | rest
         ],
         [shift | finished_shifts]
       ) do
    shift = Map.update!(shift, :sleep_patterns, &(&1 ++ [fell_asleep.minute..(awoke.minute - 1)]))

    group_shifts(rest, [shift | finished_shifts])
  end

  defp group_shifts([], acc), do: acc

  defp count_sleep_occurrencies_by_minute(sleep_pattern_records) do
    Enum.reduce(sleep_pattern_records, %{}, fn %{sleep_patterns: sleep_patterns}, acc ->
      Enum.reduce(sleep_patterns, acc, fn range, acc ->
        Enum.reduce(range, acc, fn minute, acc ->
          Map.update(acc, minute, 1, &(&1 + 1))
        end)
      end)
    end)
  end

  defp count_sleep_minutes(%{id: id, sleep_patterns: sleep_patterns}, acc) do
    sleep_minutes =
      sleep_patterns
      |> Enum.reduce(0, &(&2 + Enum.count(&1)))

    Map.update(acc, id, sleep_minutes, &(&1 + sleep_minutes))
  end

  defp sort_by_timestamp(a, b) do
    NaiveDateTime.compare(a.timestamp, b.timestamp) == :lt
  end

  defp parse_action(["Guard", guard_id | _]), do: {String.to_integer(guard_id), :begins_shift}
  defp parse_action(["falls", "asleep"]), do: {:unknown, :falls_asleep}
  defp parse_action(["wakes", "up"]), do: {:unknown, :wakes_up}
end
