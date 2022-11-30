{x, y} =
  "./2021/day2.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(fn a -> String.split(a, " ") end)
  |> Enum.reduce({0, 0}, fn
    [instruction, amt], {x, y} when instruction == "forward" ->
      {x + String.to_integer(amt), y}

    [instruction, amt], {x, y} when instruction == "down" ->
      {x, y + String.to_integer(amt)}

    [instruction, amt], {x, y} when instruction == "up" ->
      {x, y - String.to_integer(amt)}

    [instruction, amt], {x, y} ->
      {x, y}
  end)

IO.puts("Part 1: " <> Integer.to_string(x * y))

{x, y, aim} =
  "./2021/day2.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(fn a -> String.split(a, " ") end)
  |> Enum.reduce({0, 0, 0}, fn
    [instruction, amt], {x, y, aim} when instruction == "forward" ->
      {x + String.to_integer(amt), y + aim * String.to_integer(amt), aim}

    [instruction, amt], {x, y, aim} when instruction == "down" ->
      {x, y, aim + String.to_integer(amt)}

    [instruction, amt], {x, y, aim} when instruction == "up" ->
      {x, y, aim - String.to_integer(amt)}

    [instruction, amt], {x, y, aim} ->
      {x, y, aim}
  end)

IO.puts(x)
IO.puts(y)
IO.puts("Part 2: " <> Integer.to_string(x * y))
