module Spree
  class PaymentMethod < Spree.base_class
    module AutoCaptureDigitalConcern
      extend ActiveSupport::Concern

      included do
        preference :auto_capture_for_digital_only_orders, :boolean, default: false
      end
    end
  end
end
