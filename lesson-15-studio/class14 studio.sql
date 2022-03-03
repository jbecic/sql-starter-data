select title, isbn
from book
where genre_id in (select genre_id from genre where genres = "mystery");

select book.title, author.first_name, author.last_name
from author
inner join book on author.author_id = book.author_id
where author.deathday is null;

delimiter //

create function loanOut (bookId int, patronId int)
returns varchar(50)
begin
	update book
    set available = 0
    where book_id = bookId;
    
    insert into loan (patron_id, date_out, book_id)
    values (patronId, curdate(), bookId);
    
    update patron
    set loan_id = (select loan_id from loan where patron_id = patronId)
    where patron_id = patronId;
    
    return "book is loaned out.";
end //

delimiter ;

delimiter //

create function loanIn (bookId int)
returns varchar(50)
begin
	update book
    set available = 1
    where book_id = bookId;
    
    update patron
    set loan_id = null
    where patron_id in (select patron_id from loan where book_id = bookId and date_in is null);
    
    update loan 
    set date_in = curdate()
    where book_id = bookId;
    
    return "book is returned.";
end //

delimiter ;

select patron.first_name, patron.last_name, genre.genres
from patron
inner join loan on loan.patron_id = patron.patron_id
inner join genre on genre.book_id = loan.book_id
where loan_id is not null;