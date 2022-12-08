defmodule Trees do
  def is_visible(trees, x, y) do
    max_y = length(trees) - 1
    max_x = length(List.first(trees)) - 1

    if x == 0 or x == max_x or y == 0 or y == max_x do
      true
    else
      tree = Enum.at(trees, y) |> Enum.at(x)

      hidden_x = fn cx ->
        checking_tree = Enum.at(trees, y) |> Enum.at(cx)

        # IO.puts("@(x=#{x}) -> #{cx}: #{checking_tree >= tree} (#{checking_tree} >= #{tree})")
        checking_tree >= tree
      end

      hidden_y = fn cy ->
        checking_tree = Enum.at(trees, cy) |> Enum.at(x)
        # IO.puts("@(y=#{y}) -> #{cy}: #{checking_tree >= tree} (#{checking_tree} >= #{tree})")

        checking_tree >= tree
      end

      hidden_left =
        0..(x - 1)
        |> Enum.any?(hidden_x)

      hidden_right =
        (x + 1)..max_x
        |> Enum.any?(hidden_x)

      hidden_top =
        0..(y - 1)
        |> Enum.any?(hidden_y)

      hidden_bottom =
        (y + 1)..max_y
        |> Enum.any?(hidden_y)

      #   IO.puts(
      #     "v=#{tree} @ [#{x}, #{y}] -> hidden_top: #{hidden_top}; hidden_bottom: #{hidden_bottom}; hidden_left: #{hidden_left}; hidden_right: #{hidden_right}, visible?: #{not hidden_left or not hidden_right or not hidden_top or not hidden_bottom}"
      #   )

      not hidden_left or
        not hidden_right or
        not hidden_top or
        not hidden_bottom
    end
  end

  def count_visible(trees) do
    trees
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      Enum.with_index(row)
      |> Enum.reduce(0, fn {tree, x}, acc ->
        if(Trees.is_visible(trees, x, y), do: acc + 1, else: acc)
      end)
    end)
    |> Enum.sum()
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

Trees.count_visible(simple_trees) |> IO.puts()

problem_trees =
  "./day_8/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, "") |> Enum.map(fn tree -> String.trim(tree) end)))
  |> Enum.map(fn row ->
    Enum.filter(row, &(String.length(&1) !== 0)) |> Enum.map(&String.to_integer/1)
  end)

Trees.count_visible(problem_trees) |> IO.puts()
