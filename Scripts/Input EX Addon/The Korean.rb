# -*- coding: utf-8 -*-
=begin

The Korean - 조합한글 by 허걱 1.0.1

#------------------------------------------------------------------------------

REQUIRES :
Input Ex - 전체키 입력 확장 by 허걱

#------------------------------------------------------------------------------

# 클래스 생성
kor = Korean.new

# 입력 업데이트 처리
kor.add(Input.get_key) if Input.any_kay?

# 최종 문자열 취득
kor.text

이와 같은 방법으로 사용할 수 있습니다.

=end

#==============================================================================
# ■ KOREAN
#==============================================================================

module KOREAN
  CHO = ['ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ','ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ']
  JOONG = ['ㅏ','ㅐ','ㅑ','ㅒ','ㅓ','ㅔ','ㅕ','ㅖ','ㅗ','ㅘ','ㅙ','ㅚ','ㅛ','ㅜ','ㅝ','ㅞ','ㅟ','ㅠ','ㅡ','ㅢ','ㅣ']
  JONG = ['','ㄱ','ㄲ','ㄳ','ㄴ','ㄵ','ㄶ','ㄷ','ㄹ','ㄺ','ㄻ','ㄼ','ㄽ','ㄾ','ㄿ','ㅀ','ㅁ','ㅂ','ㅄ','ㅅ','ㅆ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ']
  KEYS = ['ㅁ','ㅠ','ㅊ','ㅇ','ㄷ','ㄹ','ㅎ','ㅗ','ㅑ','ㅓ','ㅏ','ㅣ','ㅡ','ㅜ','ㅐ','ㅔ','ㅂ','ㄱ','ㄴ','ㅅ','ㅕ','ㅍ','ㅈ','ㅌ','ㅛ','ㅋ']
  
  CONSONANT = (12593..12622) # 자음 
  # ㄱ, ㄲ, ㄳ, ㄴ, ㄵ, ㄶ, ㄷ, ㄸ, ㄹ, ㄺ, ㄻ, ㄼ, ㄽ, ㄾ, ㄿ, ㅀ, ㅁ, ㅂ, ㅃ, ㅄ, ㅅ, ㅆ, ㅇ, ㅈ, ㅉ, ㅊ, ㅋ, ㅌ, ㅍ, ㅎ
  VOWEL = (12623..12643) # 모음 
  # ㅏ, ㅐ, ㅑ, ㅒ, ㅓ, ㅔ, ㅕ, ㅖ, ㅗ, ㅘ, ㅙ, ㅚ, ㅛ, ㅜ, ㅝ, ㅞ, ㅟ, ㅠ, ㅡ, ㅢ, ㅣ
  # 12593 ~ 12643 사이면 자음 혹은 모음
  
  WORD = (44032..55203) # 유니코드의 한글 범위
  
  BASE_CODE = 44032   # 한글 첫 코드
end


#==============================================================================
# ■ Korean
#==============================================================================

