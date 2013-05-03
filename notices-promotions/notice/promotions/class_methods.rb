module Notice::Promotions
  module ClassMethods

    def promoted_by_vip
      VipPromotion.promoted_notices(self)
    end

    def promoted_by_top
      TopPromotion.promoted_notices(self)
    end

    def promoted_by_main_page
      MPPromotion.promoted_notices(self)
    end

  end
end
