require "nio"

module Nio
  class PercentFmt < Fmt
    def initialize options=nil
      @percent_symbol = nil
      @percent_digits = -2
      super
    end

    def nio_write_formatted(neutral)
      neutral = neutral.dup
      neutral.dec_pos -= @percent_digits
      super + "%"
    end

    def nio_read_formatted(txt)
      if txt =~ /%\z/
        txt = txt[0..-2]
        neutral = super(txt)
        neutral.dec_pos += @percent_digits
        return neutral
      end
      super
    end
  end
end
