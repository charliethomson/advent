
simple_lines =
    "./day_17/input.part2.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_17/input.part2.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    