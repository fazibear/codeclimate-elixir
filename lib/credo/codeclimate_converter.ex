defmodule Credo.CodeclimateConverter do
  def convert({out, _}) do
     IO.puts String.split(out, "\n") |> Enum.map(fn (line) ->
      convert_line(String.split(line, " "))
    end) |> Enum.join("\0")
  end

  def convert_line([type, _, file | error]) do
    case String.split(file, ":") do
      [file_name, line, _] ->
        %{
          type: "Issue",
          check_name: convert_type(type),
          description: Enum.join(error, " "),
          #categories: ["Complexity", "Style"],
          location: %{
            path: file_name |> String.replace(~r/^\/code\//, ""),
            lines: %{
              begin: line,
              end: line
            }
          }
        } |> Poison.encode!
        _ -> nil
    end
  end

  def convert_line(_), do: nil

  def convert_type(type) do
    case type do
      "[R]" -> "Refactoring Oportunities"
      "[W]" -> "Warrning"
      "[C]" -> "Consistency"
      "[D]" -> "Software Design"
    end
  end
end
