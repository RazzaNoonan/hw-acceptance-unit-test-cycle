Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # Ensure that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |title, director|
  movie = Movie.find_by(title: title)
  expect(movie.director).to eq(director)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then(/^I should not see the link "([^"]*)"$/) do |link_text|
  expect(page).to have_no_link(link_text), "Expected not to see the link '#{link_text}', but it was found."
end

Then(/^I should explicitly see "'([^"]*)" has no director info"$/) do |movie_title|
  expect(page).to have_text("#{movie_title} has no director info")
end




Then("I should see {string}") do |text|
  expect(page).to have_text(text)
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end
