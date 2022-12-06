defmodule Signal do
  def find_first_marker(packet) do
    packet
    |> String.to_charlist()
    |> Enum.with_index()
    |> Enum.reduce_while([], fn
      {_, index}, acc when length(acc) == 14 ->
        {:halt, index}

      {ch, index}, acc ->
        split_index = acc |> Enum.find_index(fn el -> el == ch end)

        case split_index do
          nil ->
            {:cont, acc ++ [ch]}

          _ ->
            {s, e} = Enum.split(acc, split_index + 1)
            {:cont, e ++ [ch]}
        end
    end)
  end
end

simple_lines =
  "./day_6/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&Signal.find_first_marker/1)
  |> Enum.each(&IO.puts/1)

problem_lines =
  "./day_6/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.trim/1)
  |> Enum.map(&Signal.find_first_marker/1)
  |> Enum.each(&IO.puts/1)
