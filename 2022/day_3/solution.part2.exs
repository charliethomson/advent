defmodule Ruck do
  def find(group) do
    sets = group |> Enum.map(&MapSet.new(String.codepoints(&1)))

    set =
      sets
      |> Enum.reduce(nil, fn cur, acc ->
        if(acc == nil, do: cur, else: MapSet.intersection(acc, cur))
      end)

    set |> MapSet.to_list() |> List.first()
  end

  def score(letter) do
    ch = String.to_charlist(letter) |> List.first()

    if(ch > 91,
      do: ch - 96,
      else: ch - 38
    )
  end

  def run(lines) do
    lines
    |> Enum.chunk_every(3)
    |> Enum.map(&Ruck.find/1)
    |> Enum.map(&Ruck.score/1)
    |> Enum.sum()
  end
end

simple_lines =
  "./day_3/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Ruck.run()
  |> IO.puts()

problem_lines =
  "./day_3/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Ruck.run()
  |> IO.puts()
