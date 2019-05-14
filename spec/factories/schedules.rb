FactoryBot.define do
  factory :schedule do
    start_time { "2019-05-12 16:58:39" }
    end_time { "2019-05-12 16:58:39" }
    shift_hour { 1.5 }
    employee { nil }
  end
end
