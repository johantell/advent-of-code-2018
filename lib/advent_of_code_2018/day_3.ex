defmodule Day3 do
  def squares_claimed_by_many(claims) do
    {_, overlapping} = claims
    |> Enum.map(&parse_claim/1)
    |> Enum.map(&define_area/1)
    |> Enum.flat_map(&expand_coordinates/1)
    |> Enum.reduce({MapSet.new(), MapSet.new()}, fn coordinate, {processed, overlaying} ->
      case MapSet.member?(processed, coordinate) do
        true -> {processed, MapSet.put(overlaying, coordinate)}
        false -> {MapSet.put(processed, coordinate), overlaying}
      end
    end)

    Enum.count(overlapping)
  end

  defp expand_coordinates(%{x: x_range, y: y_range}) do
    Enum.flat_map(x_range, fn x ->
      Enum.reduce(y_range, [], fn y, acc ->
        acc ++ [{x, y}]
      end)
    end)
  end

  defp define_area(%{id: id, x: x, y: y, area_x: ax, area_y: ay}) do
    %{
      id: id,
      x: (x + 1)..(x + ax),
      y: (y + 1)..(y + ay)
    }
  end

  @claim_regex ~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<area_x>\d+)x(?<area_y>\d+)/
  def parse_claim(claim) do
    Regex.named_captures(@claim_regex, claim)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), String.to_integer(value)} end)
    |> Enum.into(%{})
  end
end
