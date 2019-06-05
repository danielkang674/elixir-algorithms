defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(strand, acc \\ [])

  def of_rna(<<head::bytes-size(3), tail::binary>>, acc) do
    case of_codon(head) do
      {:ok, "STOP"} -> {:ok, acc}
      {:ok, codon} -> of_rna(tail, acc ++ [codon])
      {:error, _} -> {:error, "invalid RNA"}
    end
  end

  def of_rna(<<>>, acc), do: {:ok, acc}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @codons %{
    "UGU" => "Cysteine", 
    "UGC" => "Cysteine", 
    "UUA" => "Leucine", 
    "UUG" => "Leucine", 
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codons, codon) do
      :error -> {:error, "invalid codon"}
      {:ok, protien} = protein -> protein
    end
  end
end
