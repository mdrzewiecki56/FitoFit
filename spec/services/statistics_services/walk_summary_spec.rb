require 'rails_helper'

RSpec.describe StatisticsServices::WalkSummary, type: :service do
  describe 'weekly_summary' do
    it 'generates summary for simple dataset' do
      walk1 = build(:walk, created_at: DateTime.new(2021, 5, 3))
      walk2 = build(:walk, created_at: DateTime.new(2021, 5, 4))
      # Sunday of previous week shouldn't be included in stats
      walk3 = build(:walk, created_at: DateTime.new(2021, 5, 2))
      [walk1, walk2, walk3].each(&:save)
      expect(StatisticsServices::WalkSummary.new.weekly_summary(DateTime.new(2021, 5, 3))).to be_eql({:walks=>
                [{:start_address=>"Plac Europejski 2, Warszawa, Polska",
                  :end_address=>"Poznańska 7, Warszawa, Polska",
                  :distance=>2.17},
                 {:start_address=>"Plac Europejski 2, Warszawa, Polska",
                  :end_address=>"Poznańska 7, Warszawa, Polska",
                  :distance=>2.17}],
              :distances_sum=>4.34}
      )
    end
    it 'does include walks created at almost next week (around midnight)' do
      # Should be included
      walk1 = build(:walk, created_at: DateTime.new(2021, 5, 3, 23, 50, 50))
      # Shouldn't be included - sunday night before selected week
      walk2 = build(:walk, created_at: DateTime.new(2021, 5, 2, 22, 00, 00))
      [walk1, walk2].each(&:save)
      expect(StatisticsServices::WalkSummary.new.weekly_summary(DateTime.new(2021, 5, 3)))
        .to(be_eql({:walks=>
                      [{:start_address=>"Plac Europejski 2, Warszawa, Polska",
                        :end_address=>"Poznańska 7, Warszawa, Polska",
                        :distance=>2.17}
                      ],
                    :distances_sum=>2.17}))
    end
  end
  describe 'monthly_summary' do
    it 'generates summary for simple dataset' do
      walk0 = build(:walk, created_at: DateTime.new(2021, 5, 3))
      walk1 = build(:walk, created_at: DateTime.new(2021, 5, 3))
      walk2 = build(:walk, created_at: DateTime.new(2021, 5, 4))
      # Sunday of previous week shouldn't be included in stats
      walk3 = build(:walk, created_at: DateTime.new(2021, 5, 2))
      [walk0, walk1, walk2, walk3].each(&:save)
      expect(StatisticsServices::WalkSummary.new.monthly_summary(DateTime.new(2021,5,29))).to(
        be_eql({:walks=>{"2. May"=>2.17, "3. May"=>4.34, "4. May"=>2.17},:distances_sum=>8.68}))
    end
    it 'does include walks created at almost next week (around midnight)' do
      # Should be included
      walk1 = build(:walk, created_at: DateTime.new(2021, 5, 31, 23, 50, 50))
      # Shouldn't be included - sunday night before selected month
      walk2 = build(:walk, created_at: DateTime.new(2021, 4, 30, 22, 00, 00))
      [walk1, walk2].each(&:save)
      expect(StatisticsServices::WalkSummary
               .new.monthly_summary(DateTime.new(2021, 5, 30))).to(
                be_eql({:walks=>{"31. May"=>2.17}, :distances_sum=>2.17}))

    end
  end
end