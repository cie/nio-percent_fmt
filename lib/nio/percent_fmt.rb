require "nio"

module Nio
  class Fmt
    def percent! pc=true
      extend(Nio::PercentFmt)
      @percent = pc
      @mode = :sig
      self
    end

    def percent pc=true
      dup.percent! pc
    end
  end

  module PercentFmt
    def nio_write_formatted(neutral)
      if @percent
        neutral = neutral.dup
        neutral.dec_pos -= (@percent_digits || -2)
        super + "%"
      else
        super
      end
    end

    def nio_read_formatted(txt)
      if txt =~ /%\z/
        txt = txt[0..-2]
        neutral = super(txt)
        neutral.dec_pos += (@percent_digits || -2)
        neutral
      else
        super
      end
    end
  end
end
