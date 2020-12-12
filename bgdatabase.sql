create table account (
	account_id int not null,
	username varchar(20) not null,
	password varchar(20) not null,
	email varchar(100) not null,
	firstName varchar(50) not null,
	/*Just long enough to fit "Katz-Braunschweig" in case someone is named as such*/
	lastName varchar(17) not null, 
	primary key (account_id),
	unique (username)
);

create table boardgame (
	boardgame_id int not null,
	name varchar(100) not null,
	minAge smallint not null,
	minPlayers smallint not null
		check (min_players >= 1),
	maxPlayers smallint not null,
	avgTime int not null /*in minutes*/
		check (avgTime >= 0),
	primary key (boardgame_id),
	unique (name)
);

create table category (
	category_id int not null,
	name varchar(20) not null,
	description varchar(500),
	primary key (category_id),
	unique (name)
);

create table in_category (
	category_id int not null,
	boardgame_id int not null,
	primary key (category_id, boardgame_id),
	foreign key (category_id) references category (category_id),
	foreign key (boardgame_id) references boardgame (boardgame_id)
);

create table designer (
	designer_id int not null,
	name varchar(50) not null,
	description varchar(500),
	primary key (designer_id)
);

create table designed_by (
	designer_id int not null,
	boardgame_id int not null,
	primary key (designer_id, boardgame_id),
	foreign key (designer_id) references designer (designer_id),
	foreign key (boardgame_id) references boardgame (boardgame_id)
);

create table review (
	review_id int not null,
	account_id int,
	boardgame_id int not null,
	dateMade datetime 
		default NOW(),
	stars smallint not null
  		check (stars >= 1 and stars <= 10),
	reviewMade varchar(2500),
	primary key (review_id, boardgame_id),
	foreign key (account_id) references account (account_id)
		on update cascade
		on delete set null, /*Deleting an account will not remove the review*/
	foreign key (boardgame_id) references boardgame (boardgame_id)
		on update cascade
		on delete cascade
);

create table wishlist (
	wishlist_id int not null,
  	account_id int not null,
  	boardgame_id int not null,
  	dateAdded datetime 
		default NOW(),
  	primary key (wishlist_id, account_id),
  	foreign key (account_id) references account (account_id)
  		on update cascade
  		on delete cascade,
  	foreign key (boardgame_id) references boardgame (boardgame_id)
  		on update cascade
  		on delete cascade
);

create table favorites (
  	favorite_id int not null,
  	account_id int not null,
  	boardgame_id int not null,
  	primary key (favorite_id, account_id),
  	foreign key (account_id) references account (account_id)
  		on update cascade
  		on delete cascade,
  	foreign key (boardgame_id) references boardgame (boardgame_id)
  		on update cascade
		on delete cascade
);

/*===========================
 Example data to be inserted
===========================*/
/*===== Account Data =====*/
insert into account (account_id, username, password, email, firstName, lastName)
values (3213, "hurminL", "notmypassword", "hl3213@nyu.edu", "Herman", "Lin");
insert into account (account_id, username, password, email, firstName, lastName)
values (1010, "notARob0t", "qa$$w0rd", "humanEmail@mail.gov", "Rob", "Boss");

/*===== Boardgame Data =====*/
insert into boardgame (boardgame_id, name, minAge, minPlayers, maxPlayers, avgTime)
values (21, "Catan", 10, 3, 4, 90);
insert into boardgame (boardgame_id, name, minAge, minPlayers, maxPlayers, avgTime)
values (34, "Terraforming Mars", 12, 1, 5, 120);
insert into boardgame (boardgame_id, name, minAge, minPlayers, maxPlayers, avgTime)
values (55, "Forbidden Desert", 10, 2, 5, 45);
insert into boardgame (boardgame_id, name, minAge, minPlayers, maxPlayers, avgTime)
values (89, "War of the Ring: Second Edition", 13, 2, 4, 165);
insert into boardgame (boardgame_id, name, minAge, minPlayers, maxPlayers, avgTime)
values (144, "Scythe", 14, 1, 5, 100);

/*===== Category Data =====*/
insert into category (category_id, name, description)
values (1, "Adventure",
"Adventure games often have themes of heroism, exploration, and puzzle-solving. The storyline behind such games often have fantastical elements, and involve the characters in some sort of quest.");
insert into category (category_id, name, description)
values (2, "Economic", 
"Economic games encourage players to develop and manage a system of production, distribution, trade, and/or consumption of goods. The games usually simulate a market in some way. The term is often used interchangeably with resource management games.");
insert into category (category_id, name, description)
values (3, "Fantasy", 
"Fantasy games are those that have themes and scenarios that exist in a fictional world. It is a genre that uses magic and other supernatural forms as a primary element of plot, theme, and/or setting. Fantasy is generally distinguished from science fiction and horror by the expectation that it steers clear of scientific and macabre themes, respectively, though there can be a great deal of overlap between the three.");
insert into category (category_id, name, description) /*Example category with no boardgame associated*/
values (4, "Puzzle",
"Puzzle games are those in which the players are trying to solve a puzzle. Many Puzzle games require players to use problem solving, pattern recognition, organization and/or sequencing to reach their objectives.");
insert into category (category_id, name, description)
values (5, "Science-Fiction",
"Science Fiction games often have themes relating to imagined possibilities in the sciences. Such games need not be futuristic; they can be based on an alternative past. (For example, the writings of Jules Verne and the Star Wars saga are set before present time.) Many of the most popular Science Fiction games are set in outer space, and often involve alien races.");
insert into category (category_id, name, description)
values (6, "Fighting",
"Fighting games are those that encourage players to engage game characters in close quarter battles and hand-to-hand combat.");

