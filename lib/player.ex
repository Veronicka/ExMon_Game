defmodule ExMon.Player do
  @max_life 100
  @require_keys [:life, :moves, :name]

  @enforce_keys @require_keys
  defstruct @require_keys

  def build(name, move_random, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_random: move_random
      },
      name: name
    }
  end
end
