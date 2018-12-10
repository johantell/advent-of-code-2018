defmodule AdventOfCode2018.Day4 do
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

  defp parse_action(["Guard", guard_id | _]), do: {String.to_integer(guard_id), :begins_shift}
  defp parse_action(["falls", "asleep"]), do: {:unknown, :falls_asleep}
  defp parse_action(["wakes", "up"]), do: {:unknown, :wakes_up}
end
