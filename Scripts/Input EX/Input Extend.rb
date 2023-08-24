# -*- coding: utf-8 -*-
=begin
 
Input Ex System - 전체키 입력 확장 by 허걱 ver 1.2.5
 
 
 
Input.???([key])

ex> Input.release?(Keys::K)  #  K 버튼을 뗀 순간 true 를 반환.
 
 
press?(key)           # 키가 눌려져 있는 상태인지 확인
trigger?(key)         # 키를 눌렀는지 확인
release?(key)         # 키를 뗏는지 확인
repeat?(key)          # 키가 밀리는지 확인
 
any_key?              # 아무키나 눌렸는지 확인
get_state(key)        # 키의 상태를 확인
 
get_key               # 눌려진 키의 배열을 취득
press_count(key)  # 키가 눌려져 있는 시간 취득
free_count        # 아무키도 안눌렸을 때의 경과 시간
 
dir4                  # 4 방향키 눌림 확인 - 0, 2, 4, 6, 8
dir8                  # 8 방향키 눌림 확인 - 0, 1, 2, 3, 4, 6, 7, 8, 9
 
upcase?               # 대문자 상태 확인
 
 
=end
 
 
 
 
#--------------------------------------------------
# 설정
#--------------------------------------------------
module InoutExConfig
  REPEAT_PREPARE = 30   # repeat 인식 시간
  REPEAT_DELAY   = 5  # repeat 인식 간격
  DEFAULT_KOREAN = false # 기본 한영상태 true 일 경우 한글/ false 일 경우 영어
end
 
 
 
