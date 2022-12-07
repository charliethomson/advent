defmodule FS do
  def cd(dir, current, arg) do
    # indices
    # [parent, ...children]
    # [nil, 1] 0 is :root
    # [0]
    if arg == ".." do
      # Step up to parent
      {dir, Enum.at(dir, current, [0]) |> Enum.at(0)}
    else
      # Create child dir
      # index 0 is the parent
      child = [current]

      child_index = length(dir)
      # update parent
      parent = Enum.at(dir, current, [0]) ++ [child_index]

      {
        (dir
         |> Enum.with_index()
         # update the parent dir
         |> Enum.map(fn {d, i} -> if(i == current, do: parent, else: d) end)) ++
          [child],
        # ^^^ append the child to the dirs
        child_index
      }
    end
  end

  def ls(dir, current, entries) do
    re = ~r/(?<size>\d+)\s(?<name>.*)/

    dir
    |> Enum.with_index()
    |> Enum.map(fn {d, i} ->
      if i == current do
        d ++
          (entries
           |> Enum.filter(fn e ->
             Regex.named_captures(re, e) != nil
           end)
           |> Enum.map(fn e ->
             caps = Regex.named_captures(re, e)

             %{
               file: caps |> Map.get("name"),
               size: caps |> Map.get("size") |> String.to_integer()
             }
           end))
      else
        d
      end
    end)
  end

  def build(lines) do
    cmd = ~r/\$\s(?<cmd>\w+)((\s)(?<arg>.+))?/

    {dir, current, gathering_stdout, stdout} =
      lines
      |> Enum.reduce(
        {
          # dir structure
          [[nil]],
          # current index
          0,
          # capturing
          false,
          # stdout
          []
        },
        fn l, {dir, current, gathering_stdout, stdout} ->
          caps = Regex.named_captures(cmd, l)

          if caps != nil do
            d1 =
              if gathering_stdout do
                ls(dir, current, stdout)
              else
                dir
              end

            command = Map.get(caps, "cmd")

            case command do
              "cd" ->
                arg = Map.get(caps, "arg")
                {d2, c} = cd(d1, current, arg)
                {d2, c, false, []}

              "ls" ->
                {dir, current, true, []}
            end
          else
            if gathering_stdout do
              {dir, current, true, stdout ++ [l]}
            end
          end
        end
      )

    if gathering_stdout do
      ls(dir, current, stdout)
    else
      dir
    end
  end

  def total_dir_size(dirs, index) do
    dir = Enum.at(dirs, index)

    if dir == nil do
      0
    else
      dir
      |> Enum.with_index()
      |> Enum.map(fn
        {%{file: _, size: sz}, _} ->
          sz

        {child, idx} when is_number(child) and idx != 0 ->
          total_dir_size(dirs, child)

        _ ->
          0
      end)
      |> Enum.sum()
    end
  end

  def smallest_dir_over(dirs, over) do
    {_, sz} =
      0..(length(dirs) - 1)
      |> Enum.reverse()
      |> Enum.reduce({dirs, 70_000_000}, fn i, {dirs, prev} ->
        sz = FS.total_dir_size(dirs, i)

        if sz > over do
          {dirs, min(prev, sz)}
        else
          {dirs, prev}
        end
      end)

    sz
  end
end

dirs =
  "./day_7/input.simple.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> FS.build()

simple_sz = FS.smallest_dir_over(dirs, 30_000_000 - (70_000_000 - FS.total_dir_size(dirs, 0)))
IO.puts("Part 1: #{simple_sz}")

problem_dirs =
  "./day_7/input.problem.txt"
  |> File.stream!()
  |> Enum.map(&String.trim/1)
  |> FS.build()

problem_sz =
  FS.smallest_dir_over(
    problem_dirs,
    30_000_000 - (70_000_000 - FS.total_dir_size(problem_dirs, 0))
  )

IO.puts("Answer: #{problem_sz}")
