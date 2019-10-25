defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()

  defguard is_vowel(h1) when h1 in ["a", "e", "i", "o", "u"]
  defguard is_consonant(h1) when h1 in ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
  defguard is_xy(h1) when h1 in ["x", "y"]

  def translate(phrase) do
    phrase
    |> String.split()
    |> phrase_translate()
  end

  defp phrase_translate(word_list) do
    Enum.map(word_list, &(word_translate(&1))) |> Enum.join(" ")
  end

  defp word_translate(<<h1::binary-size(1), tail::binary>>) when is_vowel(h1) do
    h1 <> tail <> "ay"
  end

  defp word_translate(<<h1::binary-size(1), tail::binary>>) when is_consonant(h1) do
    do_consonant(h1 <> tail) <> "ay"
  end

  defp do_consonant(<<h1::binary-size(1), h2::binary-size(1), tail::binary>>) when h1 == "q" and h2 == "u" do
    do_consonant(tail <> h1 <> h2)
  end

  defp do_consonant(<<h1::binary-size(1), h2::binary-size(1), tail::binary>>) when is_xy(h1) and is_consonant(h2) do
    h1 <> h2 <> tail
  end

  defp do_consonant(<<h1::binary-size(1), tail::binary>>) when is_consonant(h1) do
    do_consonant(tail <> h1)
  end


  defp do_consonant(tail), do: tail
end
