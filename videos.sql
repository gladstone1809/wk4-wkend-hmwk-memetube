drop database memetube;
create database memetube;

drop table videos;
create table videos (
  youtube_id varchar(500) ,
  title varchar(500),
  description varchar(1000),
  genre varchar(200)
);


