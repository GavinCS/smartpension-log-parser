
## Client Specification
Write a script that receives a log file as an argument  
Returns  
- an ordered list (desc) of views per page  
- an ordered list (desc) of unique views per page    
  
## Assumptions  
- Log file will always be in the format ```page ip```  
- ```page ip``` format is always slit by only 1 space  
  
## Approach  
In order to sort and group the pages in the log into the required order and format I did the following.  
- As access log files can become fairly large, reading the whole file into memory is not a good idea,  
so I read and processed the file line by line.  
- while reading each line I split it up into a page/ip array, I could then use the page as a hash key along with the count of pages.  
- For unique page views, I created a "unique_keys" array to which I added a unique-key (page-ip combo) each time I added the page for the first time.  
- If the unique key already existed, I would skip adding another page view.  
  
In order to make the code more readable and testable, as well as following OOP.  
I broke the app down into 3 classes.  
- **Parser**: using the commander gem, this class setup and accepts a command "```print_page_views```" and an option "```--filename```" for our log file  
this calls the LogReader class for processing, and then prints the results to the screen.  
  
- **LogReader**: initialize method accepts our filename as a parameter and ensures that the file exists.  
The LogReader class is responsible for reading the file line by line, and processing the lines via the PageViews class.  
Once processing is completed, the page views are sorted and returned for printing.  
  
- **PageViews**: This class has our 2 page view attributes to which we add our page views / unique page views  
It has methods to add, sort and print. Print is supported with an ASCII table formatter, via the terminal-table gem  
  
**Expected output:**

```
   +--------------+--------+
   |      Page views       |
   +--------------+--------+
   | Page         | Visits |
   +--------------+--------+
   | /about/2     |     90 |
   | /contact     |     89 |
   | /index       |     82 |
   | /about       |     81 |
   | /help_page/1 |     80 |
   | /home        |     78 |
   +--------------+--------+
   
   +--------------+--------+
   |   Unique page views   |
   +--------------+--------+
   | Page         | Visits |
   +--------------+--------+
   | /index       |     23 |
   | /home        |     23 |
   | /help_page/1 |     23 |
   | /contact     |     23 |
   | /about/2     |     22 |
   | /about       |     21 |
   +--------------+--------+
```
 
