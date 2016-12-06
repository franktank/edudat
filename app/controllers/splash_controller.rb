class SplashController < ApplicationController
    def splash
        if params[:state]
          distinct_districts_in_each_state = "SELECT STATE.STATE_NAME, COUNT(DISTINCT DISTRICT.NCESID) AS Count_NCESID
                    FROM COUNTY
                    INNER JOIN DISTRICT
                    ON COUNTY.STATE_NUMBER   = DISTRICT.STATENUM
                    AND COUNTY.COUNTY_NUMBER = DISTRICT.CONUM
                    INNER JOIN STATE
                    ON STATE.STATE_NUMBER = COUNTY.STATE_NUMBER
                    WHERE regexp_like(STATE.STATE_NAME, '#{params[:state]}', 'i')
                    GROUP BY STATE.STATE_NAME"
          @ddies = ActiveRecord::Base.connection.exec_query(distinct_districts_in_each_state)
          @ddies.to_hash
        end

        if params[:count_hispanic] && params[:enrollment]
          hispanic_count = "SELECT SCHOOL.S_NAME,
                            SCHL_DEMO.HISP,
                            SCHL_ENROLL.S_ENROLL
                            FROM SCHOOL
                            INNER JOIN SCHL_DEMO
                            ON SCHOOL.U_NCESID = SCHL_DEMO.U_NCESID
                            INNER JOIN SCHL_ENROLL
                            ON SCHOOL.U_NCESID = SCHL_ENROLL.U_NCESID
                            INNER JOIN SCHL_ADDRESS
                            ON SCHOOL.U_NCESID       = SCHL_ADDRESS.U_NCESID
                            WHERE SCHL_DEMO.HISP     > #{params[:count_hispanic].gsub(/\D/, '').to_i}
                            AND SCHL_ENROLL.S_ENROLL > #{params[:enrollment].gsub(/\D/, '').to_i}
                            GROUP BY SCHOOL.S_NAME,
                            SCHL_DEMO.HISP,
                            SCHL_ENROLL.S_ENROLL
                            ORDER BY SCHL_DEMO.HISP DESC"
          @counts = ActiveRecord::Base.connection.exec_query(hispanic_count)
          @counts.to_hash
        end


        if params[:state_prop]
          state_prop_info = "SELECT STATE_NAME, Avg_MED_PROP_TAX, Avg_MED_HOME_VAL
                             FROM(SELECT STATE.STATE_NAME,
                             AVG(DISTINCT PROP_TAX.MED_PROP_TAX) AS Avg_MED_PROP_TAX,
                             AVG(DISTINCT PROP_TAX.MED_HOME_VAL) AS Avg_MED_HOME_VAL
                             FROM STATE
                             INNER JOIN COUNTY
                             ON STATE.STATE_NUMBER = COUNTY.STATE_NUMBER
                             INNER JOIN PROP_TAX
                             ON COUNTY.STATE_NUMBER   = PROP_TAX.STATE_NUMBER
                             AND COUNTY.COUNTY_NUMBER = PROP_TAX.COUNTY_NUMBER
                             GROUP BY STATE.STATE_NAME)
                             WHERE regexp_like(STATE_NAME, '#{params[:state_prop]}', 'i')"
          @spi = ActiveRecord::Base.connection.exec_query(state_prop_info)
          @spi.to_hash
        end

        if params[:fall_enr] && params[:dist_rev]
          state_fall_enr_dist_rev = "SELECT STATE.STATE_NAME
                                     FROM DISTRICT
                                     INNER JOIN DISTRICT_REVENUE
                                     ON DISTRICT.NCESID = DISTRICT_REVENUE.NCESID
                                     INNER JOIN COUNTY
                                     ON COUNTY.STATE_NUMBER   = DISTRICT.STATENUM
                                     AND COUNTY.COUNTY_NUMBER = DISTRICT.CONUM
                                     INNER JOIN STATE
                                     ON STATE.STATE_NUMBER          = COUNTY.STATE_NUMBER
                                     WHERE DISTRICT.FALL_ENROLLMENT > #{params[:fall_enr].to_i}
                                     AND DISTRICT_REVENUE.TOTALREV  < #{params[:dist_rev].to_i}
                                     GROUP BY STATE.STATE_NAME"
          @sfedr = ActiveRecord::Base.connection.exec_query(state_fall_enr_dist_rev)
          @sfedr.to_hash
        end

        if params[:spending]
          spending_pupil = "SELECT STATE_NAME, COUNTY_NAME, NAME, Sum_TOTAL_SPENDING
                            FROM(SELECT STATE.STATE_NAME,COUNTY.COUNTY_NAME,
                            DISTRICT.NAME,
                            SUM(DISTRICT_SPENDING_PER_PUPIL.TOTAL_SPENDING) AS Sum_TOTAL_SPENDING
                            FROM DISTRICT
                            INNER JOIN DISTRICT_REVENUE
                            ON DISTRICT.NCESID = DISTRICT_REVENUE.NCESID
                            INNER JOIN COUNTY
                            ON COUNTY.STATE_NUMBER   = DISTRICT.STATENUM
                            AND COUNTY.COUNTY_NUMBER = DISTRICT.CONUM
                            INNER JOIN STATE
                            ON STATE.STATE_NUMBER = COUNTY.STATE_NUMBER
                            INNER JOIN DISTRICT_SPENDING_PER_PUPIL
                            ON DISTRICT.NCESID = DISTRICT_SPENDING_PER_PUPIL.NCESID
                            GROUP BY STATE.STATE_NAME,
                            COUNTY.COUNTY_NAME,
                            DISTRICT.NAME)
                            WHERE Sum_TOTAL_SPENDING > #{params[:spending].to_i}"
          @spendings = ActiveRecord::Base.connection.exec_query(spending_pupil)
          @spendings.to_hash
        end
    end

    def advanced_query
        redirect_to listings_path
    end
end
