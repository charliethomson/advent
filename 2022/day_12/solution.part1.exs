
simple_lines =
    "./day_12/input.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_12/input.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    