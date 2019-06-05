defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @roman ["M": 1000, "CM": 900, "D": 500, "CD": 400, "C": 100, "XC": 90, "L": 50 , "XL": 40, "X": 10 , "IX": 9, "V": 5, "IV": 4, "I": 1]
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    to_numerals(number, @roman)
  end

  defp to_numerals(number, roman, rom_nums \\ "")

  defp to_numerals(_number, [], rom_nums), do: rom_nums

  defp to_numerals(number, [head | tail], rom_nums) do
    rom_nums = rom_nums |> convert(number, head)
    to_numerals(rem(number, elem(head, 1)), tail, rom_nums)
  end

  defp convert(rom_nums, number, {key, value}) when number >= value do
    rom_nums = rom_nums <> to_string(key)
    convert(rom_nums, number - value, {key, value})
  end

  defp convert(rom_nums, _number, _touple), do: rom_nums
end
