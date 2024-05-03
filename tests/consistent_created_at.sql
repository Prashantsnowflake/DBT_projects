select * from {{ref("fct_reviews")}} fct join {{ref("dim_listings_cleansed")}} lst
on fct.listing_id = lst.listing_id
and fct.review_date <= lst.created_at