defmodule JapaneseStudy do
  @moduledoc """
  Documentation for `JapaneseStudy`.
  """

  def run() do
    IO.puts("What would you like to practice?")
    IO.puts("1- numbers")

    quiz_selection =
      try do
        input = IO.gets("") |> String.trim()
        String.to_integer(input)
      rescue
        error ->
          IO.inspect(error, label: "!!!")
          nil
      end

    if is_nil(quiz_selection) do
      IO.puts("Not a valid selection")
      run()
    end

    IO.puts("You selected: #{quiz_selection}")
    do_run(quiz_selection)
  end

  defp do_run(1) do
    {:ok, pid} = JapaneseStudy.Games.CorrectHiragana.start()
    send(pid, :next_number)
    IO.puts("")
  end
end
