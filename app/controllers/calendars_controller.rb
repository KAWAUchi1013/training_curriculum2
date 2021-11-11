class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    @todays_date = Date.today #今日の月・日・曜日などの情報が入っている
 
    @week_days = []
  

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      wday_num = Date.today.wday
      #もし曜日数が７より大きい数であれば、wday_numから−７をして曜日数を調整する
      if 7 <= wday_num 
        wday_num = wday_num -7
      end

      days = { :month => (@todays_date + x).month, :date => (@todays_date + x).day, :plans => today_plans, :wday =>wdays[(@todays_date + x).wday]}
      # days = { :month => (@todays_date + x).month, :date => (@todays_date + x).day, :plans => today_plans, :wday => wdays[(@todays_date + x).wday]}

      @week_days.push(days)
    end
  end
end

