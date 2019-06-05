defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @mapper %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
      |> Enum.map(fn x-> @mapper[x] end)
  end
end
