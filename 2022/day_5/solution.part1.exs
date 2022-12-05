#     [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3
initial_state_simple = [
  [:z, :n],
  [:m, :c, :d],
  [:p]
]

#             [C]         [N] [R]
# [J] [T]     [H]         [P] [L]
# [F] [S] [T] [B]         [M] [D]
# [C] [L] [J] [Z] [S]     [L] [B]
# [N] [Q] [G] [J] [J]     [F] [F] [R]
# [D] [V] [B] [L] [B] [Q] [D] [M] [T]
# [B] [Z] [Z] [T] [V] [S] [V] [S] [D]
# [W] [P] [P] [D] [G] [P] [B] [P] [V]
#  1   2   3   4   5   6   7   8   9
initial_state_problem = [
  [:w, :b, :d, :n, :c, :f, :j],
  [:p, :z, :v, :q, :l, :s, :t],
  [:p, :z, :b, :g, :j, :t],
  [:d, :t, :l, :j, :z, :b, :h, :c],
  [:g, :v, :b, :j, :s],
  [:p, :s, :q],
  [:b, :v, :d, :f, :l, :m, :p, :n],
  [:p, :s, :m, :f, :b, :d, :l, :r],
  [:v, :d, :t, :r]
]

defmodule HanoiLike do
  def mv([count, from, to], state) do
    1..count
    |> Enum.reduce(state, fn _, acc ->
      acc
      |> Enum.with_index()
      |> Enum.map(fn {column, index} ->
        case index do
          _ when index == to ->
            src = Enum.fetch!(acc, from)
            column ++ [Enum.fetch!(src, length(src) - 1)]

          _ when index == from ->
            List.delete_at(column, length(column) - 1)

          _ ->
            column
        end
      end)
    end)
  end

  def parse_instructions(instruction) do
    re = ~r/move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/
    caps = Regex.named_captures(re, instruction)

    caps
    |> Map.to_list()
    |> Enum.map(fn {_, n} -> String.to_integer(n) end)
    |> Enum.with_index()
    |> Enum.map(fn {el, index} -> if(index == 0, do: el, else: el - 1) end)
  end
end

simple =
  "./day_5/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&HanoiLike.parse_instructions/1)
  |> Enum.reduce(initial_state_simple, &HanoiLike.mv/2)
  |> Enum.reduce("", fn cur, acc ->
    top = List.last(cur) |> to_string() |> String.upcase()
    "#{acc}#{top}"
  end)

IO.puts(simple)

problem =
  "./day_5/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&HanoiLike.parse_instructions/1)
  |> Enum.reduce(initial_state_problem, &HanoiLike.mv/2)
  |> Enum.reduce("", fn cur, acc ->
    top = List.last(cur) |> to_string() |> String.upcase()
    "#{acc}#{top}"
  end)

IO.puts(problem)
