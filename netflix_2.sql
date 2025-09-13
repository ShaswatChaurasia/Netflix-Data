select*
from netflix_1;

7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select*
from netflix_1;
select *
from netflix_1
where director like '%Rajiv Chilaka%';
8. List all TV shows with more than 5 seasons
select *
from netflix_1
where type='TV Show' and split_part(duration,' ',1)::INT>5;
9. Count the number of content items in each genre
select listed_in,show_id,
unnest(string_to_array(listed_in,','))
from netflix_1;

select 
unnest(string_to_array(listed_in,',')) as genre,
count(show_id)
from netflix_1
group by genre;

10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
select* from netflix_1
where country='India';

select extract(year from to_date(date_added,'Month DD, YYYY')) as date,
count(*) 
from netflix_1
where country='India'
group by 1;

select extract(year from to_date(date_added,'Month DD, YYYY')) as year,
count(*) as yearly_content,
round(count(*) :: numeric,count(*)/(select count(*) from netflix_1 where country= 'India')::numeric *100,2) as avg_content
from netflix_1
where country='India'
group by 1;



11. List all movies that are documentaries
select* from netflix_1;

select type,listed_in
from netflix_1
Where (type='Movie' and listed_in='Documentaries');


12. Find all content without a director
select* 
from netflix_1
where director is null;

13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select* 
from netflix_1
where casts ilike '%Salman Khan%' 
and
release_year >extract(year from current_date)-10;
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select 
--show_id,casts
unnest(string_to_array(casts,',')) as actors,
count(*) as total_content
from netflix_1
where country ilike '%india'
group by actors
order by 2 desc
limit 10;

15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

with new_table 
as
(select *,
case 
when 
description ilike '%kill%' or
description ilike '%voilence' then 'Bad_content'
else 'Good_content'
end category
from netflix_1
)
select category,
count(*) as total_content
from  new_table
group by 1;


