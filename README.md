Introduction
------------

This is a JSON API for the DND, allowing you to quickly and easily
integrate the Dartmouth network into your application.

Usage
-----

It's easy to perform a full-text search on the database:

```bash
$ curl dnd.hackdartmouth.org/zd
[
  {
    "uid": "d34023k",
    "name": "Zachary J. Denton",
    "surname": "Denton",
    "firstname": "Zachary",
    "nickname": "zach zd zjd",
    "email": "Zachary.J.Denton.15@Dartmouth.edu",
    "website": "http://zacharydenton.com",
    "phone": null,
    "hinman": "0973",
    "department": "'15",
    "affiliations": [
      "Student",
      "Alum"
    ],
    "_id": "518448be91c9b9de67004729"
  }
]
```

You can also query specific fields:

```bash
$ curl dnd.hackdartmouth.org?department=Philosophy
[
  {
    "uid": "d15580d",
    "name": "Adina L. Roskies",
    "surname": "Roskies",
    "firstname": "Adina",
    "nickname": "adina",
    "email": "Adina.L.Roskies@Dartmouth.edu",
    "website": "www.dartmouth.edu/~adinar/",
    "phone": "603-646-2112",
    "hinman": "HB 6035",
    "department": "Philosophy",
    "affiliations": [
      "Faculty"
    ],
    "_id": "518448bd91c9b9de67000005"
  },
  {
    "uid": "d40053s",
    "name": "Alan Kim",
    "surname": "Kim",
    "firstname": "Alan",
    "nickname": null,
    "email": "Alan.Kim@Dartmouth.edu",
    "website": "http://www.dartmouth.edu/~phil/faculty/kim.html",
    "phone": "63807",
    "hinman": "HB 6035",
    "department": "Philosophy",
    "affiliations": [
      "Faculty"
    ],
    "_id": "518448bd91c9b9de670001be"
  },
  {
    "uid": "d41137j",
    "name": "Alice S. Walden",
    "surname": "Walden",
    "firstname": "Alice",
    "nickname": null,
    "email": "Alice.S.Walden@Dartmouth.edu",
    "website": null,
    "phone": null,
    "hinman": "HB 6035",
    "department": "Philosophy",
    "affiliations": [
      "Faculty"
    ],
    "_id": "518448bd91c9b9de67000251"
  },
  [...],
  {
    "uid": "f000cw0",
    "name": "Tillmann Vierkant",
    "surname": "Vierkant",
    "firstname": "Tillmann",
    "nickname": null,
    "email": "Tillmann.Vierkant@Dartmouth.edu",
    "website": null,
    "phone": null,
    "hinman": "HB 6035",
    "department": "Philosophy",
    "affiliations": [
      "Faculty",
      "Alum"
    ],
    "_id": "518448be91c9b9de670041ec"
  }
]
```

Note that if you don't specify any parameters, you'll get the entire dataset.

Installation
------------

If you want to run this on your local machine, you'll need Node.js and MongoDB.

```bash
$ sudo npm install -g
$ coffee import.coffee
$ node server
$ curl localhost:4000
```

