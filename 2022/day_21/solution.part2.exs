
simple_lines =
    "./day_21/input.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_21/input.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    