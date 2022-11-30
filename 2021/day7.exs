defmodule Crabs do
  def get_weight(crabs, position) do
    crabs
    |> Enum.map(fn crab ->
      abs(position - crab)
    end)
    |> Enum.sum()
  end

  def get_weight_v2(crabs, position) do
    crabs
    |> Enum.map(fn crab ->
      orig = crab
      dist = abs(position - crab)
      0..dist |> Enum.sum()
    end)
    |> Enum.sum()
  end
end

crabs =
  "./2021/day7.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> List.first()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

{part1, val} =
  0..Enum.max(crabs)
  |> Enum.map(fn index ->
    {index, crabs |> Crabs.get_weight(index)}
  end)
  |> Enum.min(fn {_, a}, {_, b} -> a < b end)

IO.puts("#{part1} -> #{val}")

{part2, val} =
  0..Enum.max(crabs)
  |> Enum.map(fn index ->
    {index, crabs |> Crabs.get_weight_v2(index)}
  end)
  |> Enum.min(fn {_, a}, {_, b} -> a < b end)

IO.puts("#{part2} -> #{val}")
