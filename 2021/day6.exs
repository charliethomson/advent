defmodule Fish do
  def step(day, state) do
    out =
      state
      |> Enum.reduce([], fn timer, acc ->
        if timer == 0 do
          [6, 8 | acc]
        else
          [timer - 1 | acc]
        end
      end)

    out
  end
end

state =
  "./2021/day6.input.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> List.first()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

state |> Enum.join("|") |> IO.puts()
lim = 80

state =
  1..lim
  |> Enum.reduce(state, &Fish.step/2)

state |> Enum.join("|") |> IO.puts()
state |> length |> IO.puts()
