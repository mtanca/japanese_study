defmodule Japanese.Rules.Numbers do
  @moduledoc """
  Formats a number based on language rules...
  """
  alias Japanese.Mappings.Numbers, as: NumberMappings

  def generate_number(n, acc \\ [])

  def generate_number(n, acc) when n == 0 do
    acc
    |> Enum.reverse()
    |> Enum.reduce(%NumberMappings{}, fn mappings, local_acc ->
      mapping =
        mappings
        |> Map.values()
        |> List.first()

      %{
        local_acc
        | kanji: local_acc.kanji <> mapping.kanji,
          hiragana: String.trim(local_acc.hiragana <> " " <> mapping.hiragana),
          pronounciation: String.trim(local_acc.pronounciation <> " " <> mapping.pronounciation),
          numeral: local_acc.numeral + mapping.numeral
      }
    end)
  end

  def generate_number(n, acc) when n < 10 do
    base_mapping = NumberMappings.get_number_mapping(n)
    new_n = 0

    key = base_mapping.kanji
    new_acc = [%{"#{key}" => base_mapping} | acc]

    generate_number(new_n, new_acc)
  end

  def generate_number(n, acc) when n < 100 do
    base_mapping = NumberMappings.get_number_mapping(10)
    tens_place = Integer.digits(n) |> List.first() |> NumberMappings.get_number_mapping()
    new_n = n - tens_place.numeral * 10
    new_mapping = compose(tens_place, base_mapping)

    key = new_mapping.kanji
    new_acc = [%{"#{key}" => new_mapping} | acc]

    generate_number(new_n, new_acc)
  end

  # TODO implement more mappings to support numbers higher than 600
  def generate_number(n, acc) when n < 600 do
    hundreds_place = Integer.digits(n) |> List.first() |> NumberMappings.get_number_mapping()

    base_mapping = NumberMappings.get_number_mapping(hundreds_place.numeral * 100)

    new_n = n - hundreds_place.numeral * 100

    new_acc = [%{"#{base_mapping.kanji}" => base_mapping} | acc]

    generate_number(new_n, new_acc)
  end

  @spec compose(NumberMappings.t(), NumberMappings.t()) :: NumberMappings.t()
  def compose(mappings1, mappings2) do
    # only compose if number is less than 20
    if mappings2.numeral * mappings1.numeral < 20 do
      %NumberMappings{
        numeral: mappings2.numeral,
        pronounciation: mappings2.pronounciation,
        hiragana: mappings2.hiragana,
        kanji: mappings2.kanji
      }
    else
      %NumberMappings{
        numeral: mappings1.numeral * mappings2.numeral,
        pronounciation: mappings1.pronounciation <> "-" <> mappings2.pronounciation,
        hiragana: mappings1.hiragana <> "-" <> mappings2.hiragana,
        kanji: mappings1.kanji <> mappings2.kanji
      }
    end
  end
end