#--------------------------------------------------
# 키 코드
#--------------------------------------------------
module Keys
  MouseL = 1
  MouseR = 2
  MouseM = 4
 
  Cancel = 3  # Ctrl + Break
 
  Back = 8
  Tab = 9
  Clear = 12  # NumLock이 꺼져 있을때의 KEY_PAD_5
  Enter = 13
  Shift = 16
  Ctrl = 17
  Alt = 18
  Pause = 19
  CapsLock = 20
  Korean = 21
  Chinese = 25
  Esc = 27
  Space = 32
  PGUP = 33
  PGDN = 34
  End = 35
  Home = 36
  Left = 37
  Up = 38
  Right = 39
  Down = 40
  Select = 41
  Execute = 43
  PrintScreen = 44
  Insert = 45
  Delete = 46
  Help = 47
 
  Num0 = 48
  Num1 = 49
  Num2 = 50
  Num3 = 51
  Num4 = 52
  Num5 = 53
  Num6 = 54
  Num7 = 55
  Num8 = 56
  Num9 = 57
 
  A = 65
  B = 66
  C = 67
  D = 68
  E = 69
  F = 70
  G = 71
  H = 72
  I = 73
  J = 74
  K = 75
  L = 76
  M = 77
  N = 78
  O = 79
  P = 80
  Q = 81
  R = 82
  S = 83
  T = 84
  U = 85
  V = 86
  W = 87
  X = 88
  Y = 89
  Z = 90
 
  LWin = 91
  RWin = 92
  Apps = 93
 
  Pad0 = 96
  Pad1 = 97
  Pad2 = 98
  Pad3 = 99
  Pad4 = 100
  Pad5 = 101
  Pad6 = 102
  Pad7 = 103
  Pad8 = 104
  Pad9 = 105
  Multiply = 106
  Add = 107
  Separator = 108
  Subtract = 109
  Decimal = 110
  Divide = 111
 
  F1 = 112
  F2 = 113
  F3 = 114
  F4 = 115
  F5 = 116
  F6 = 117
  F7 = 118
  F8 = 119
  F9 = 120
  F10 = 121
  F11 = 122
  F12 = 123
 
  NumLock = 144
  ScrollLock = 145
 
  LShift = 160
  RShift = 161
  LCtrl = 162
  RCtrl = 163
  LAlt = 164
  RAlt = 165
 
  Collon = 186
  Equal = 187
  Comma = 188
  Underscore = 189
  Dot = 190
  Backslash = 191
  Accent = 192
  Query = 193
  Float = 194
  LHook = 219
  RBar = 220
  RHook = 221
  Quote = 222
  LBar   = 226
 
  DEFAULT_KEY = {
  :LEFT => Left,
  :UP => Up,
  :RIGHT => Right,
  :DOWN => Down,
  :A => Shift,
  :B => [Esc, Pad0, X],
  :C => [Enter, Space, Z],
  :X => A,
  :Y => S,
  :Z => D,
  :L => Q,
  :R => W,
  :SHIFT => Shift,
  :CTRL => Ctrl,
  :ALT => Alt,
  :F5 => F5,
  :F6 => F6,
  :F7 => F7,
  :F8 => F8,
  :F9 => F9,
  }
 
  StateKeys = [Pause,CapsLock,Korean,Chinese,NumLock,ScrollLock]
 
  Names = {
  1=>['MouseL', 'Mouse Left Button'],
  2=>['MouseR', 'Mouse Right Button'],
  3=>['Cancel'],
  4=>['MouseM', 'Mouse Middle Button'],
  8=>['Back'], 9=>['Tab'], 12=>['Clear'], 13=>['Enter'],
  16=>['Shift'], 17=>['Ctrl'], 18=>['Alt'], 19=>['Pause'], 20=>['CapsLock'],
  27=>['Esc'], 32=>[' ', 'Space'], 33=>['PGUP', 'Page Up'], 34=>['PGDN', 'Page Down'],
  35=>['End'], 36=>['Home'], 37=>['Left'], 38=>['Up'], 39=>['Right'],
  40=>['Down'], 41=>['Select'], 43=>['Execute'], 44=>['PrintScreen'],
  45=>['Insert'], 46=>['Delete'], 47=>['Help'],
  48=>['0', ')'], 49=>['1', '!'], 50=>['2', '@'], 51=>['3', '#'], 52=>['4', '$'],
  53=>['5', '%'], 54=>['6', '^'], 55=>['7', '&'], 56=>['8', '*'], 57=>['9', '('],
  65=>['a', 'A'], 66=>['b', 'B'], 67=>['c', 'C'], 68=>['d', 'D'], 69=>['e', 'E'],
  70=>['f', 'F'], 71=>['g', 'G'], 72=>['h', 'H'], 73=>['i', 'I'], 74=>['j', 'J'],
  75=>['k', 'K'], 76=>['l', 'L'], 77=>['m', 'M'], 78=>['n', 'N'], 79=>['o', 'O'],
  80=>['p', 'P'], 81=>['q', 'Q'], 82=>['r', 'R'], 83=>['s', 'S'], 84=>['t', 'T'],
  85=>['u', 'U'], 86=>['v', 'V'], 87=>['w', 'W'], 88=>['x', 'X'], 89=>['y', 'Y'],
  90=>['z', 'Z'],
  91=>['LWin'], 92=>['RWin'], 93=>['Apps'],
  96=>['0'], 97=>['1'], 98=>['2'], 99=>['3'], 100=>['4'],
  101=>['5'], 102=>['6'], 103=>['7'], 104=>['8'], 105=>['9'],
  106=>['*'], 107=>['+'], 108=>['Separator'], 109=>['-'], 110=>['.'], 111=>['/'],
  112=>['F1'], 113=>['F2'], 114=>['F3'], 115=>['F4'], 116=>['F5'], 117=>['F6'],
  118=>['F7'], 119=>['F8'], 120=>['F9'], 121=>['F10'], 122=>['F11'], 123=>['F12'],
  144=>['NumLock'], 145=>['ScrollLock'], 160=>['LShift'], 161=>['RShift'],
  162=>['LCtrl'], 163=>['RCtrl'], 164=>['LAlt'], 165=>['RAlt'],
  186=>[';', ':'], 187=>['=', '+'], 188=>[',', '<'], 189=>['-', '_'],
  190=>['.', '>'], 191=>['/', '?'], 192=>['`', '~'], 193=>['Query'],
  194=>['Float'], 219=>['[', '{'], 220=>['\\', '|'], 221=>[']', '}'],
  222=>['\'', '"'], 226=>['LBar']
  }
 
  def self.name(key, upcase = Input.upcase?)
    return "" unless Names.keys.include?(key)
    return Names[key][1] unless Names[key][1].nil? if upcase
    return Names[key][0]
  end
 
