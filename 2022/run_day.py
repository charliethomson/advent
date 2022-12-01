import argparse
import csv
import subprocess
from termcolor import colored


def get_result(result: bytes) -> str:
    result = result.decode("utf8")
    if len(result.strip()) == 0:
        return None
    if "RESULT: " in result:
        return str(result).split("RESULT: ").pop(0).strip()
    else:
        return str(result).strip().splitlines().pop().strip()


def run(
    day: int | None,
    part: int | None,
    expected: int | None,
    disable_suppression: bool = False,
):
    if day is None:
        for d in range(1, 26):
            run(d, part, expected)
        return

    if part is None:
        for p in range(1, 3):
            run(day, p, expected)
        return

    cmd = ["mix", "run", f"./day_{day}/solution.part{part}.exs"]
    print(f"Running day {day} : part {part}: ", end="")

    stderr = None
    if not disable_suppression:
        stderr = subprocess.DEVNULL
    result_bytes = subprocess.check_output(cmd, stderr=stderr)
    result = get_result(result_bytes)

    if expected is None:
        print(colored("Ok.", "green"))
        print(f'Got:\n\t"{result}"')
        return

    if result == expected:
        print(colored("Ok.", "green"))
    else:
        print(colored("Err", "red"))
        print(f'Expected:\n\t"{expected}"')
        print(f'Got:\n\t"{result}"')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="AOC Runner", description="Run AOC solutions (elixir)"
    )
    parser.add_argument(
        "-d", "--day", action="store", help="The day to run, omit for all", type=int
    )
    parser.add_argument(
        "-p", "--part", action="store", help="The part to run, omit for all", type=str
    )
    parser.add_argument(
        "-x",
        "--expected",
        action="store",
        help="Expected result, omit for no checking",
        type=str,
    )
    parser.add_argument(
        "--no-suppress", action="store_true", help="Disable stderr suppression"
    )
    args = parser.parse_args()
    run(args.day, args.part, args.expected, args.no_suppress)
