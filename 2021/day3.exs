defmodule Math do
  @spec uncomplementary_not(integer) :: integer
  def uncomplementary_not(num) do
    comp = Bitwise.bnot(num)

    pow =
      1..64
      |> Enum.map(fn a -> 2 ** a end)
      |> Enum.find(fn a -> a >= num end)

    comp + pow
  end
end

gamma =
  "./2021/day3.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.to_charlist/1)
  |> List.zip()
  |> Enum.map(&Tuple.to_list/1)
  |> Enum.reduce("", fn bits, gamma ->
    ones =
      Enum.reduce(bits, 0, fn c, a ->
        a + if(c == 49, do: 1, else: 0)
      end)

    lim = String.length(List.to_string(bits)) / 2
    gamma <> if(ones >= lim, do: "1", else: "0")
  end)

g = String.to_integer(gamma, 2)
e = Math.uncomplementary_not(g)

IO.puts(
  "Part 1: " <>
    Integer.to_string(g * e)
)

items =
  "./2021/day3.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)

getrating = fn cmp, gamma, items ->
  0..String.length(gamma)
  |> Enum.reduce_while(items, fn index, acc ->
    {ones, zeros} =
      Enum.reduce(acc, {0, 0}, fn item, {o, z} ->
        if(String.at(item, index) == "1", do: {o + 1, z}, else: {o, z + 1})
      end)

    checking = if(cmp.(ones, zeros), do: "1", else: "0")

    next = acc |> Enum.filter(fn item -> String.at(item, index) == checking end)

    if(length(next) == 1, do: {:halt, List.first(next)}, else: {:cont, next})
  end)
end

gen = getrating.(fn o, z -> o >= z end, gamma, items)
scrubber = getrating.(fn o, z -> o < z end, gamma, items)

IO.puts(
  "Part 2: " <>
    Integer.to_string(
      String.to_integer(gen, 2) *
        String.to_integer(scrubber, 2)
    )
)
