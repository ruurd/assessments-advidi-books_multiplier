#Advidi trial#
##Google Books API research##
- RESTfull
- default 10 results per page, max 40 per page.
- ‘ruby on rails’ yields 481 results say 500 that means it is possible to retrieve the list in 13 requests meaning you can query Google 5 times a minute with some room to spare. 

##Challenges##
We need to ‘multiply’ the possible number of requests to Google from 100 per minute to 5000 per second. This means we need to hold on to an intermediary result and also we need to be able to process requests form more than one host at the same time. That last challenge means that we need to hold on to the intermediary and we need to be able to distribute the intermediary result to other hosts. 

Retriever => store => Replicators => store => Distributor

## Solution ##
It would be nice if we could recreate the books API in RAILS. That way we could forward a request if it was not in cache yet otherwise serve it up from the cache. This would make it possible to chain a single app together whereby one instance actually queries the real google books api when possible and necessary... In the simplest case we can suffice with a single instance that queries Google when needed. If we add a layer we let the added layer query the first layer when needed. We even can add yet another layer if necessary. 
The design then sort of looks like a recursive load balancer.



