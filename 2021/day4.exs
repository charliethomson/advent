defmodule Bingo do
  def step(move, boards) do
    boards
    |> Enum.map(fn board ->
      board
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn {marked, value} ->
          if value == move do
            {:marked, value}
          else
            {marked, value}
          end
        end)
      end)
    end)
  end

  def print_board(board) do
    board
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn {marked, value} ->
        if(marked == :marked, do: "+", else: " ") <>
          String.pad_leading(Integer.to_string(value), 2, " ")
      end)
      |> Enum.join("|")
    end)
    |> Enum.each(fn row ->
      IO.puts(row)
      IO.puts(0..String.length(row) |> Enum.map(fn _ -> "=" end) |> Enum.join(""))
    end)

    sum = check(board)

    if sum != nil do
      IO.puts("Complete: " <> to_string(sum))
    else
      IO.puts("Incomplete")
    end
  end

  def check(board) do
    complete =
      0..4
      |> Enum.any?(fn i ->
        h =
          0..4
          |> Enum.all?(fn j ->
            {marked, _} = board |> Enum.at(i) |> Enum.at(j)
            marked == :marked
          end)

        v =
          0..4
          |> Enum.all?(fn j ->
            {marked, _} = board |> Enum.at(j) |> Enum.at(i)
            marked == :marked
          end)

        h || v
      end)

    if complete do
      board
      |> Enum.map(fn row ->
        row
        |> Enum.filter(fn {marked, _} -> marked == :unmarked end)
        |> Enum.map(fn {_, v} -> v end)
        |> Enum.sum()
      end)
      |> Enum.sum()
    else
      nil
    end
  end
end

contents =
  "./2021/day4.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)

{moves, boards} = List.pop_at(contents, 0)
moves = moves |> String.split(",") |> Enum.map(&String.to_integer/1)

{boards, remainder} =
  boards
  |> Enum.reduce({[], []}, fn line, {boards, board} ->
    trimmed = String.trim(line)
    is_empty = String.length(trimmed) == 0

    row =
      String.split(trimmed, " ")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn cell -> String.length(cell) != 0 end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(fn cell -> {:unmarked, cell} end)

    if is_empty do
      if length(board) == 0 do
        {boards, board}
      else
        {boards ++ [board], []}
      end
    else
      {boards, board ++ [row]}
    end
  end)

boards = boards ++ [remainder]

IO.puts("BEGIN:")

boards
|> Enum.each(fn board ->
  Bingo.print_board(board)
  IO.puts("\n")
end)

moves
|> Enum.reduce_while(boards, fn move, boards ->
  boards = Bingo.step(move, boards)

  cont =
    Enum.map(boards, fn board ->
      sum = Bingo.check(board)

      if sum != nil do
        Bingo.print_board(board)
        IO.puts("Move: " <> to_string(move))
        IO.puts("Part 1 answer: " <> to_string(move * sum))
        :halt
      else
        :cont
      end
    end)
    |> Enum.find(:cont, fn f -> f == :halt end)

  {cont, boards}
end)

{last_board, last_move} =
  moves
  |> Enum.reduce_while(boards, fn move, boards ->
    boards = Bingo.step(move, boards)

    filtered_boards =
      Enum.filter(boards, fn board ->
        Bingo.check(board) == nil
      end)

    if length(filtered_boards) == 0 do
      {:halt, {List.last(boards), move}}
    else
      {:cont, filtered_boards}
    end
  end)

Bingo.print_board(last_board)
IO.puts(last_move)
IO.puts("Part 2 answer: " <> to_string(last_move * Bingo.check(last_board)))
