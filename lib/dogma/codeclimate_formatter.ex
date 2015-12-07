defmodule Dogma.CodeclimateFormatter do
  @moduledoc """
  """

  @doc """
  Runs at the start of the test suite, printing nothing.
  """
  def start(_), do: ""

  @doc """
  Runs after each script is tested, printing nothing.
  """
  def script(_), do: ""

  @doc """
  Runs at the end of the test suite, printing json.
  """
  def finish(scripts) do
    scripts |> Enum.map(&format/1) |> Enum.join("\0")
  end

  defp format(script) do
    script.errors |> Enum.map(fn(error) ->
      format_error(error, script)
    end) |> Enum.join("\0")
  end

  defp format_error(error, script) do
    %{
      type: "Issue",
      #check_name: "Bug Risk/Unused Variable",
      description: error.message,
      #categories: ["Complexity", "Style"],
      location: %{
        path: script.path |> String.replace(~r/^\/code\//, ""),
        lines: %{
          begin: error.line,
          end: error.line
        }
      }
    } |> Poison.encode!
  end
end
