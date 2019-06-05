defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
      |> to_charlist
      |> Enum.map(&(shifter(&1, shift)))
      |> to_string
  end

  def shifter(char, shift) when char in ?A .. ?Z do
    Integer.mod(char - ?A + shift, 26) + ?A
  end

  def shifter(char, shift) when char in ?a .. ?z do
    Integer.mod(char - ?a + shift, 26) + ?a
  end

  def shifter(char, shift), do: char 
end
