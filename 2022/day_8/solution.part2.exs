defmodule Trees do
  def scenic_score(trees, x, y) do
    max_y = length(trees) - 1
    max_x = length(List.first(trees)) - 1

    if x == 0 or x == max_x or y == 0 or y == max_x do
      -1
    else
      tree = Enum.at(trees, y) |> Enum.at(x)

      blocking_x = fn cx ->
        checking_tree = Enum.at(trees, y) |> Enum.at(cx)
        checking_tree >= tree
      end

      blocking_y = fn cy ->
        checking_tree = Enum.at(trees, cy) |> Enum.at(x)
        checking_tree >= tree
      end

      dist = fn
        {:left, cx} -> if(cx == nil, do: x, else: cx + 1)
        {:right, cx} -> if(cx == nil, do: max_x - x, else: cx + 1)
        {:top, cy} -> if(cy == nil, do: y, else: cy + 1)
        {:bottom, cy} -> if(cy == nil, do: max_y - y, else: cy + 1)
      end

      left =
        0..(x - 1) |> Enum.reverse() |> Enum.find_index(blocking_x) |> then(&dist.({:left, &1}))

      right = (x + 1)..max_x |> Enum.find_index(blocking_x) |> then(&dist.({:right, &1}))

      top =
        0..(y - 1) |> Enum.reverse() |> Enum.find_index(blocking_y) |> then(&dist.({:top, &1}))

      bottom = (y + 1)..max_y |> Enum.find_index(blocking_y) |> then(&dist.({:bottom, &1}))

      left *
        right *
        top *
        bottom
    end
  end

  def max_scenic_score(trees) do
    trees
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      Enum.with_index(row)
      |> Enum.map(fn {tree, x} -> Trees.scenic_score(trees, x, y) end)
      |> Enum.max()
    end)
    |> Enum.max()
  end
end

simple_trees =
  "./day_8/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, "") |> Enum.map(fn tree -> String.trim(tree) end)))
  |> Enum.map(fn row ->
    Enum.filter(row, &(String.length(&1) !== 0)) |> Enum.map(&String.to_integer/1)
  end)

Trees.max_scenic_score(simple_trees) |> IO.puts()

problem_trees =
  "./day_8/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, "") |> Enum.map(fn tree -> String.trim(tree) end)))
  |> Enum.map(fn row ->
    Enum.filter(row, &(String.length(&1) !== 0)) |> Enum.map(&String.to_integer/1)
  end)

Trees.max_scenic_score(problem_trees) |> IO.puts()
