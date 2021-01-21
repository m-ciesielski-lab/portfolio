#  :pushpin: Create and tests board backgrounds in Trello app

###   :one: Read Trello documentation about how to create, read, update and delete boards

---
Open URL - https://developer.atlassian.com/cloud/trello/rest/api-group-boards/

We want to create a new board. So take a look on `Create a Board tab`.

![Type date](https://i.imgur.com/YgFHKi1.jpg)

---
In this case, we also want to check, how can we add or change a board background. Scroll down to find a `specific query parameter`

![Type date](https://i.imgur.com/HwWx5K5.jpg)

---

Nice! Now we have information, we can use.

1. Use `POST` request method from HTTP to create a resource 
2. Our endpoint should include `/1/boards/` to send a request
3. Need to pay attention to required query parameters:
    * key
    * token
    * name
    * prefs_background

###   :two: Open Postman and create 4 requests, add variables and query parameters 
###   :three: Write some tests to each request
###   :four: Create collection and run collection runner. Check the results
###   :five: Run Newman and create Test report

