defmodule AdventOfCode2018.Day2 do
  def create_checksum(input) do
    {doubles, triples} =
      input
      |> parse_box_ids
      |> Enum.reduce({0, 0}, &increase_doubles_and_triples/2)

    doubles * triples
  end

  def similarities_of_best_match(input) do
    {string1, string2, _score} = find_two_similar_ids(input)

    List.myers_difference(string1, string2)
    |> Enum.reduce([], fn
      {:eq, list}, acc -> acc ++ list
      _, acc -> acc
    end)
    |> to_string
  end

  def find_two_similar_ids(input) do
    box_ids =
      parse_box_ids(input)
      |> Enum.map(&String.to_charlist/1)

    match_ids(box_ids)
  end

  def match_ids([h | t]), do: match_ids([h], {nil, nil, 0}, t)

  defp match_ids(matched_ids, {_box_id1, _box_id2, best_score} = best_match, [box_id | rest]) do
    matched_ids
    |> Enum.reduce({nil, 0}, fn string, acc ->
      case calculate_match_score(string, box_id) do
        score when score > best_score ->
          {string, score}

        _ ->
          acc
      end
    end)
    |> case do
      {string, score} when score > best_score ->
        match_ids(matched_ids ++ [box_id], {string, box_id, score}, rest)

      _ ->
        match_ids(matched_ids ++ [box_id], best_match, rest)
    end
  end

  defp match_ids(_, best_match, _), do: best_match

  def calculate_match_score(charlist, charlist2) do
    calculate_match_score([], charlist, charlist2)
    |> Enum.sum()
  end

  defp calculate_match_score(score, [head1 | rest1], [head2 | rest2]) do
    result = if head1 == head2, do: 1, else: 0

    calculate_match_score(score ++ [result], rest1, rest2)
  end

  defp calculate_match_score(score, _, _), do: score

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
      {_key, 2}, {_doubles, triples} -> {1, triples}
      {_key, 3}, {doubles, _triples} -> {doubles, 1}
      _, acc -> acc
    end)
  end

  defp parse_box_ids(input) do
    input
    |> String.trim()
    |> String.split(["\n", " "])
  end
end
