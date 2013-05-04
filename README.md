## Introduction

This is a JSON API for the DND, allowing you to quickly and easily integrate into your application.

## Usage

It's easy to perform a full-text search on the database:

```bash
λ helios dnd-api → λ git master → curl dnd.hackdartmouth.org/cormen
[
  {
    "score": 2.3666666666666667,
    "obj": {
      "uid": "d32210h",
      "name": "Thomas H. Cormen",
      "surname": "Cormen",
      "firstname": "Thomas",
      "nickname": "tom thc bbq",
      "email": "Thomas.H.Cormen@Dartmouth.EDU",
      "website": "http://www.cs.dartmouth.edu/~thc/",
      "phone": "603-646-2417",
      "hinman": "HB 6211",
      "department": "Computer Science",
      "affiliations": [
        "Faculty"
      ],
      "_id": "518448be91c9b9de67004105"
    }
  }
]
```

You can also query specific fields:

```bash
λ helios dnd-api → λ git master → curl dnd.hackdartmouth.org/\?uid=d34023k
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

Note that if you don't specify any parameters, you'll get the full dataset.

## Installation

If you want to run this on your local machine, you'll need Node.js and MongoDB.

```bash
$ sudo npm install -g
$ coffee import.coffee
$ node server
$ curl localhost:4000
```

