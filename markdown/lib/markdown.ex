defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"

    iex> Markdown.parse("__Bold Item___Italic Item_")
    "<p><strong>Bold Item</strong><em>Italic Item</em></p>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    String.split(m, "\n")
    |> Enum.map(&process(&1))
    |> Enum.join()
    |> patch()
  end

  defp process(t) do
    cond do
      # Header tag
      String.starts_with?(t, "#") -> parse_and_enclose_header_tag(t)
      # Unordered lists
      String.starts_with?(t, "*") -> parse_list_md_level(t)
      # Paragraph tag
      true -> enclose_with_paragraph_tag(t)
    end
  end

  defp parse_and_enclose_header_tag(t) do
    original_length = String.length(t)
    # Trim leading "#"s and whitespace
    t = String.trim_leading(t, "#") |> String.trim_leading()
    trimmed_length = String.length(t)
    # Minus 1 for the leading whitespace
    header_level = original_length - trimmed_length - 1
    "<h#{header_level}>#{t}</h#{header_level}>"
  end

  defp parse_list_md_level(l) do
    l
    |> String.trim_leading("* ")
    |> (&"<ul><li>#{join_words_with_tags(&1)}</li></ul>").()
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    t
    |> replace_double_underscores_with_tags()
    |> replace_single_underscore_with_tags()
  end

  defp replace_double_underscores_with_tags(t) do
    t =
    t
    |> String.replace("__", "<strong>", global: false)
    |> String.replace("__", "</strong>", global: false)

    cond do
      String.contains?(t, "__") -> replace_double_underscores_with_tags(t)
      true -> t
    end
  end

  defp replace_single_underscore_with_tags(t) do
    t =
    t
    |> String.replace("_", "<em>", global: false)
    |> String.replace("_", "</em>", global: false)

    cond do
      String.contains?(t, "_") -> replace_single_underscore_with_tags(t)
      true -> t
    end
  end

  defp patch(l) do
    String.replace(l, "</ul><ul>", "")
  end
end
