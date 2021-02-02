#  :pushpin: Create and test boards in Trello app

##   Read Trello documentation about how to create, read, update and delete boards

---


:one: We want to create a new board. So take a look on `Create a Board tab`.

Open URL - https://developer.atlassian.com/cloud/trello/rest/api-group-boards/


![Type date](https://i.imgur.com/YgFHKi1.jpg)

---
In this case, we also want to check, how can we add or change a board background. Scroll down to find a `specific query parameter`

![Type date](https://i.imgur.com/HwWx5K5.jpg)


Nice! Now we have information, we can use.

1. Use `POST` request method from HTTP to add new data 
2. Our endpoint should include `/1/boards/` to send a request
3. Need to pay attention to required query parameters:
    * key
    * token
    * name
    * (optional, but in this case needed) prefs_background
    
---

:two: After created new board with needed parameters, we want to retrieve data. To check if everything is as we wanted.

Open URL - https://developer.atlassian.com/cloud/trello/rest/api-group-boards/


![Type date](https://i.imgur.com/0EOLVPc.jpg)


1. Use `GET` request method from HTTP to retrieve new data 
2. Our endpoint should include `/1/boards/{id}` to send a request
3. Need to pay attention to required query parameters:
   * key
   * token
   * id (it will be a board id)

---

:three: Now it's time to update our board. Let's change background color and board name for example.

Open URL - https://developer.atlassian.com/cloud/trello/rest/api-group-boards/


![Type date](https://i.imgur.com/aRHQ5It.jpg)


1. Use `PUT` request method from HTTP to modify a singular resource which is already a part of resource. In other words, to change/update existing resource. 
2. Our endpoint should include `/1/boards/{id}` to send a request
3. Need to pay attention to required query parameters:
   * key
   * token
   * id (it will be a board id)
   * (optional) name
   * (optional) prefs/background
  
---

:four: In the end, we have to clean up and delete all resources

Open URL - https://developer.atlassian.com/cloud/trello/rest/api-group-boards/

![Type date](https://i.imgur.com/aIuOhrJ.jpg)

---

1. Use `DELETE` request method from HTTP to delete the specified resource. In this case, is our board. All of it
2. Our endpoint should include `/1/boards/{id}` to send a request 
3. Need to pay attention to required query parameters:
   * key
   * token
   * id (it will be a board id)
   
---

##    Collections, requests, variables and query parameters

--- 
In this part (after read docs) we finally run Postman. Start from get key and token, to get access to our user Trello data. After this we can read and write items in application. In simple words: Make requests (`POST, GET, PUT,DELETE`), create variables, query parameters and puts into collection. We can start working! Let's go!

---

Open URL https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/

> Key and token is a crucial thing to go forward. When you get a API key and token, you can use them to start making requests.


Open Postman and create new collection :point_down:

![Type date](https://raw.githubusercontent.com/m-ciesielski-lab/portfolio/master/Postman%20Collection/title-trello-collection(1).gif)

Title of collection will be ```Check background and board title in Trello app```. Collection groups many requests in very specific order. Of course collection with one request it doesn't make sense. But we need to look in wide open mind. After all requests we want, collection runner helps and speed up our tests.

### `POST` /1/boards/

##    Tests tab
##    Collection runner. Check the results
##    Run Newman and prepare report

