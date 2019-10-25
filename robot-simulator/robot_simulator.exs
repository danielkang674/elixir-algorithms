defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any

  defguard is_valid_direction(direction) when direction in [:north, :south, :east, :west]
  defguard is_valid_position(x, y) when is_integer(x) and is_integer(y)

  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y}) when is_valid_direction(direction) and is_valid_position(x, y) do
    {direction, {x, y}}
  end

  def create(direction, _position) when not is_valid_direction(direction) do
    {:error, "invalid direction"}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @turn %{
    {:north, "R"} => :east,
    {:north, "L"} => :west,
    {:east, "R"} => :south,
    {:east, "L"} => :north,
    {:south, "R"} => :west,
    {:south, "L"} => :east,
    {:west, "R"} => :north,
    {:west, "L"} => :south
  }

  @spec simulate(robot :: any, instructions :: String.t()) :: any

  defguard is_valid_instruction(head) when head in ["R", "L", "A"]

  def simulate(robot, <<head::binary-size(1), tail::binary>>) when is_valid_instruction(head) do
    new_robot = do_simulate(robot, head)

    case new_robot do
      {:error, _} -> new_robot
      _ -> simulate(new_robot, tail)
    end
  end

  def simulate(robot, ""), do: robot

  def simulate(_, _), do: {:error, "invalid instruction"}


  defp do_simulate(robot, char) do
    current_direction = direction(robot)
    current_position = position(robot)

    case char do
      "R" -> {@turn[{current_direction, "R"}], current_position}
      "L" -> {@turn[{current_direction, "L"}], current_position}
      "A" -> move(robot)
    end
  end

  defp move(robot) do
    current_direction = direction(robot)
    {x, y} = position(robot)

    case current_direction do
      :north -> {current_direction, {x, y + 1}}
      :east -> {current_direction, {x + 1, y}}
      :south -> {current_direction, {x, y - 1}}
      :west -> {current_direction, {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_, position}) do
    position
  end
end
