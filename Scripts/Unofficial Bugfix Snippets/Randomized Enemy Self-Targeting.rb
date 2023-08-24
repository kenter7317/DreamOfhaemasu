# -*- coding: utf-8 -*-
class Game_Action
  def targets_for_friends
	if item.for_user?
	  [subject]
	elsif item.for_dead_friend?
	  if item.for_one?
		[friends_unit.smooth_dead_target(@target_index)]
	  else
		friends_unit.dead_members
	  end
	elsif item.for_friend?
	  if item.for_one?
		if @target_index < 0
		  [friends_unit.random_target]
		else
		  [friends_unit.smooth_target(@target_index)]
		end
	  else
		friends_unit.alive_members
	  end
	end
  end
end