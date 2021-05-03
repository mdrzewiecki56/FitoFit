class StatisticsController < ApplicationController
  def walks_weekly_summary
    summary = StatisticsServices::WalkSummary.new.weekly_summary(DateTime.strptime(statistics_params[:date], "%m/%d/%Y"))
    @total = summary[:walks].count
    @walks = Kaminari.paginate_array(summary[:walks]).page(statistics_params[:page]).per(statistics_params[:per_page])
    @sum = summary[:distances_sum]
    render 'statistics/walk_summary'
  end

  def walks_monthly_summary
    summary = StatisticsServices::WalkSummary.new.monthly_summary(Date.strptime(statistics_params[:date], "%m/%d/%Y"))
    @total = summary[:walks].count
    @walks = summary[:walks]
    @sum = summary[:distances_sum]
    render 'statistics/walk_summary'
  end

  def statistics_params
    params.permit(:per_page, :page, :date)
  end
end