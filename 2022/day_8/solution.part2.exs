defmodule Trees do
  def scenic_score(trees, x, y) do
    max_y = length(trees) - 1
    max_x = length(List.first(trees)) - 1

    if x == 0 or x == max_x or y == 0 or y == max_x do
      %{total: -1}
    else
      tree = Enum.at(trees, y) |> Enum.at(x)

      blocking_x = fn cx ->
        checking_tree = Enum.at(trees, y) |> Enum.at(cx)

        # IO.puts("@(x=#{x}) -> #{cx}: #{checking_tree >= tree} (#{checking_tree} >= #{tree})")
        checking_tree >= tree
      end

      blocking_y = fn cy ->
        checking_tree = Enum.at(trees, cy) |> Enum.at(x)
        # IO.puts("@(y=#{y}) -> #{cy}: #{checking_tree >= tree} (#{checking_tree} >= #{tree})")

        checking_tree >= tree
      end

      dist = fn
        {:left, cx} -> if(cx == nil, do: x, else: x - cx)
        {:right, cx} -> if(cx == nil, do: max_x - x, else: cx - x)
        {:top, cy} -> if(cy == nil, do: y, else: y - cy)
        {:bottom, cy} -> if(cy == nil, do: max_y - y, else: cy - y)
      end

      blocking_tree_left = 0..(x - 1) |> Enum.find(blocking_x) |> then(&dist.({:left, &1}))
      blocking_tree_right = (x + 1)..max_x |> Enum.find(blocking_x) |> then(&dist.({:right, &1}))
      blocking_tree_top = 0..(y - 1) |> Enum.find(blocking_y) |> then(&dist.({:top, &1}))

      blocking_tree_bottom =
        (y + 1)..max_y |> Enum.find(blocking_y) |> then(&dist.({:bottom, &1}))

      IO.puts("v=#{tree} @ [#{x}, #{y}]:")
      IO.puts("\tleft -> #{blocking_tree_left}")
      IO.puts("\tright -> #{blocking_tree_right}")
      IO.puts("\ttop -> #{blocking_tree_top}")
      IO.puts("\tbottom -> #{blocking_tree_bottom}")

      %{
        total:
          blocking_tree_left *
            blocking_tree_right *
            blocking_tree_top *
            blocking_tree_bottom,
        left: blocking_tree_left,
        right: blocking_tree_right,
        top: blocking_tree_top,
        bottom: blocking_tree_bottom
      }
    end
  end

  def max_scenic_score(trees) do
    trees
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      Enum.with_index(row)
      |> Enum.map(fn {tree, x} -> Trees.scenic_score(trees, x, y) end)
      |> Enum.map(fn
        %{
          total: -1
        } ->
          -1

        %{
          total: total,
          left: left,
          right: right,
          top: top,
          bottom: bottom
        } ->
          IO.puts("Total=#{total}")
          IO.puts("\tleft=#{left}")
          IO.puts("\tright=#{right}")
          IO.puts("\ttop=#{top}")
          IO.puts("\tbottom=#{bottom}")
          total
      end)
      |> Enum.max()
    end)
    |> Enum.sort(:asc)
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

Trees.max_scenic_score(simple_trees) |> Enum.each(&IO.puts/1)

problem_trees =
  "./day_8/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&(String.split(&1, "") |> Enum.map(fn tree -> String.trim(tree) end)))
  |> Enum.map(fn row ->
    Enum.filter(row, &(String.length(&1) !== 0)) |> Enum.map(&String.to_integer/1)
  end)

# I can't figure out why this is correct for the sample but not for the problem
# I'll try more tomorrow
# Trees.max_scenic_score(problem_trees) |> Enum.each(&IO.puts/1)
