require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class PerItem < ShippingCalculator
      preference :amount, :decimal, default: 0
      preference :currency, :string, default: ->{ Spree::Config[:currency] }

      def self.description
        Spree.t(:shipping_flat_rate_per_item)
      end

      def compute_package(package)
        compute_quantity(package.contents.sum(&:quantity))
      end
      
      def compute_shipment(shipment)
        compute_quantity(shipment.manifest.sum(&:quantity))
      end
      
      def compute_quantity(quantity)
        self.preferred_amount * quantity
      end
    end
  end
end
