defmodule Ruck do
  def split(line) do
    String.split_at(line, round(String.length(line) / 2))
  end

  def find({cmp1, cmp2}) do
    set = MapSet.new(String.codepoints(cmp1))

    String.codepoints(cmp2)
    |> Enum.find(fn item -> MapSet.member?(set, item) end)
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
    |> Enum.map(&Ruck.split/1)
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
