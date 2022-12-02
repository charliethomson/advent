defmodule RPS do
  def score(lines) do
    lines
    |> Enum.map(fn line ->
      case line do
        "B X" -> 1
        "C Y" -> 2
        "A Z" -> 3
        "A X" -> 4
        "B Y" -> 5
        "C Z" -> 6
        "C X" -> 7
        "A Y" -> 8
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
