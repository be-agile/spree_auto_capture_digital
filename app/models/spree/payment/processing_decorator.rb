module Spree
  class Payment < Spree.base_class
    module ProcessingDecorator
      # @gem-override spree_core-5.3.6/app/models/spree/payment/processing.rb#process!
      # @see https://github.com/be-agile/giga-repeat/issues/1020
      # ダウンロード商品のみの注文では auto_capture が「いいえ」でも purchase!（即時売上）し、それ以外は super。
      def process!
        if should_auto_capture_for_digital_order?
          Rails.logger.info "[Payment] Auto-capturing digital-only order (order: #{order.number}, payment_method: #{payment_method.class.name})"
          purchase!
        else
          super
        end
      end

      private

      def should_auto_capture_for_digital_order?
        # payment_methodが該当preferenceを持っているかチェック
        return false unless payment_method.respond_to?(:preferred_auto_capture_for_digital_only_orders)

        # 通常のauto_captureがtrueなら不要
        return false if payment_method&.auto_capture?

        # 設定が有効で、かつダウンロード商品のみの注文かチェック
        payment_method.preferred_auto_capture_for_digital_only_orders && order.digital?
      end
    end
  end
end

Spree::Payment::Processing.prepend(Spree::Payment::ProcessingDecorator)
