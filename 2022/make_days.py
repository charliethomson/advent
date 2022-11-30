import os

def get_base_code(day: int, part: int) -> str:
    return f"""
simple_lines =
    "./day_{day}/input.part{part}.simple.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)

problem_lines =
    "./day_{day}/input.part{part}.problem.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    """


for day in range(1, 26):
    base = f"./day_{day}"
    os.mkdir(base)
    with open(f"{base}/input.part1.problem.txt", 'w') as f:
        pass
    with open(f"{base}/input.part1.simple.txt", 'w') as f:
        pass
    with open(f"{base}/input.part2.problem.txt", 'w') as f:
        pass
    with open(f"{base}/input.part2.simple.txt", 'w') as f:
        pass
    with open(f"{base}/solution.part1.exs", 'w') as f:
        f.write(get_base_code(day, 1))
    with open(f"{base}/solution.part2.exs", 'w') as f:
        f.write(get_base_code(day, 2))