class Korean
  #--------------------------------------------------------------------------
  # ● 초기화
  #--------------------------------------------------------------------------
  def initialize
    @text = ""
    @block_word = false
  end
  #--------------------------------------------------------------------------
  # ● 사용할 키
  #--------------------------------------------------------------------------
  def allow_key
    keys = []
    keys += (Keys::Num0..Keys::Num9).to_a
    keys += (Keys::A..Keys::Z).to_a
    keys += (Keys::Pad0..Keys::Pad9).to_a
    keys += [Keys::Collon, Keys::Equal, Keys::Comma, Keys::Underscore, Keys::Dot,
    Keys::Backslash, Keys::Accent, Keys::LHook, Keys::RBar, Keys::RHook,
    Keys::Quote, Keys::Space, Keys::Back]
    return keys
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def text
    @text
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def set_text(text = "", block = false)
    @text = text.dup
    force_block_word(block)
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def add_text(text = "", block = false)
    @text.concat(text.dup)
    force_block_word(block)
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def force_block_word(block = false)
    @block_word = block
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def add(keys)
    key = keys & allow_key
    key.each {|k| add_key(k) if Input.repeat?(k) }
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def add_key(key)
    case key
    when Keys::Back
      delete
    when Keys::Space
      @text.concat(' ')
      @block_word = false
    else
      if (Keys::A..Keys::Z).include?(key) && Input.is_korean?
        add_korean(key)
      else
        add_other(key)
        @block_word = false
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def add_korean(key)
    word = upcase_word(KOREAN::KEYS[key-65])
    last_word = get_last_word
    case get_type(last_word)
    when 3  # 글자
      piece = get_piece(last_word)
      if KOREAN::JOONG.include?(word)
        if piece[2] == 0
          new_word = uni_vowel(KOREAN::JOONG[piece[1]], word)
          if new_word == nil
            @text.concat(word)
            @block_word = false
          else
            delete_other
            piece[1] = KOREAN::JOONG.index(new_word)
            @text.concat(pack_piece(piece))
            @block_word = true
          end
        else
          w1, w2 = div_consonant(KOREAN::JONG[piece[2]])
          if w2 == nil
            p1 = KOREAN::CHO.index(KOREAN::JONG[piece[2]])
            new_piece = [p1, KOREAN::JOONG.index(word), 0]
            piece[2] = 0
            delete_other
            @text.concat(pack_piece(piece))
            @text.concat(pack_piece(new_piece))
            @block_word = true
          else
            new_piece = [KOREAN::CHO.index(w2), KOREAN::JOONG.index(word), 0]
            piece[2] = KOREAN::JONG.index(w1)
            delete_other
            @text.concat(pack_piece(piece))
            @text.concat(pack_piece(new_piece))
            @block_word = true
          end
        end
      else
        if piece[2] == 0
          if KOREAN::JONG.include?(word)
            delete_other
            piece[2] = KOREAN::JONG.index(word)
            @text.concat(pack_piece(piece))
            @block_word = true
          else
            @text.concat(word)
            @block_word = false
          end
        else
          new_word = uni_consonant(KOREAN::JONG[piece[2]], word)
          if new_word == nil
            @text.concat(word)
            @block_word = false
          else
            delete_other
            piece[2] = KOREAN::JONG.index(new_word)
            @text.concat(pack_piece(piece))
            @block_word = true
          end
        end
      end
    when 2  # 모음
      if KOREAN::JOONG.include?(word)
        new_word = uni_vowel(last_word, word)
        if new_word == nil
          @block_word = false
          @text.concat(word)
        else
          delete_other
          @block_word = true
          @text.concat(new_word)
        end
      else
        @block_word = false
        @text.concat(word)
      end
    when 1  # 자음
      if KOREAN::JOONG.include?(word)
        w1, w2 = div_consonant(last_word)
        delete_other
        @block_word = true
        if w1 == last_word
          @text.concat(get_new_word(last_word,word))
        else
          @text.concat(w1)
          @text.concat(get_new_word(w2,word))
        end
      else
        new_word = uni_consonant(last_word, word)
        if new_word == nil
          @block_word = false
          @text.concat(word)
        else
          delete_other
          @block_word = true
          @text.concat(new_word)
        end
      end
    else    # 나머지
      @block_word = false
      @text.concat(word)
    end
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def add_other(key)
    @text.concat(Keys.name(key))
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def delete
    word = get_last_word
    return if word.nil?
    return delete_other unless @block_word
    case get_type(word)
    when 3  # 글자
      delete_korean
    when 2  # 모음
      w1, w2 = div_vowel(word)
      @block_word = false
      delete_other
      @text.concat(w1) unless w2.nil?
    when 1  # 자음
      w1, w2 = div_consonant(word)
      @block_word = false
      delete_other
      @text.concat(w1) unless w2.nil?
    else
      delete_other
    end
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def delete_korean
    piece = get_piece(get_last_word)
    delete_other
    if piece[2] == 0
      w1, w2 = div_vowel(KOREAN::JOONG[piece[1]])
      if w2.nil?
        @text.concat(KOREAN::CHO[piece[0]])
      else
        @text.concat(pack_piece([piece[0],KOREAN::JOONG.index(w1),0]))
      end
    else
      w1, w2 = div_consonant(KOREAN::JONG[piece[2]])
      if w2.nil?
        @text.concat(pack_piece([piece[0],piece[1],0]))
      else
        @text.concat(pack_piece([piece[0],piece[1],KOREAN::JONG.index(w1)]))
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def delete_other
    @text = @text.slice(0, [@text.size-1, 0].max)
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def pack_piece(piece)
    [KOREAN::BASE_CODE + piece[0] * 588 + piece[1] * 28 + piece[2]].pack("U*")
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def get_new_word(cho, joong, jong = "")
    p1 = KOREAN::CHO.index(cho)
    p2 = KOREAN::JOONG.index(joong)
    p3 = KOREAN::JONG.index(jong)
    return pack_piece([p1,p2,p3])
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def get_piece(word)
    piece = []
    code = get_code(word)
    return piece unless KOREAN::WORD.include?(code)
    code -= KOREAN::BASE_CODE
    piece[0] = (code / (28*21)).to_i
    piece[1] = ((code % (28*21)) / 28).to_i
    piece[2] = (code % 28).to_i
    return piece
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def get_type(word)
    return -1 if word.nil?
    code = get_code(word)
    case code
    when KOREAN::CONSONANT; return 1
    when KOREAN::VOWEL; return 2
    when KOREAN::WORD; return 3
    else; return 0
    end
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def get_code(word)
    word.unpack("U*")[0]
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def get_last_word
    @text.scan(/./)[@text.size - 1]
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def upcase_word(word)
    return word unless Input.upcase?
    if ['ㄱ', 'ㄷ', 'ㅂ', 'ㅅ', 'ㅈ'].include?(word)
      return KOREAN::CHO[KOREAN::CHO.index(word) + 1]
    elsif ['ㅔ', 'ㅐ'].include?(word)
      return KOREAN::JOONG[KOREAN::JOONG.index(word) + 2]
    end
    return word
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def uni_consonant(factor1, factor2)
    case factor1
    when 'ㄱ'
      return 'ㄳ' if factor2 == 'ㅅ'
    when 'ㄴ'
      return 'ㄵ' if factor2 == 'ㅈ'
      return 'ㄶ' if factor2 == 'ㅎ'
    when 'ㄹ'
      return 'ㄺ' if factor2 == 'ㄱ'
      return 'ㄻ' if factor2 == 'ㅁ'
      return 'ㄼ' if factor2 == 'ㅂ'
      return 'ㄽ' if factor2 == 'ㅅ'
      return 'ㄾ' if factor2 == 'ㅌ'
      return 'ㄿ' if factor2 == 'ㅍ'
      return 'ㅀ' if factor2 == 'ㅎ'
    when 'ㅂ'
      return 'ㅄ' if factor2 == 'ㅅ'
    end
    return nil
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def uni_vowel(factor1, factor2)
    case factor1
    when 'ㅗ'
      return 'ㅘ' if factor2 == 'ㅏ'
      return 'ㅙ' if factor2 == 'ㅐ'
      return 'ㅚ' if factor2 == 'ㅣ'
    when 'ㅜ'
      return 'ㅝ' if factor2 == 'ㅓ'
      return 'ㅞ' if factor2 == 'ㅔ'
      return 'ㅟ' if factor2 == 'ㅣ'
    when 'ㅡ'
      return 'ㅢ' if factor2 == 'ㅣ'
    end
    return nil
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def div_consonant(factor)
    case factor
    when 'ㄳ'; return ['ㄱ', 'ㅅ']
    when 'ㄵ'; return ['ㄴ', 'ㅈ']
    when 'ㄶ'; return ['ㄴ', 'ㅎ']
    when 'ㄺ'; return ['ㄹ', 'ㄱ']
    when 'ㄻ'; return ['ㄹ', 'ㅁ']
    when 'ㄼ'; return ['ㄹ', 'ㅂ']
    when 'ㄽ'; return ['ㄹ', 'ㅅ']
    when 'ㄾ'; return ['ㄹ', 'ㅌ']
    when 'ㄿ'; return ['ㄹ', 'ㅍ']
    when 'ㅀ'; return ['ㄹ', 'ㅎ']
    when 'ㅄ'; return ['ㅂ', 'ㅅ']
    end
    return [factor]
  end
  #--------------------------------------------------------------------------
  # ● 
  #--------------------------------------------------------------------------
  def div_vowel(factor)
    case factor
    when 'ㅘ'; return ['ㅗ', 'ㅏ']
    when 'ㅙ'; return ['ㅗ', 'ㅐ']
    when 'ㅚ'; return ['ㅗ', 'ㅣ']
    when 'ㅝ'; return ['ㅜ', 'ㅓ']
    when 'ㅞ'; return ['ㅜ', 'ㅔ']
    when 'ㅟ'; return ['ㅜ', 'ㅣ']
    when 'ㅢ'; return ['ㅡ', 'ㅣ']
    end
    return [factor]
  end
end







# presented by 허걱