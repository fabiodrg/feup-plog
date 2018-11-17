:-[utils].

test_isRowEmpty_board([
		[e, e, e],
		[e, e, w-1],
		[b-5, e, e],
		[e, b-1, e]
	]).

test_isRowEmpty:-
	test_isRowEmpty_board(X),
	isRowEmpty(X, 0),
	write('Passed teste 1\n'),
	\+ isRowEmpty(X, 1),
	write('Passed teste 2\n'),
	\+ isRowEmpty(X, 2),
	write('Passed teste 3\n'),
	\+ isRowEmpty(X, 3),
	write('Passed teste 4\n'),
	\+ isRowEmpty(X, 50),
	write('Passed teste 5\n').

test_isColumnEmpty_board([
		[e, e, e, b-2],
		[e, e, w-1, e],
		[e, b-5, e, e]
	]).

test_isColumnEmpty:-
	test_isColumnEmpty_board(X),
	isColumnEmpty(X, 0),
	write('Passed teste 1\n'),
	\+ isColumnEmpty(X, 1),
	write('Passed teste 2\n'),
	\+ isColumnEmpty(X, 2),
	write('Passed teste 3\n'),
	\+ isColumnEmpty(X, 3),
	write('Passed teste 4\n').
