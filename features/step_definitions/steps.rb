include ActionView::Helpers::TextHelper


Given /^I'm in the homepage$/ do 
  visit root_path
end

Given /^there is a guide called "(.*?)" and email "(.*?)"$/ do |arg1, arg2|
  User.make! :first_name => arg1.split[0], :last_name => arg1.split[1], :email => arg2
end

Given /^there is a review for this activity written by "(.*?)" (\d+) days ago$/ do |arg1, arg2|
  Review.make! :user => User.make!(:first_name => arg1), :created_at => Time.now - arg2.to_i.days, :activity => @activity
end

Given /^I select "(.*?)" as the neighborhood filter$/ do |arg1|
  select(arg1, :from => "by_neighborhood")
end

Given /^there is an event for this activity$/ do
  @event = Event.make! :activity => @activity
end

Given /^I'm logged in$/ do
  visit "/auth/facebook"
end

Then /^the (\d+)[st|nd|rd]+ review should be of "(.*?)"$/ do |arg1, arg2|
  page.should have_css(".activity_reviews_list li.review:nth-child(#{arg1}) .review_user", :text => arg2)
end

Then /^the (\d+)[st|nd|rd]+ most recent activity should be "(.*?)"$/ do |arg1, arg2|
  page.should have_css(".recent_activities li.activity:nth-child(#{arg1})", :text => truncate(arg2, :length => 35))
end

Then /^the (\d+)[st|nd|rd]+ most popular neighborhood should be "(.*?)"$/ do |arg1, arg2|
  page.should have_css(".popular_neighborhoods li.neighborhood:nth-child(#{arg1})", :text => truncate(arg2, :length => 35))
end

Then /^the (\d+)[st|nd|rd]+ activity found in the neighborhood should be "(.*?)"$/ do |arg1, arg2|
  page.should have_css(".search_result li.activity:nth-child(#{arg1})", :text => arg2)
end

Then /^the (\d+)[st|nd|rd]+ activity found nearby should be "(.*?)"$/ do |arg1, arg2|
  page.should have_css(".nearby_result li.activity:nth-child(#{arg1})", :text => arg2)
end

Then /^I should see the participation form$/ do
  page.should have_css("form.new_participation")
end

Then /^I should see the awaiting moderation warning$/ do
  page.should have_css(".alert-success")
end

Given /^I set the activity location in "(.*?)"$/ do |arg1|
  fill_in "Local de Encontro", :with => arg1
  page.execute_script("$('#activity_latitude').val('-22.998634')")
  page.execute_script("$('#activity_longitude').val('-43.269485')")
end

Given /^I attach an image to "(.*?)"$/ do |arg1|
  attach_file arg1, File.dirname(__FILE__) + "/../support/activity.jpg"
end

Given /^I fill "(.*?)" with next week$/ do |arg1|
  fill_in(arg1, :with => (Time.now + 1.week).strftime("%d/%m/%Y %H:%M"))
end

Then /^I should see the created event message$/ do
  page.should have_css(".alert-success")
end

Given /^I select a date to schedule$/ do
  choose("participation[event_id]")
end

Then /^the Moip checkout button should be enable$/ do
  page.should_not have_css(".moip_checkout[disabled='disabled']")
end

Given /^I scheduled (\d+) activities$/ do |arg1|
  arg1.to_i.times { Participation.make! :user => User.find_by_email("nicolas@engage.is") }
end

Then /^I should see (\d+) schedules$/ do |arg1|
  page.should have_selector(".participation", :count => arg1.to_i)
end

Given /^there is (\d+) attendee in this event$/ do |arg1|
  Participation.make! :event => @event, :user => User.make!, :moip_status => "4"
end

Then /^the system should send (\d+) emails$/ do |arg1|
  ActionMailer::Base.deliveries.should have(arg1.to_i).emails
end

Then /^I should see my activity$/ do
  page.should have_css("li.activity")
end

Then /^the total amount should be R\$ (\d+)$/ do |arg1|
  page.should have_css("#moip_valor", :value => "#{arg1}00")
end

Given /^there is a booking of "(.*?)" to that event$/ do |arg1|
  Participation.make! :event => @event, :user => User.make!(:first_name => arg1), :moip_status => "4"
end

Then /^I should see "(.*?)" in the attendees list$/ do |arg1|
  page.should have_css(".booking", :text => arg1)
end

Then /^I should not see the activity tab$/ do
  page.should_not have_css(".activity_tab")
end

Then(/^show me the page$/)                      { save_and_open_page }
When(/^I go to "(.*?)"$/)                       { |arg1| visit path(arg1) }
Then(/^the first activity should be "(.*?)"$/)  { |arg1| page.should have_css('ol.activities li:first-child', :text => arg1) }
Then(/^I should see "(.*?)"$/)                  { |arg1| page.should have_content(arg1) }
Then(/^I should not see "(.*?)"$/)              { |arg1| page.should_not have_content(arg1) }
When(/^I click "(.*?)"$/)                       { |arg1| click_link link(arg1) }
Then(/^I should see "(.*?)" component$/)        { |arg1| page.should have_css(component(arg1)) }
Then(/^I should not see "(.*?)" component$/)    { |arg1| page.should_not have_css(component(arg1)) }
When(/^I press "(.*?)"$/)                       { |arg1| click_button arg1 }
Given(/^I fill "(.*?)" with "(.*?)"$/)          { |arg1, arg2| fill_in(arg1, :with => arg2) }
Then(/^I should be in "(.*?)"$/)                { |arg1| current_path_info.should be_== path(arg1) }
Given(/^I select "(.*?)" as "(.*?)"$/)          { |arg1, arg2| select(arg1, :from => arg2) }
