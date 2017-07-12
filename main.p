program life;
uses crt;

const
	rows = 38;
	cols = 38;

type
	game_array = array[0..rows-1, 0..cols-1] of integer;

var
	number_of_generations : integer;

function initgame: game_array;
{initalizes a 2d array with dimensions of rows * cols
randomly stores 0s and 1s at each index in the array
0s will represent the dead and 1s will represent the living}
var r,c, dead_or_alive : integer;
var my_array : game_array;
begin
	randomize;
	for c := 0 to (cols - 1) do
	begin
		for r := 0 to (rows -1) do
		begin
		dead_or_alive := random(2);
		my_array[r][c] := dead_or_alive;
		end;
	end;
	initgame := my_array;
end;


procedure printgame(var my_array : game_array);
{takes in a 2d array whose values are 0s and 1s (representing a dead/living person)
prints out the corresponding game of life}
var r, c : integer;
var s : string;
begin
	writeln('Game Of Life (38x38) -- Generation: ', number_of_generations);
	for r := 0 to (rows -1) do
	begin
		s := '';
		for c := 0 to (cols-1) do
		begin
		if(my_array[r][c] = 0) then
			s := s + '. '
		else
			s := s + '# '
		end;
		writeln(s);
	end;

end;





function count_living_neighbors(var my_array : game_array) : game_array;
{takes in a 2d array (my_array) that represents the game of life
creates a new 2d array (my_neighbor) whose values represent the number of living neighbors each index has }
var r, c, ln, rn, tn, bn, tln, trn, bln, brn, total: integer;
var my_neighbor : game_array;
begin
	for r := 0 to (rows-1) do
	begin
		for c := 0 to (cols -1 ) do
			begin
			ln := my_array[r][(c + cols - 1) mod cols];
			rn := my_array[r][(c +1) mod cols];
			tn := my_array[(r + rows - 1) mod rows][c];
			bn := my_array[(r+1) mod rows][c];
			tln := my_array[(r + rows - 1) mod rows][(c + cols - 1) mod cols];
			trn := my_array[(r + rows - 1) mod rows][(c +1) mod cols];
			bln := my_array[(r+1) mod rows][(c + cols - 1) mod cols];
			brn := my_array[(r+1) mod rows][(c +1) mod cols];
			total := ln + rn + tn + bn + tln + trn + bln + brn;
			my_neighbor[r][c] := total;
			end;
	end;
	count_living_neighbors := my_neighbor;
end;

function regenerate(var my_array : game_array) : game_array;
{takes in a 2d array that represents the game of life
and creates a new generation}
var r, c : integer;
var my_neighbor : game_array;
begin
	my_neighbor := count_living_neighbors(my_array);
	for r := 0 to (rows -1) do
	begin
		for c := 0 to (cols-1) do
		begin
		if(my_array[r][c] = 1) then //check if the current cell is alive
			if ((my_neighbor[r][c] >= 2) and (my_neighbor[r][c] <= 3)) then //check if it has 2 or more neighbors
				my_array[r][c] := 1
			else
				my_array[r][c] := 0
		else
			if(my_neighbor[r][c] =3) then
			    my_array[r][c] := 1
			else
				my_array[r][c] := 0
		end;

	end;
	number_of_generations := number_of_generations + 1;
	regenerate := my_array
end;


procedure animate(n: integer; var my_array: game_array);
{takes in a 2d array representing the game of life,
and a number representing how many generations you want of that particular game of life}
var a,i :integer;
begin
	ClrScr;
	if n < 1 then
		writeln('Nothing to animate!')
	else
		begin
			for i := 0 to (n-1) do
			begin
				regenerate(my_array);
				GotoXY(1, 1);
				printgame(my_array);
			end;
		write('How many iterations (0 to end)? ');
		readln(a);
		animate(a,my_array);
		end
end;


{main program----------------}
var a: integer;
var z: game_array;
begin
	z := initgame;
	ClrScr;
	printgame(z);
	write('How many iterations (0 to end)? ');
	readln(a);
	animate(a,z);
end.
