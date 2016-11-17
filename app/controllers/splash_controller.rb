class SplashController < ApplicationController
    def splash
    end
    
    def search
        redirect_to listings_path
    end
    
    def advanced_query
        redirect_to listings_path
    end
end