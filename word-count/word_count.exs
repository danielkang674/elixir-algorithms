defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      |> String.split(~r/[^\p{L}\p{N}-]/u, trim: true)
      |> Enum.reduce(%{}, &(do_count(&1, &2)))
  end

  defp do_count(word, map) do
    cond do
      Map.has_key?(map, word) ->
        Map.put(map, word, map[word] + 1)
      true ->
        Map.put_new(map, word, 1)
    end
  end

end
