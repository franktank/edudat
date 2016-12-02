class SplashController < ApplicationController
    def splash
        query_all_state="SELECT *
                         FROM state"
        @states = ActiveRecord::Base.connection.exec_query(query_all_state)
    end

    def search
        redirect_to listings_path
    end

    def advanced_query
        redirect_to listings_path
    end
end
