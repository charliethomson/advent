
simple_lines =
    "./day_25/input.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_25/input.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    