defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "User"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "return the game state updated" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "User"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "User"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}
      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "return the current player" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)

      assert player == Game.player()
    end
  end

  describe "turn/0" do
    test "return the current turn" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)

      assert :player == Game.turn()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_random: :chute},
          name: "User"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      assert :computer == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "return the fetched player" do
      player = Player.build("User", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)

      assert Game.fetch_player(:computer) == computer
    end
  end
end
