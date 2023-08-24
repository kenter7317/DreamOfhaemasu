# -*- coding: utf-8 -*-
## RPG 쯔꾸르 VX Ace용 한국어 조사 처리 스크립트 130301 by Chiri
##
## 사용법 : 받침 유무에 따라 자동으로 조사 처리를 원하는 부분에
##          ['받침이 있을 경우의 조사';'받침이 없을 경우의 조사']
##          와 같은 형식으로 입력해 주시면 됩니다.
##           예 - \N[1][은;는] 1280골드[을;를] 얻었다!
##          이벤트의 텍스트 출력 및 전투 스크립트 등 윈도에서 출력되는
##          부분이라면 거의 사용이 가능할 것입니다.
##
##          ======================================================
##          스크립트는 되도록 아랫쪽으로 배치해 주시기 바랍니다.
##          (메시지 윈도우와 관련된 각종 스크립트보다 아랫쪽으로)
##          ======================================================
##
##
## fallroot님(http://dailyupgrade.me/), superkdk님(http://blog.superkdk.com/)의
## 스크립트를 참고 및 빌려썼습니다. 감사드립니다.


class Window_Base < Window
  alias handling_korean_particles_convert_escape_characters convert_escape_characters
  def convert_escape_characters(text)
    result = handling_korean_particles_convert_escape_characters(text)
    result.gsub!(/(?<=(.{1}))\[\[(.?\;.?)\]\]/) { Korean_particles.get_proposition($1, $2) } # 한국어 조사 처리 함수를 부르는 부분
    result.gsub!(/(?<=(.{1}))\[(.?\;.?)\]/) { Korean_particles.get_proposition($1, $2) } # 한국어 조사 처리 함수를 부르는 부분
    result
  end
end

class Korean_particles
  # http://dailyupgrade.me/
  # 받침에 따른 알맞은 조사를 구한다.
  PROPOSITIONS = {'이' => '가', '은' => '는', '을' => '를', '과' => '와', '으' => ''}
  KOREANNUMBER = {'1' => '일', '2' => '이', '3' => '삼', '4' => '사', '5' => '오', '6' => '육', '7' => '칠', '8' => '팔', '9' => '구', '0' => '영'}
  KOREANALPHABET = {'A' => '이', 'B' => '비', 'C' => '씨', 'D' => '디', 'E' => '이', 'F' => '프', 'G' => '지', 'H' => '치', 'I' => '이', 'J' => '이', 'K' => '이', 'L' => '엘', 'M' => '엠', 'N' => '엔', 'O' => '오', 'P' => '피', 'Q' => '큐', 'R' => '알', 'S' => '스', 'T' => '티', 'U' => '유', 'V' => '이', 'W' => '유', 'X' => '스', 'Y' => '이', 'Z' => '트'}
  KOREANALPHABETFULL = {'Ａ' => '이', 'Ｂ' => '비', 'Ｃ' => '씨', 'Ｄ' => '디', 'Ｅ' => '이', 'Ｆ' => '프', 'Ｇ' => '지', 'Ｈ' => '치', 'Ｉ' => '이', 'Ｊ' => '이', 'Ｋ' => '이', 'Ｌ' => '엘', 'Ｍ' => '엠', 'Ｎ' => '엔', 'Ｏ' => '오', 'Ｐ' => '피', 'Ｑ' => '큐', 'Ｒ' => '알', 'Ｓ' => '스', 'Ｔ' => '티', 'Ｕ' => '유', 'Ｖ' => '이', 'Ｗ' => '유', 'Ｘ' => '스', 'Ｙ' => '이', 'Ｚ' => '트'}
 
  def self.get_proposition word, proposition
 
    proposition1 = proposition.split(';')
 
    if word.to_i > 0
      word = KOREANNUMBER[word]
    end
    if word == "0"
      word = KOREANNUMBER[word]
    end
 
    if word.scan(/[A-Z]/).size > 0
      word = KOREANALPHABET[word]
    end
    if word.scan(/[a-z]/).size > 0
      word = KOREANALPHABET[word.upcase]
    end
    if word.scan(/[Ａ-Ｚ]/).size > 0
      word = KOREANALPHABETFULL[word]
    end
 
    word.separate
    # 받침이 없을 때
    if word.separate[2] == ""
      proposition1[1]
    # 받침이 있을 때
    else
      proposition1[0]
    end
  end
end
 
class String
  # http://blog.superkdk.com/?p=68
  # 한글 초성, 중성, 종성. (UTF-8 이어야 함)
  @@chosung = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']
  @@jungsung = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ']
  @@jongsung = ['', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']
  # UTF-8 형식의 문자열을 분해한다.
  def separate
    separated = []
 
    self.unpack('U*').each do |c|
      n = (c & 0xFFFF).to_i
 
      # 유니코드 2.0 한글의 범위 : AC00(가) ~ D7A3(힣)
      if n >= 0xAC00 && n <= 0xD7A3
        n = n-0xAC00
        n1 = n / (21 * 28)  # 초성 : ‘가’ ~ ‘깋’ -> ‘ㄱ’
        n = n % (21 * 28)  # ‘가’ ~ ‘깋’에서의 순서
        n2 = n / 28;    # 중성
        n3 = n % 28;    # 종성
 
        separated << @@chosung[n1] << @@jungsung[n2] << @@jongsung[n3]
      else
#        separated << c.to_a.pack('U')
      end
    end
     separated
  end
end