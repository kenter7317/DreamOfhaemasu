# -*- coding: utf-8 -*-
#===============================================================
# ● [XP/VX/VXA] ◦ Database Limit Breaker III ◦ □
# * Break limit of data number in database files *
#--------------------------------------------------------------
# ◦ by Woratana [woratana@hotmail.com]
# ◦ Thaiware RPG Maker Community
# ◦ Originally released on: 22/02/2008
# ◦ Ported to VXAce by Mr. Bubble on: 30/12/2011
#--------------------------------------------------------------

#==========================================
# ** HOW TO USE
#------------------------------------------
# [English]
# 0. Open your project (Recommend to backup your database files first~)
# 1. Paste this script in above 'Main'.
# 2. Set DLB_USE_IT = true
# 3. Setup database files you want to change, in DLB_DATA
# 4. Run your game...
# 5. When it finished, game will close itself
# 6. Close your project *without save*
# 7. Open your project again. Done!
# 8. Set DLB_USE_IT = false. Leave this script in your Script Editor (XP/VX).
#    If you are using VX Ace, you do not need to leave this script in your
#    Script Editor.
#==========================================

  #===========================================================================
  # [ENG] Use limit breaker? (set this to false after you run this script,
  # and haven't change anything in DLB_DATA after that)
  # or REMOVE this script when finished~
  #+==========================================================================
  DLB_USE_IT = false # (true / false)

  if DLB_USE_IT # Do NOT edit this line
    DLB_DATA = {
    #======================================================
    # [ENG] Database file you want to change their number~
    # * Limit of normal database files are 999
    # * Limit of variables and switches are 5000
    # This script will allow you to change their number over their limit~
    #===============================
    # ** How to setup **
    #-------------------------------
    # Add 1 line below per 1 database file you want to change.
    # Structure: 'Database_File' => (number),
    # e.g. 'switch' => 5500,
    # (* Don't forget to put , behind the line!)

    #==============================================
    # ** [List] Database_File **
    #----------------------------------------------
    # 'switch' for Game Switches 
    # 'variable' for Game Variables
    # 'actor' for Actors 
    # 'class' for Classes 
    # 'skill' for Skills 
    # 'item' for Items 
    # 'weapon' for Weapons 
    # 'armor' for Armors 
    # 'enemy' for Enemies 
    # 'troop' for Troops
    # 'state' for States 
    # 'tileset' for Tilesets (RMXP/RMVXA only)
    # 'animation' for Animations 
    # 'commonev' for Common Events
    #======================================================
    # * START to setup from here! 
    #======================================================

    'actor' => 1011,

    #========================================================
    # * [END] Database Limit Breaker Setup Part
    #========================================================
    'end' => nil # Close hash
    }

    if defined?(Audio.setup_midi) # VXA
      dformat = '.rvdata2'
    elsif defined?(Graphics.wait) # VX
      dformat = '.rvdata'
    else # XP
      dformat = '.rxdata'
    end
    start_time = Time.now
    DLB_DATA.each do |k,v|
      dvar = nil
      case k
      when 'switch'; dname = 'System'; dvar = 'switches'; dnewdata = ''
      when 'variable'; dname = 'System'; dvar = 'variables'; dnewdata = ''
      when 'actor'; dname = 'Actors'; dnewdata = 'RPG::Actor.new'
      when 'class'; dname = 'Classes'; dnewdata = 'RPG::Class.new'
      when 'skill'; dname = 'Skills'; dnewdata = 'RPG::Skill.new'
      when 'item'; dname = 'Items'; dnewdata = 'RPG::Item.new'
      when 'weapon'; dname = 'Weapons'; dnewdata = 'RPG::Weapon.new'
      when 'armor'; dname = 'Armors'; dnewdata = 'RPG::Armor.new'
      when 'enemy'; dname = 'Enemies'; dnewdata = 'RPG::Enemy.new'
      when 'troop'; dname = 'Troops'; dnewdata = 'RPG::Troop.new'
      when 'state'; dname = 'States'; dnewdata = 'RPG::State.new'
      when 'animation'; dname = 'Animations'; dnewdata = 'RPG::Animation.new'
      when 'tileset'; dname = 'Tilesets'; dnewdata = 'RPG::Tileset.new'
      when 'commonev'; dname = 'CommonEvents'; dnewdata = 'RPG::CommonEvent.new'
      when 'end'; next
      else; p 'unknown DLB_DATA!', 'Check carefully what you typed in DLB_DATA'
      end
      base_data = load_data('Data/' + dname + dformat)
      data = dvar.nil? ? base_data : eval('base_data.' + dvar.to_s)
      unless data.size > v and v - (data.size - 1) <= 0
        add_data = Array.new(v - (data.size - 1)) { eval(dnewdata) }
        data.push *add_data
        save_data(base_data, 'Data/' + dname + dformat)
      end
    end
    p 'Finished in ' + (Time.now - start_time).to_s + ' sec'
    exit
  end


# checks for VXAce since these methods do not need to be overwritten
# in RGSS3.
unless defined?(Audio.setup_midi)
  
class Game_Switches
  #--------------------------------------------------------------------------
  # * Set Switch
  #     Make the system be able to set switch ID more than 5000
  #--------------------------------------------------------------------------
  def []=(switch_id, value)
    @data[switch_id] = value
  end
end

class Game_Variables
  #--------------------------------------------------------------------------
  # * Set Variable
  #     Make the system be able to set switch ID more than 5000
  #--------------------------------------------------------------------------
  def []=(variable_id, value)
    @data[variable_id] = value
  end
end

end # unless defined?(Audio.setup_midi)