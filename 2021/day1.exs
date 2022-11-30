{_, part1_count} =
  "./2021/day1.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_every(2, 1)
  |> Enum.map_reduce(0, fn is, acc ->
    {List.first(is) < List.last(is), if(List.first(is) < List.last(is), do: acc + 1, else: acc)}
  end)

IO.puts("Part 1: " <> Integer.to_string(part1_count))

{_, part2_count} =
  "./2021/day1.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_every(3, 1)
  |> Enum.map(&Enum.sum/1)
  |> Enum.chunk_every(2, 1)
  |> Enum.map_reduce(0, fn is, acc ->
    {List.first(is) < List.last(is), if(List.first(is) < List.last(is), do: acc + 1, else: acc)}
  end)

IO.puts("Part 2: " <> Integer.to_string(part2_count))
