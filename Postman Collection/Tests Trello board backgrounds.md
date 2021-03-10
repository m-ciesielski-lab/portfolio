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

### `POST` /boards/

Time to add a first request. As we know from HTTP and Trello docs to create a new board, we have to use `POST` method to send data to `/boards/` endpoint. We also enter information as title and background in request data.

![Type date](https://raw.githubusercontent.com/m-ciesielski-lab/portfolio/master/Postman%20Collection/post%20-%20create%20a%20new%20board.gif)

Now We need to add URL address. In Trello documentation We can see a few examples:

> Example: 'https://api.trello.com/1/boards/?key={yourKey}&token={yourToken}'

![Type date](https://raw.githubusercontent.com/m-ciesielski-lab/portfolio/master/Postman%20Collection/URL.gif)

Something going on. In query details, we see two parameters. Key and token. As we known from docs to create board Trello API required parameters as key, token and name.

```
3. Need to pay attention to required query parameters:
    * key
    * token
    * name
    * prefs_background (optional, but in this case needed) 
```

Let's complete key and token with valid data. We also add URL address as page in variable settings.

```

https://api.trello.com/1/     page
key                           key (yourKey)
token                         token (yourToken)
```



 >  :mag: Source: https://learning.postman.com/docs/sending-requests/variables/#understanding-variables

Let's try to use our variables in practice
From this article, we know that to use our variables, we need to use double curly brackets. And put inside our variable. 

For example:

This `https://api.trello.com/1/` is our value for `page` variable. Now we know, to use double curly brackets. So for now, our endpoint should look like this: `{{page}}`

But this is only a part from our endpoint. We need to add `key` and `token`:

`yourKey` is a value for `key` variable

`yourToken` is a value for `token` variable

Without variables:

> https://api.trello.com/1/boards/?key={yourKey}&token={yourToken}

With variables:

> {{page}}boards/?key={{key}}&token={{token}}

To complete full endpoint address, we need to add 2 more parameters. Board name and background color. 

`Test board` is a value for `name` parameter

And for background color we need to use `prefs_background` parameter from Trello docs. We also know:

```
Default: blue

Valid values: blue, orange, green, red, purple, pink, lime, sky, grey

```

To change background let's pick up different color that default ( in this case blue). I choose green.

`green` is a value for `prefs_background` parameter

![Type date](https://raw.githubusercontent.com/m-ciesielski-lab/portfolio/master/Postman%20Collection/POST%20Full%20URL.gif)

Well, looks like all fields are filled. Of course this is really basic concept, but for this example should be enough to check Postman potential in API testing.
Let's send our `POST` /boards request!

![Response display](https://raw.githubusercontent.com/m-ciesielski-lab/portfolio/master/Postman%20Collection/POST-request-results.gif)

And We have response from Trello API!

```json

{
    "id": "6033e7cc1c7ae042d07e487e",
    "name": "Test Board",
    "desc": "",
    "descData": null,
    "closed": false,
    "idOrganization": "5fac8b7e9daf3772c7d5d023",
    "idEnterprise": null,
    "pinned": false,
    "url": "https://trello.com/b/JttAQVyj/test-board",
    "shortUrl": "https://trello.com/b/JttAQVyj",
    "prefs": {
        "permissionLevel": "private",
        "hideVotes": false,
        "voting": "disabled",
        "comments": "members",
        "invitations": "members",
        "selfJoin": true,
        "cardCovers": true,
        "isTemplate": false,
        "cardAging": "regular",
        "calendarFeedEnabled": false,
        "background": "green",
        "backgroundImage": null,
        "backgroundImageScaled": null,
        "backgroundTile": false,
        "backgroundBrightness": "dark",
        "backgroundColor": "#519839",
        "backgroundBottomColor": "#519839",
        "backgroundTopColor": "#519839",
        "canBePublic": true,
        "canBeEnterprise": true,
        "canBeOrg": true,
        "canBePrivate": true,
        "canInvite": true
    },
    "labelNames": {
        "green": "",
        "yellow": "",
        "orange": "",
        "red": "",
        "purple": "",
        "blue": "",
        "sky": "",
        "lime": "",
        "pink": "",
        "black": ""
    },
    "limits": {}
}
```

A quick look at response in json, received from the Trello app. We've listed all of the query parameters, but we still need to check two items.
The name of the board and the color of the board. 

Let's see:

In json we have key like `name` and the value is `Test Board`. So this is correct. 

```json

    "name": "Test Board",

```

Next is background board. In json we have key like  `prefs`. And in this key we have another `object`. What we looking for is background.  So path in json to check background colour is `prefs.background`. And now we see: key: `background` value: `green`.

```json

"prefs": {
        "permissionLevel": "private",
        "hideVotes": false,
        "voting": "disabled",
        "comments": "members",
        "invitations": "members",
        "selfJoin": true,
        "cardCovers": true,
        "isTemplate": false,
        "cardAging": "regular",
        "calendarFeedEnabled": false,
        "background": "green",
 }      
```

It works! In the next part, we will use the `GET` method to retrieve data from the server.

![Type date](https://i.imgur.com/S0MjTvl.jpg)

##    Tests tab
##    Collection runner. Check the results
##    Run Newman and prepare report

