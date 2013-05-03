# encoding: utf-8

# Продвижение - один из компонентов природы Объявления.
#
# How to use:
#
# Notice.scoped.promoted_by_vip
#
# promotions = notice.promotions
# promotions.select(&:active?)
#
# promotion = notice.highlight_promotion
# promotion.advance(12.hours, color: 'ff6666')
# if promotion.active?
#   p promotion.color
#   p promotion.end_at
# end
#
# ----
# MPPromotion.promoted_notices(Notice.scoped)
#
# promotion = MPPromotion.new(notice)
#
module Notice::Promotions

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end


  class AbstractPromotion
    include Attributes

    attr_reader :notice

    def initialize(notice)
      @notice = notice
    end

    def self.promoted_notices(collection)
      collection.where("#{collection.table_name}.#{@attributes[:end_at]} > ?", Time.zone.now)
    end

    def attr_end_at
      raise NotImplementedError
    end

    def end_at
      attr_end_at.read
    end

    # @return [Integer] seconds
    def get_duration
      if attr_end_at.read
        duration = attr_end_at.read - Time.zone.now
        duration > 0 ? duration : 0
      else
        0
      end
    end

    def active?
      get_duration > 0
    end

    # @param [Integer] duration seconds
    # @param [Hash] options
    def advance(duration, options = {})
      attr_end_at.write( Time.zone.now.since(get_duration + duration) )
      @notice.call_after_advance(self)
      self
    end

    # @param [Integer] duration seconds
    # @param [Hash] options
    def advance!(duration, options = {})
      advance(duration, options)
      @notice.save!
      self
    end

  end

  class MPPromotion < AbstractPromotion
    uses_attr :end_at, :from => :notice, :source => :main_page_until
  end

  class UpPromotion < AbstractPromotion
    uses_attr :end_at, :from => :notice, :source => :up_until
  end

  class TopPromotion < AbstractPromotion
    uses_attr :end_at, :from => :notice, :source => :top_until
  end

  class VipPromotion < AbstractPromotion
    uses_attr :end_at, :from => :notice, :source => :vip_until
  end

  class HLPromotion < AbstractPromotion
    COLORS = %W(ffcc33 ff6666 99cc33 33ccff cc66ff)

    uses_attr :end_at, :from => :notice, :source => :highlight_until
    uses_attr :color, :from => :notice, :source => :highlight_color

    def advance(duration, options = {})
      set_color(options[:color])
      super
    end

    def color
      active? ? attr_color.read : ''
    end

    private

    def set_color(color)
      color = COLORS.first if COLORS.exclude?(color)

      attr_color.write(color)
    end
  end

end
