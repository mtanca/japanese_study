defmodule JapaneseStudy.Games.CorrectHiragana do
  alias Japanese.Rules.Numbers

  use GenServer
  use TypedStruct

  typedstruct do
    field(:correct, non_neg_integer())
    field(:incorrect, non_neg_integer())
    field(:total_count, non_neg_integer())
  end

  @spec start() :: {:ok, pid()} | {:error, term()}
  def start() do
    GenServer.start(__MODULE__, [])
  end

  def play(pid) do
    send(pid, :play)
  end

  #################### GenServer Implementation ####################

  @impl GenServer
  @spec init(any()) :: {:ok, __MODULE__.t()}
  def init(_) do
    {:ok, %__MODULE__{correct: 0, incorrect: 0, total_count: 0}}
  end

  @impl GenServer
  def handle_info(:next_number, current_state) do
    random_number_mapping = Numbers.generate_number(Enum.random(1..199))

    IO.puts("What is the correct kanji for: #{random_number_mapping.numeral}")

    input = IO.gets("") |> String.trim()

    new_state_correctness =
      if random_number_mapping.kanji == input do
        %{current_state | correct: current_state.correct + 1}
      else
        %{current_state | incorrect: current_state.incorrect + 1}
      end

    new_state = %{new_state_correctness | total_count: current_state.total_count + 1}

    IO.puts(
      "The correct kanji was: #{random_number_mapping.kanji} | #{random_number_mapping.hiragana} | #{
        random_number_mapping.pronounciation
      }"
    )

    Process.send_after(self(), :next_number, 50)
    {:noreply, new_state}
  end

  # def start() do

  # end
end
