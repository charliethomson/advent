defmodule Calories do
  def max_total_calories(lines) do
    lines
    |> Enum.reduce({[], 0}, fn cur, {totals, cur_total} ->
      if String.length(cur) == 0 do
        {[cur_total | totals], 0}
      else
        {totals, cur_total + String.to_integer(cur)}
      end
    end)
    |> then(fn {counts, last} -> [last | counts] end)
    |> Enum.max()
  end
end

simple_lines =
  "./day_1/input.part1.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)

problem_lines =
  "./day_1/input.part1.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)

Calories.max_total_calories(simple_lines)
|> IO.puts()

Calories.max_total_calories(problem_lines)
|> IO.puts()