end
 
 
 
module Input
  #--------------------------------------------------
  # API
  #--------------------------------------------------
  @@key_state = Win32API.new("user32", "GetAsyncKeyState", "i", "i")
  @@cap_state = Win32API.new("user32", "GetKeyState", "i", "i")
 
  #--------------------------------------------------
  # Variables
  #--------------------------------------------------
  @@korean = InoutExConfig::DEFAULT_KOREAN
 
  MAXIMUM_SIZE = 256
  @@key_count = [0]*MAXIMUM_SIZE
  @@key_free_count = 0
  @@state_check = {}
  Keys::StateKeys.each do |key|
    @@state_check[key] = (@@cap_state.call(key) & 1 == 1)
  end
 
  REPEAT_PREPARE = InoutExConfig::REPEAT_PREPARE
  REPEAT_DELAY = InoutExConfig::REPEAT_DELAY
 
  #--------------------------------------------------
  # Check_Key
  #--------------------------------------------------
  def self.check_key(key)
    r1 = (@@key_state.call(key) & 0x8000 == 0x8000)
    r2 = (@@key_state.call(key) & 0x8001 == 0x8001)
    return (r1 || r2)
  end
 
  #--------------------------------------------------
  # Check_Upcase
  #--------------------------------------------------
  def self.upcase?
    return (@@state_check[Keys::CapsLock] ^ press?(:SHIFT))
  end
 
  #--------------------------------------------------
  # Update
  #--------------------------------------------------
  def self.update
    key_free = true
    MAXIMUM_SIZE.times do |key|
      if [Keys::Korean,Keys::Chinese].include?(key)
        key_state_is_free = @@key_state.call(key) & 0x8001 == 0x8000
        if key_state_is_free
          @@key_count[key] = 0
        else
          @@korean = !@@korean if key == Keys::Korean
          @@state_check[key] = (@@state_check[key] == true ? false : true)
          @@key_count[key] = 1
        end
      elsif [Keys::Pause,Keys::CapsLock,Keys::NumLock,Keys::ScrollLock].include?(key)
        key_state = @@cap_state.call(key) & 1 == 1
        if @@state_check[key] == key_state
          @@key_count[key] = 0
        else
          @@state_check[key] = key_state
          @@key_count[key] = 1
          key_free = false
        end
      elsif check_key(key)
        @@key_count[key] += 1
        key_free = false
      elsif @@key_count[key] > 0
        @@key_count[key] = -1
      else
        @@key_count[key] = 0
      end
    end
    key_free ? @@key_free_count += 1 : @@key_free_count = 0
  end
 
  #--------------------------------------------------
  # Press - 키가 눌려져 있는 상태인지 확인
  #--------------------------------------------------
  def self.press?(key)
    key = adjust_key(key)
    return key.any? {|i| @@key_count[i] > 0 }
  end
 
  #--------------------------------------------------
  # Trigger - 키를 눌렀는지 확인
  #--------------------------------------------------
  def self.trigger?(key)
    key = adjust_key(key)
    trigger_count = 2
    return key.any? do |i|
      if @@key_count[i].between?(1,trigger_count)
        @@key_count[i] = trigger_count
      end
      @@key_count[i] == trigger_count
    end
  end
 
  #--------------------------------------------------
  # Release - 키를 뗏는지 확인
  #--------------------------------------------------
  def self.release?(key)
    key = adjust_key(key)
    return key.any? {|i| @@key_count[i] == -1 }
  end
 
  #--------------------------------------------------
  # Repeat - 키가 밀리는지 확인
  # ratio : 스크립트와 이벤트의 키 인식시간 오차 수정용
  #         스크립트상에서 repeat? 사용할 때 : ratio => 30
  #--------------------------------------------------
  def self.repeat?(key, ratio = 1)
    key = adjust_key(key)
    return key.any? {|i| check_repeat?(i, [ratio, 1].max) }
  end
 
  #--------------------------------------------------
  # Check_Repeat
  #--------------------------------------------------
  def self.check_repeat?(key, ratio)
    return true if @@key_count[key] == 1
    return false if @@key_count[key] == 2
    return false if @@key_count[key] < (REPEAT_PREPARE * ratio)
    return @@key_count[key] % (REPEAT_DELAY * ratio) == 0
  end
 
  #--------------------------------------------------
  # GetPressCount - 키가 눌려져 있는 시간 취득
  #--------------------------------------------------
  def self.press_count(key)
    return 0 unless press?(key)
    keys = adjust_key(key)
    key = keys.max_by {|i| @@key_count[i]}
    return @@key_count[key]
  end
 
  #--------------------------------------------------
  # Adjust_Key
  #--------------------------------------------------
  def self.adjust_key(key)
    if Keys::DEFAULT_KEY.keys.include?(key)
      key = Keys::DEFAULT_KEY[key]
    end
    return key.is_a?(Array) ? key : [key]
  end
 
  #--------------------------------------------------
  # GetFreeCount - 아무키도 안눌렸을 때의 경과 시간
  #--------------------------------------------------
  def self.get_state(key)
    return is_korean? if key == Keys::Korean
    return press?(key) unless @@state_check.keys.include?(key)
    return @@state_check[key]
  end
 
  #--------------------------------------------------
  # GetFreeCount - 아무키도 안눌렸을 때의 경과 시간
  #--------------------------------------------------
  def self.free_count
    return @@key_free_count
  end
 
  #--------------------------------------------------
  # GetKey - 눌려진 키의 배열 취득
  #--------------------------------------------------
  def self.get_key
    result = []
    MAXIMUM_SIZE.times {|i| result.push(i) if @@key_count[i] > 0 }
    return result
  end
 
  #--------------------------------------------------
  # AnyKey? - 키가 눌렸는지 확인
  #--------------------------------------------------
  def self.any_key?
    return free_count == 0
  end
 
  #--------------------------------------------------
  # Dir4
  #--------------------------------------------------
  def self.dir4
    down = 1;    left = 2;    right = 4;    up = 8
    return 2 if dir & down == down
    return 4 if dir & left == left
    return 6 if dir & right == right
    return 8 if dir & up == up
    return 0
  end
 
  #--------------------------------------------------
  # Dir8
  #--------------------------------------------------
  def self.dir8
    down = 1;    left = 2;    right = 4;    up = 8
    case dir
    when down; return 2
    when left; return 4
    when right; return 6
    when up; return 8
    when down+left; return 1
    when down+right; return 3
    when up+left; return 7
    when up+right; return 9
    else; return 0
    end
  end
 
  #--------------------------------------------------
  # Dir
  #--------------------------------------------------
  def self.dir
    result = 0
    result += 1 if press?(Keys::Down)
    result += 2 if press?(Keys::Left)
    result += 4 if press?(Keys::Right)
    result += 8 if press?(Keys::Up)
    return result
  end
 
  #--------------------------------------------------------------------------
  # ●
  #--------------------------------------------------------------------------
  def self.is_korean?
    return @@korean
  end
 
  #--------------------------------------------------------------------------
  # ●
  #--------------------------------------------------------------------------
  def self.toggle_korean
    @@korean = !@@korean
  end
end
 
 
 
 
 
 
 
class Game_Interpreter
  #--------------------------------------------------------------------------
  # ●
  #--------------------------------------------------------------------------
  alias input_ex_command_111 command_111
  def command_111
    @params[1] = adjust_original_key(@params[1]) if @params[0] == 11
    input_ex_command_111
  end
  #--------------------------------------------------------------------------
  # ●
  #--------------------------------------------------------------------------
  def adjust_original_key(key)
    new_key = {2=>:DOWN, 4=>:LEFT, 6=>:RIGHT, 8=>:UP,
    11=>:A, 12=>:B, 13=>:C, 14=>:X, 15=>:Y, 16=>:Z, 17=>:L, 18=>:R}
    return new_key[key] if new_key.keys.include?(key)
    return key
  end
end
 
 
 
# presented by 허걱