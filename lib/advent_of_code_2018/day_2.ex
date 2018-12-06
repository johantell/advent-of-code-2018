defmodule AdventOfCode2018.Day2 do
  def create_checksum(input) do
    {doubles, triples} =
      input
      |> parse_box_ids
      |> Enum.reduce({0, 0}, &increase_doubles_and_triples/2)

    doubles * triples
  end

  defp increase_doubles_and_triples(box_id, {total_doubles, total_triples}) do
    {doubles, triples} =
      box_id
      |> count_characters
      |> doubles_and_triples

    {doubles + total_doubles, triples + total_triples}
  end

  defp count_characters(box_id) do
    box_id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn letter, acc -> Map.update(acc, letter, 1, &(&1 + 1)) end)
  end

  def doubles_and_triples(character_map) do
    character_map
    |> Enum.reduce({0, 0}, fn
      {_key, 2}, {doubles, triples} -> {1, triples}
      {_key, 3}, {doubles, triples} -> {doubles, 1}
      _, acc -> acc
    end)
  end

  defp parse_box_ids(input) do
    input
    |> String.trim()
    |> String.split(["\n", " "])
  end
end
