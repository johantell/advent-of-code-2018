defmodule Day3 do
  def squares_claimed_by_many(claims) do
    claims
    |> parse_claims()
    |> Enum.reduce(%{}, &collect_overlapping/2)
    |> Enum.reduce(0, fn
      {_, [_, _ | _]}, acc ->
        acc + 1

      _, acc ->
        acc
    end)
  end

  def non_overlapping_id(claims) do
    claims = parse_claims(claims)
    all_ids = Enum.reduce(claims, [], fn %{id: id}, acc -> [id | acc] end)
    overlappings = Enum.reduce(claims, %{}, &collect_overlapping/2)

    [id] = Enum.reduce(overlappings, all_ids, fn
      {_, [_, _ | _] = claim_ids}, acc ->
        acc -- claim_ids

      _, acc ->
        acc
    end)

    id
  end

  defp parse_claims(claims) do
    claims
    |> Enum.map(&parse_claim/1)
    |> Enum.map(&define_area/1)
  end

  defp collect_overlapping(%{id: id, x: x_range, y: y_range}, acc) do
    Enum.reduce(x_range, acc, fn x, x_acc ->
      Enum.reduce(y_range, x_acc, fn y, y_acc ->
        Map.update(y_acc, {x, y}, [id], &(&1 ++ [id]))
      end)
    end)
  end

  defp define_area(%{id: id, x: x, y: y, width: ax, height: ay}) do
    %{
      id: id,
      x: (x + 1)..(x + ax),
      y: (y + 1)..(y + ay)
    }
  end

  @claim_regex ~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/
  def parse_claim(claim) do
    Regex.named_captures(@claim_regex, claim)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), String.to_integer(value)} end)
    |> Enum.into(%{})
  end
end
