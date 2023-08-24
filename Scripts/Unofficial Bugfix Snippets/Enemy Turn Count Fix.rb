# -*- coding: utf-8 -*-
module BattleManager
  def self.input_start
	if @phase != :input
	  @phase = :input
	  $game_troop.increase_turn
	  $game_party.make_actions
	  $game_troop.make_actions
	  clear_actor
	end
	return !@surprise && $game_party.inputable?
  end
  def self.turn_start
	@phase = :turn
	clear_actor
	make_action_orders
  end
end