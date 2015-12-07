defmodule Mix.Tasks.Codeclimate do
  use Mix.Task

  @shortdoc  "Analyze files"
  @moduledoc @shortdoc

  alias Dogma.Config

  def run(_argv) do
    run_dogma
    run_credo
  end

  def run_dogma do
    "/code" |> Dogma.run(Config.build, Dogma.CodeclimateFormatter)
  end

  def run_credo do
    Credo.CodeclimateConverter.convert System.cmd("mix", ["credo", "/Users/fazibear/dev/sprint-poker", "-A", "--all", "--one-line"])
  end

  def run_test do
    IO.puts ~s(
    {
      "type": "issue",
      "check_name":  "Bug Risk/Unused Variable",
      "description": "Unused local variable foo",
      "categories":  ["Complexity", "Style"],
      "location": {
        "path": "test.rb",
        "lines": {
          "begin": 13,
          "end":   14
        }
      }
    }\0{
      "type": "issue",
      "check_name":  "Bug Risk/Unused Variable",
      "description": "Unused local variable foo",
      "categories":  ["Complexity", "Style"],
      "location": {
        "path": "test.rb",
        "lines": {
          "begin": 13,
          "end":   14
        }
      }
    }
    )
  end
end
