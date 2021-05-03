Rails.application.routes.draw do
  # Walks
  get 'walks/autocomplete', to: 'walks#autocomplete'
  get 'walks/calculate_distance', to: 'walks#calculate_distance'
  resources :walks, only: [:create]

  # Statistics
  get 'statistics/walks_weekly_summary', to: 'statistics#walks_weekly_summary'
  get 'statistics/walks_monthly_summary', to: 'statistics#walks_monthly_summary'
end
