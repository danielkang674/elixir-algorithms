defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @sh %{1_000 => "jump", 100 => "close your eyes", 10 => "double blink", 1 => "wink"}
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    binary = 
      Integer.to_charlist(code, 2)
      |> List.to_integer()
    recur(binary, [])
  end

  def recur(binary, actions, index \\ 0)

  def recur(binary, actions, index) when binary > 0 do
    place = :math.pow(10, index) |> round
    digit = rem(binary, 10) * place
    binary = div(binary, 10)
    cond do
      digit < 1 ->
        recur(binary, actions, index + 1)
      digit == 10_000 ->
        List.foldr(actions, [], &(&2 ++ [&1]))
      digit > 10_000 ->
        actions
      true ->
        recur(binary, actions ++ [@sh[digit]], index + 1)
    end
  end

  def recur(_binary, actions, _index) do
    actions
  end
end
