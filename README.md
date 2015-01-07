A minimal Search Experiement on Postgresql
==========================================

This is a search speed experiment on a PG DB that contains 1.5m rows.

I have used [Faker](https://github.com/stympy/faker) to generate the 1.5m rows.. Well It took almost 8 hours to fill in.

Currently no gem for querying, and below is the different variants of test done.

* No Index, No Gem
* With PG_Search gem, No Index
* With trigram approach, No Index
* trigram and full text search combined, with index (needed an extra table of unique words)
* trigram search with gin index
* trigram search with gist index

As of now, with the above tests the trigram with gist index is amazingly faster than any others, which took 307ms to get the result for which the gin index took an awful 6780ms.