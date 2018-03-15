Given(/^I am on the google shopping page$/) do
  visit('https://www.google.co.uk/shopping')
end

And(/^I search for "([^"]*)"$/) do |arg|
  fill_in 'q', with: arg
  page.find('#gbqfb').click
  sleep(1)
end

Then(/^I get "([^"]*)" results$/) do |arg|
  @page = GoogleShopping.new
  @page.verify_search(arg)
end

When(/^I click on up to £15$/) do
  find('span', :text => 'Up to £15').click
  sleep(2)
end

Then(/^None of the results are more that £15$/) do
  elements = all('span.price')
  prices = elements.map { |e| e.text.sub('£', '').to_i }
  prices.each do |price|
    if price > 15
      fail
    end
  end
end

When(/^I click on more$/) do
  find(:xpath, '//*[@id="hdtb-msb"]/div[1]/g-header-menu/a').click
  sleep(1)
end

And (/^I click on books$/) do
  @page.verify_books
end

Then(/^the results are all books$/) do
  search = find('div.hdtb-mitem.hdtb-msel.hdtb-imb')
  if search.text != 'Books'
    fail
  end
end

When(/^I click on Ocado$/) do
  find(:xpath, '//*[@id="leftnavc"]/div/div[4]/div/div[2]/div[2]/a').click
  sleep(1)
end

Then(/^the results are for Ocado$/) do
  @page.verify_seller_ocado('Ocado')
  sleep(1)
end

When(/^I click more$/) do
  find(:xpath, '//*[@id="leftnavc"]/div/div[4]/div/div[5]').click
  sleep(1)
end

And(/^I click on Eatbig$/) do
  find(:xpath, '//*[@id="leftnavc"]/div/div[3]/div/div[2]/div[1]/a').click
  sleep(1)
end

Then(/^the results are for Eatbig$/) do
  @page.verify_seller_eatbig('Eatbig')
  sleep(1)
end

When(/^I enter £20$/) do
  within find(:xpath, '//*[@id="leftnavc"]/div/div[3]/div/div[2]/form/div[1]/label/input') do
    input = find(:xpath, '//*[@name="lower"]')
    input.send_keys("20")
  end
  sleep(1)
end

And(/^I enter £30$/) do
  within find(:xpath, '//*[@id="leftnavc"]/div/div[3]/div/div[2]/form/div[2]/label/input') do
    input = find(:xpath, '//*[@name="upper"]')
    input.send_keys("30")
  end
  sleep(1)
end

And(/^I click go$/) do
  find(:xpath, '//*[@id="leftnavc"]/div/div[3]/div/div[2]/form/button').click
  sleep(1)
end

Then(/^the results are all between £20 and £30$/) do
  @page.verify_range()
  sleep(2)
end
