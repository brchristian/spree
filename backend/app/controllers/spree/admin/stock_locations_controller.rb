module Spree
  module Admin
    class StockLocationsController < ResourceController

      before_filter :set_country, :only => :new
      before_action :load_data, :except => [:index]

      private

      def set_country
        begin
          if Spree::Config[:default_country_id].present?
            @stock_location.country = Spree::Country.find(Spree::Config[:default_country_id])
          else
            @stock_location.country = Spree::Country.find_by!(iso: 'US')
          end

        rescue ActiveRecord::RecordNotFound
          flash[:error] = Spree.t(:stock_locations_need_a_default_country)
          redirect_to admin_stock_locations_path and return
        end
      end
      
      def load_data
        @calculators = StockLocation.calculators.sort_by(&:name)
      end

    end
  end
end