/*===== Designer Data =====*/
insert into designer (designer_id, name, description)
values (2, "Klaus Teuber",
"Klaus Teuber (born June 25, 1952) is a well-known German game designer.");
insert into designer (designer_id, name, description)
values (3, "Jacob Fryxelius",
"Game developer from Sweden. Co-owner of FryxGames trade company.");
insert into designer (designer_id, name, description)
values (4, "Matt Leacock",
"Matt Leacock is a game designer and user experience designer who is probably best known for creating the very popular game Pandemic. He has been designing games full time since 2014. Prior to that he was a user experience designer at Sococo, Yahoo!, AOL, Netscape, and Apple.");
insert into designer (designer_id, name, description)
values (7, "Roberto Di Meglio",
"Roberto Di Meglio (born March 29, 1966 in Pisa, Italy) is a game designer who has worked in the game industry since 1991, first as editor-in-chief of the most important Italian RPG magazine, then as a publisher. He is Director of Production at Ares Games and a talented game designer, who co-authored the acclaimed War of the Ring board game and Age of Conan Strategy Board Game.");
insert into designer (designer_id, name)
values (11, "Marco Maggi");
insert into designer (designer_id, name, description)
values (13, "Francesco Nepitello",
"Francesco Nepitello is an Italian game designer. He is primarily known as one of the three designers of the popular War of the Ring strategy game, currently published by Ares Games. He is also the lead designer of The One Ring roleplaying game, published by Sophisticated Games and Cubicle 7.");
insert into designer (designer_id, name, description)
values (24, "Jamey Stegmaier",
"Jamey has been designing board games his entire life, but in late 2011 he started developing his first published board game via Kickstarter, Viticulture: The Strategic Game of Winemaking.");

/*===== In_Category Data =====*/
insert into in_category (category_id, boardgame_id)
values (2, 21);
insert into in_category (category_id, boardgame_id)
values (2, 34);
insert into in_category (category_id, boardgame_id)
values (5, 34);
insert into in_category (category_id, boardgame_id)
values (1, 55);
insert into in_category (category_id, boardgame_id)
values (3, 55);
insert into in_category (category_id, boardgame_id)
values (5, 55);
insert into in_category (category_id, boardgame_id)
values (1, 89);
insert into in_category (category_id, boardgame_id)
values (3, 89);
insert into in_category (category_id, boardgame_id)
values (2, 144);

/*===== Designed_By Data =====*/
insert into designed_by (designer_id, boardgame_id)
values (2, 21);
insert into designed_by (designer_id, boardgame_id)
values (3, 34);
insert into designed_by (designer_id, boardgame_id)
values (4, 55);
insert into designed_by (designer_id, boardgame_id)
values (7, 89);
insert into designed_by (designer_id, boardgame_id)
values (11, 89);
insert into designed_by (designer_id, boardgame_id)
values (13, 89);
insert into designed_by (designer_id, boardgame_id)
values (24, 144);

/*===== Review Data =====*/
insert into review (review_id, account_id, boardgame_id, stars, reviewMade)
values (1, 3213, 21, 9, "destroys friendships, would play again");
insert into review (review_id, account_id, boardgame_id, stars, reviewMade)
values (1, 3213, 55, 8, "where is all the sand even coming from???");
insert into review (review_id, account_id, boardgame_id, stars, reviewMade)
values (2, 1010, 55, 3, "h3h3 too ez of a game");

/*===== Wishlist Data =====*/
insert into wishlist (wishlist_id, account_id, boardgame_id)
values (1, 3213, 34);
insert into wishlist (wishlist_id, account_id, boardgame_id)
values (2, 3213, 89);
insert into wishlist (wishlist_id, account_id, boardgame_id)
values (1, 1010, 21);
insert into wishlist (wishlist_id, account_id, boardgame_id)
values (2, 1010, 34);

/*===== Favorites Data =====*/
insert into favorites (favorite_id, account_id, boardgame_id)
values (1, 3213, 21);
insert into favorites (favorite_id, account_id, boardgame_id)
values (2, 3213, 55);
insert into favorites (favorite_id, account_id, boardgame_id)
values (1, 1010, 144);