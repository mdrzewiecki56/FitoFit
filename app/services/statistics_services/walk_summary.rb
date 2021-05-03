module StatisticsServices
  class WalkSummary
    def initialize
    end

    def weekly_summary(date = DateTime.now)
      walks = Walk.where(created_at:  date.beginning_of_week..date.end_of_week)
      sum = walks.map(&:distance).inject(0, &:+).round(2)
      {walks: walks.map{|w| {start_address: w.start_address, end_address: w.end_address, distance: w.distance}}, distances_sum: sum}
    end

    def monthly_summary(date = DateTime.now)
      walks = Walk.where(created_at:  date.beginning_of_month..date.end_of_month).group_by_day(:created_at).sum(:distance)
      walks.transform_keys!{|date| "#{date.day}. #{date.strftime("%B")}"}
      walks.transform_values!{|distance| distance.round(2)}
      {walks: walks, distances_sum: walks.values.map.inject(0, &:+).round(2)}
    end
  end
end