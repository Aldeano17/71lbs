## Objective
- Scrape all houses with 3BR 2Ba posted on craigslist
- Run with `ruby craigslistScraper.rb`

## Aproach
- With the use of the gems `nokogiri` and `httparty` parsed the web HTML.
- With `byebug` facilitate cheking the code at the same time i was working to make sure not to have bugs 
- To make sure the program run the pagination on all the pages first scraped how many post per page and which one was the total of posts then devide the total by the amount of post per page.
- To get the next page url of  and extract all info need it from each house I used a while loop that will parse over the page and stract the info of all houses on that page one by one and saved into and array of hash. Then from the button for pagination (next) will stract the link to move on to the next page. And the same process will reapeat till page == total pages
- After all the process is done then the gem `csv` makes sure to stract all the info and passed to a csv file to have it nice and organice.

## Run
- Clone repository using `git clone https://github.com/Aldeano17/71lbs.git`
- Then access to the file `cd 71lbs/craigslistScraper`
- `bundle install` to install all gems need it
- Finally to run scraper type `ruby craigslistScraper.rb`