defmodule Bob do
  @mapper %{
    state: "Whatever.",
    shout: "Whoa, chill out!",
    question: "Sure.",
    shout_question: "Calm down, I know what I'm doing!",
    empty: "Fine. Be that way!"
  }
  def hey(input) do
    upper = input == String.upcase(input)
    question = String.ends_with?(input, "?")
    empty = "" == String.trim(input)
    lower = input == String.downcase(input)

    cond do
      empty -> @mapper.empty
      upper && question && !lower-> @mapper.shout_question
      upper && !lower-> @mapper.shout
      question -> @mapper.question
      true -> @mapper.state
    end
  end
end
