defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    Enum.reduce(list, [], &(keep_tester(&1, &2, fun)))
  end

  defp keep_tester(x, acc, fun) do
    cond do
      fun.(x) == true ->
        acc ++ [x]
      true ->
        acc
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    Enum.reduce(list, [], &(discard_tester(&1, &2, fun)))
  end

  defp discard_tester(x, acc, fun) do
    cond do
      fun.(x) == false ->
        acc ++ [x]
      true ->
        acc
    end
  end
end
