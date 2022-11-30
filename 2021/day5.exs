defmodule Lines do
  # def get_points(x1, y1, x2, y2) when x1 != x2 and y1 != y2, do: nil

  def get_diagonal_points(x1, y1, x2, y2) do
  end

  def get_points(x1, y1, x2, y2, _handle_diagonal) when x1 == x2,
    do: y1..y2 |> Enum.map(fn y -> {x1, y} end)

  def get_points(x1, y1, x2, y2, _handle_diagonal) when y1 == y2,
    do: x1..x2 |> Enum.map(fn x -> {x, y1} end)

  def get_points(x1, y1, x2, y2, handle_diagonal) do
    if handle_diagonal do
      xs = 0..(x1 - x2) |> Enum.map(fn d -> x2 + d end)
      ys = 0..(y1 - y2) |> Enum.map(fn d -> y2 + d end)
      xs |> Enum.zip(ys)
    else
      []
    end
  end

  def print_grid(grid) do
    grid
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn cell -> if(cell == 0, do: ".", else: to_string(cell)) end)
      |> Enum.join("")
    end)
    |> Enum.each(&IO.puts/1)

    IO.puts("")
  end

  def update_grid(grid, points) do
    points
    |> Enum.reduce(grid, fn {px, py}, grid ->
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, ri} ->
        if ri != py do
          row
        else
          row
          |> Enum.with_index()
          |> Enum.map(fn {cell, ci} ->
            if(ci != px, do: cell, else: cell + 1)
          end)
        end
      end)
    end)
  end

  def make_grid(dm) do
    1..dm
    |> Enum.map(fn _ ->
      1..dm |> Enum.map(fn _ -> 0 end)
    end)
  end
end

segments =
  "./2021/day5.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(fn line ->
    [p1, p2] = String.split(line, " -> ")
    [x1, y1] = String.split(p1, ",") |> Enum.map(&String.to_integer/1)
    [x2, y2] = String.split(p2, ",") |> Enum.map(&String.to_integer/1)
    {x1, y1, x2, y2}
  end)

grid = Lines.make_grid(1000)

# Lines.print_grid(grid)

part_1_grid =
  segments
  |> Enum.reduce(grid, fn {x1, y1, x2, y2}, grid ->
    Lines.update_grid(grid, Lines.get_points(x1, y1, x2, y2, false))
  end)

# Lines.print_grid(grid)

num_twos =
  part_1_grid
  |> Enum.map(fn row ->
    row |> Enum.filter(fn cell -> cell >= 2 end) |> Enum.count()
  end)
  |> Enum.sum()

IO.puts("Part 1 answer: " <> Integer.to_string(num_twos))

part_2_grid =
  segments
  |> Enum.reduce(grid, fn {x1, y1, x2, y2}, grid ->
    Lines.update_grid(grid, Lines.get_points(x1, y1, x2, y2, true))
  end)

# Lines.print_grid(grid)

num_twos_p2 =
  part_2_grid
  |> Enum.map(fn row ->
    row |> Enum.filter(fn cell -> cell >= 2 end) |> Enum.count()
  end)
  |> Enum.sum()

IO.puts("Part 2 answer: " <> Integer.to_string(num_twos_p2))
