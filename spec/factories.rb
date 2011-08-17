# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.first_name            "Mozy"
  user.last_name             "Kung"
  user.email                 "mozy.kung@apb.org"
  user.password              "000000"
  user.password_confirmation "000000"
end

Factory.sequence :email do |n|
  "person-#{n}@apb.org"
end
