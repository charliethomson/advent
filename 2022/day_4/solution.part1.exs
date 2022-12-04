defmodule Cleaning do
  def get_range(range) do
    range |> String.split("-") |> Enum.map(&String.to_integer(&1, 10)) |> List.to_tuple()
  end

  def does_contain({a, b}) do
    {as, ae} = get_range(a)
    {bs, be} = get_range(b)
    (as <= bs && ae >= be) || (bs <= as && be >= ae)
  end
end

simple_lines =
  "./day_4/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, ",") |> List.to_tuple()))
  |> Enum.filter(&Cleaning.does_contain/1)
  |> Enum.count()
  |> IO.puts()

problem_lines =
  "./day_4/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, ",") |> List.to_tuple()))
  |> Enum.filter(&Cleaning.does_contain/1)
  |> Enum.count()
  |> IO.puts()
