defmodule Japanese.Mappings.Numbers do
  use TypedStruct

  typedstruct do
    @typedoc "Maps a number to japanese"
    field(:numeral, non_neg_integer(), default: 0)
    field(:pronounciation, String.t(), default: "")
    field(:hiragana, String.t(), default: "")
    field(:kanji, String.t(), default: "")
  end

  defp base_number_mappings() do
    [
      %__MODULE__{numeral: 0, pronounciation: "zero", hiragana: "ゼロ", kanji: "0"},
      %__MODULE__{numeral: 1, pronounciation: "ichi", hiragana: "いち", kanji: "一"},
      %__MODULE__{numeral: 2, pronounciation: "ni", hiragana: "に", kanji: "二"},
      %__MODULE__{numeral: 3, pronounciation: "san", hiragana: "さん", kanji: "三"},
      %__MODULE__{numeral: 4, pronounciation: "yon", hiragana: "よん", kanji: "四"},
      %__MODULE__{numeral: 4, pronounciation: "shi", hiragana: "し", kanji: "四"},
      %__MODULE__{numeral: 5, pronounciation: "go", hiragana: "ご", kanji: "五"},
      %__MODULE__{numeral: 6, pronounciation: "roku", hiragana: "ろく", kanji: "六"},
      %__MODULE__{numeral: 7, pronounciation: "nana", hiragana: "なな", kanji: "七"},
      %__MODULE__{numeral: 7, pronounciation: "shichi", hiragana: "しち", kanji: "七"},
      %__MODULE__{numeral: 8, pronounciation: "hachi", hiragana: "はち", kanji: "八"},
      %__MODULE__{numeral: 9, pronounciation: "kyuu", hiragana: "きゅう", kanji: "九"},
      %__MODULE__{numeral: 10, pronounciation: "juu", hiragana: "じゅう", kanji: "十"},
      %__MODULE__{numeral: 100, pronounciation: "hyaku", hiragana: "はいやく", kanji: "百"},
      %__MODULE__{numeral: 200, pronounciation: "ni-hyaku", hiragana: "にはいやく", kanji: "二百"},
      %__MODULE__{numeral: 300, pronounciation: "sanbyaku", hiragana: "さんびゃく", kanji: "三百"},
      %__MODULE__{numeral: 400, pronounciation: "yonhyaku", hiragana: "よんはいやく", kanji: "四百"},
      %__MODULE__{numeral: 500, pronounciation: "gohyaku", hiragana: "ごびゃく", kanji: "五百"}
    ]
  end

  def get_number_mapping(n) do
    Enum.find(base_number_mappings(), fn mapping -> mapping.numeral == n end)
  end
end
