defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list) do
    do_count(list)
  end

  defp do_count(list, count \\ 0)

  defp do_count([_head | tail], count) do
    do_count(tail, count + 1)
  end

  defp do_count([], count), do: count

  @spec reverse(list) :: list
  def reverse(list) do
    do_reverse(list)
  end

  defp do_reverse(l, rl \\ [])

  defp do_reverse([head | tail], rl) do
    do_reverse(tail, [head | rl])
  end

  defp do_reverse([], rl), do: rl

  @spec map(list, (any -> any)) :: list
  def map(list, f) do
    do_map(list, f)
  end

  defp do_map(l, f, l2 \\ [])

  defp do_map([head | tail], f, l2) do
    do_map(tail, f, [f.(head) | l2])
  end

  defp do_map([], _, l2), do: reverse(l2)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f)
  end

  defp do_filter(l, f, l2 \\ [])

  defp do_filter([head | tail], f, l2) do
    cond do
      f.(head) -> do_filter(tail, f, [head | l2])
      true -> do_filter(tail, f, l2)
    end
  end

  defp do_filter([], _, l2), do: reverse(l2)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(list, acc, f) do
    do_reduce(list, acc, f)
  end

  defp do_reduce([head | tail], acc, f) do
    do_reduce(tail, f.(head, acc), f)
  end

  defp do_reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(reverse(a), b)
  end

  defp do_append([head | tail], l) do
    do_append(tail, [head | l])
  end

  defp do_append([], l), do: l

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    do_concat(ll) |> reverse()
  end

  defp do_concat(ll, ll2 \\ [])

  defp do_concat([head | tail], ll2) do
    ll2 = do_append(head, ll2)
    do_concat(tail, ll2)
  end

  defp do_concat([], ll2), do: ll2
end
