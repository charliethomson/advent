
simple_lines =
    "./day_16/input.part1.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_16/input.part1.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    