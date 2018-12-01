defmodule AdventOfCode2018.Day1 do
  @separators [" ", "\n"]

  def parse_input(input) do
    input
    |> process_input
    |> Enum.reduce(0, &change_frequency/2)
  end

  def first_frequency_reached_twice(input) do
    input
    |> process_input
    |> find_frequency_twice_infinitively
  end

  defp find_frequency_twice_infinitively(list_of_changes) do
    do_find({0, MapSet.new([0])}, list_of_changes, list_of_changes)
  end

  defp do_find({frequency, previous_frequencies}, [change | rest], full_list) do
    new_frequency = change_frequency(change, frequency)

    if MapSet.member?(previous_frequencies, new_frequency) do
      new_frequency
    else
      do_find({new_frequency, MapSet.put(previous_frequencies, new_frequency)}, rest, full_list)
    end
  end

  defp do_find(state, [], full_list), do: do_find(state, full_list, full_list)

  defp change_frequency("+" <> number, frequency) do
    frequency + String.to_integer(number)
  end

  defp change_frequency("-" <> number, frequency) do
    frequency - String.to_integer(number)
  end

  defp process_input(input) do
    input
    |> String.trim()
    |> String.split(@separators)
  end
end
