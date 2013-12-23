module Notice::Promotions
  module InstanceMethods

    # @param [AbstractPromotion] promotion
    def call_after_advance(promotion)
      raise NotImplementedError
    end

    def promotions
      [
          main_page_promotion,
          highlight_promotion,
          up_promotion,
          vip_promotion,
          top_promotion
      ]
    end

    def main_page_promotion
      MPPromotion.new(self)
    end

    def highlight_promotion
      HLPromotion.new(self)
    end

    def up_promotion
      UpPromotion.new(self)
    end

    def vip_promotion
      VipPromotion.new(self)
    end

    def top_promotion
      TopPromotion.new(self)
    end

  end
end

