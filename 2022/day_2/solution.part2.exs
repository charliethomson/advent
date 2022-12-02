defmodule RPS do
  def score(lines) do
    lines
    |> Enum.map(fn line ->
      case line do
        "B X" -> 1
        "C X" -> 2
        "A X" -> 3
        "A Y" -> 4
        "B Y" -> 5
        "C Y" -> 6
        "C Z" -> 7
        "A Z" -> 8
        "B Z" -> 9
        _ -> 0
      end
    end)
    |> Enum.sum()
  end
end

simple_lines =
  "./day_2/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> RPS.score()
  |> IO.puts()

problem_lines =
  "./day_2/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> RPS.score()
  |> IO.puts()

#     'A X': 3 + 0,
#     'A Y': 1 + 3,
#     'A Z': 2 + 6,
#     'B X': 1 + 0,
#     'B Y': 2 + 3,
#     'B Z': 3 + 6,
#     'C X': 2 + 0,
#     'C Y': 3 + 3,
#     'C Z': 1 + 6,
