CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	body TEXT NOT NULL,
	author_id INTEGER NOT NULL,

	FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	user_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	author_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,
	parent_id INTEGER,

	FOREIGN KEY (author_id) REFERENCES users(id),
	FOREIGN KEY (question_id) REFERENCES questions(id)
	-- FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY,
	user_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO users ('fname', 'lname')
		VALUES ('Olena', 'Iv'), ('James', 'Brewer');

INSERT INTO questions ('title', 'body', 'author_id')
		VALUES ('Yay', 'Anything', 1), ('asdasd', 'Yddw', 2);

INSERT INTO question_followers ('user_id', 'question_id')
		VALUES (1, 2), (2, 1);

INSERT INTO question_likes('user_id', 'question_id')
		VALUES (1, 2), (2, 1);