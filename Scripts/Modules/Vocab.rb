# -*- coding: utf-8 -*-
#==============================================================================
# ** Vocab
#------------------------------------------------------------------------------
#  This module defines terms and messages. It defines some data as constant
# variables. Terms in the database are obtained from $data_system.
#==============================================================================

module Vocab

  # Shop Screen
  ShopBuy         = "구입"
  ShopSell        = "판매"
  ShopCancel      = "종료"
  Possession      = "소지수"

  # Status Screen
  ExpTotal        = "현재 경험치"
  ExpNext         = "다음 %s까지"

  # Save/Load Screen
  SaveMessage     = "어느 파일에 저장합니까?"
  LoadMessage     = "어느 파일을 불러옵니까?"
  File            = "파일"

  # Display when there are multiple members
  PartyName       = "%s들"

  # Basic Battle Messages
  Emerge          = "%s[이;가] 나타났다!"
  Preemptive      = "%s: 선제공격!"
  Surprise        = "%s: 기습을 당했다!"
  EscapeStart     = "%s: 도망쳤다!"
  EscapeFailure   = "하지만 붙잡혀 버리고 말았다!!"

  # Battle Ending Messages
  Victory         = "%s의 승리!!"
  Defeat          = "%s의 패배로 끝났다."
  ObtainExp       = "%s의 경험치 획득!"
  ObtainGold      = "소지금 %s\\G[을;를] 얻었다!"
  ObtainItem      = "아이템 %s[을;를] 얻었다!"
  LevelUp         = "%s 레벨업!! : %s  →  %s"
  ObtainSkill     = "스킬 %s[을;를] 습득했다!"

  # Use Item
  UseItem         = "%s[은;는] 아이템 %s[을;를] 사용했다!"

  # Critical Hit
  CriticalToEnemy = "회심의 일격!!"
  CriticalToActor = "통한의 일격!!"

  # Results for Actions on Actors
  ActorDamage     = "%s[은;는] %s의 피해를 받았다!"
  ActorRecovery   = "%s[은;는] %s[을;를] %s 회복했다!"
  ActorGain       = "%s의 %s[이;가] %s 증가했다!"
  ActorLoss       = "%s의 %s[이;가] %s 감소했다!"
  ActorDrain      = "%s[은;는] %s[을;를] %s 빼앗겼다!"
  ActorNoDamage   = "%s[은;는] 피해를 입지 않았다!"
  ActorNoHit      = "공격실패!　%s[은;는] 피해를 입지 않았다!"

  # Results for Actions on Enemies
  EnemyDamage     = "%s에게 %s 의 피해를 입혔다!"
  EnemyRecovery   = "%s[은;는] %s[을;를] %s 회복했다!"
  EnemyGain       = "%s의 %s[이;가] %s 증가했다!"
  EnemyLoss       = "%s의 %s[이;가] %s 감소했다!"
  EnemyDrain      = "%s[은;는] %s[을;를] %s 빼앗았다!"
  EnemyNoDamage   = "%s에게 피해를 줄 수 없었다!"
  EnemyNoHit      = "공격실패!　%s에게 피해를 줄 수 없었다!"

  # Evasion/Reflection
  Evasion         = "%s[은;는] 공격을 흘렸다!"
  MagicEvasion    = "%s[은;는] 마법을 피했다!"
  MagicReflection = "%s[은;는] 마법을 쳐냈다!"
  CounterAttack   = "%s의 반격!"
  Substitute      = "%s[은;는] %s[을;를] 감쌌다!"

  # Buff/Debuff
  BuffAdd         = "%s의 %s[이;가] 올라갔다!"
  DebuffAdd       = "%s의 %s[이;가] 내려갔다!"
  BuffRemove      = "%s의 %s[이;가] 원래대로 돌아왔다!"

  # Skill or Item Had No Effect
  ActionFailure   = "%s에게는 효과가 없었다!"

  # Error Message
  PlayerPosError  = "플레이어의 초기위치가 설정되지 않았습니다."
  EventOverflow   = "커먼이벤트의 호출이 너무 많이되고 있습니다."

  # Basic Status
  def self.basic(basic_id)
    $data_system.terms.basic[basic_id]
  end

  # Parameters
  def self.param(param_id)
    $data_system.terms.params[param_id]
  end

  # Equip Type
  def self.etype(etype_id)
    $data_system.terms.etypes[etype_id]
  end

  # Commands
  def self.command(command_id)
    $data_system.terms.commands[command_id]
  end

  # Currency Unit
  def self.currency_unit
    $data_system.currency_unit
  end

  #--------------------------------------------------------------------------
  def self.level;       basic(0);     end   # Level
  def self.level_a;     basic(1);     end   # Level (short)
  def self.hp;          basic(2);     end   # HP
  def self.hp_a;        basic(3);     end   # HP (short)
  def self.mp;          basic(4);     end   # MP
  def self.mp_a;        basic(5);     end   # MP (short)
  def self.tp;          basic(6);     end   # TP
  def self.tp_a;        basic(7);     end   # TP (short)
  def self.fight;       command(0);   end   # Fight
  def self.escape;      command(1);   end   # Escape
  def self.attack;      command(2);   end   # Attack
  def self.guard;       command(3);   end   # Guard
  def self.item;        command(4);   end   # Items
  def self.skill;       command(5);   end   # Skills
  def self.equip;       command(6);   end   # Equip
  def self.status;      command(7);   end   # Status
  def self.formation;   command(8);   end   # Change Formation
  def self.save;        command(9);   end   # Save
  def self.game_end;    command(10);  end   # Exit Game
  def self.weapon;      command(12);  end   # Weapons
  def self.armor;       command(13);  end   # Armor
  def self.key_item;    command(14);  end   # Key Items
  def self.equip2;      command(15);  end   # Change Equipment
  def self.optimize;    command(16);  end   # Ultimate Equipment
  def self.clear;       command(17);  end   # Remove All
  def self.new_game;    command(18);  end   # New Game
  def self.continue;    command(19);  end   # Continue
  def self.shutdown;    command(20);  end   # Shut Down
  def self.to_title;    command(21);  end   # Go to Title
  def self.cancel;      command(22);  end   # Cancel
  #--------------------------------------------------------------------------
end
