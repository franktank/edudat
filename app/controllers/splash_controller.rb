class SplashController < ApplicationController
    def splash
        query_all_state="SELECT *
                         FROM state"
        @states = ActiveRecord::Base.connection.exec_query(query_all_state)
        @states.to_hash
        puts @states
        if params[:search]
          query_state="SELECT *
                       FROM state
                       WHERE state.state_name = '#{params[:search]}'"

          @states = ActiveRecord::Base.connection.exec_query(query_state)
          @states.to_hash
        end

    end

    def advanced_query
        redirect_to listings_path
    end
end
