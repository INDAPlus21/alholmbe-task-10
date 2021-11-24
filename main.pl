% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).


% checks if we have already visited this spot
is_visited(Spot, [H | T]):- Spot = H; is_visited(Spot, T). % recursion until the end of the list

% Top-level predicate
alive(Row, Column, BoardFileName):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen,                   % Closes the io-stream
    nth1_2d(Row, Column, Board, Stone),
    (Stone = w; Stone = b), % stone is either w or b, else its false and the function returns false directly
    % if we are here then the given spot is not empty, check if the stone at the spot belongs to an alive group
    check_alive(Row, Column, Board, Stone, []). % empty list is where we save visited spots

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board, InitialStone, ListOfVisitedSpots):-
    % Get the stone at the given spot
    nth1_2d(Row, Column, Board, Stone),
    
    % If empty square
    (Stone = e ; (Stone = InitialStone, % empty square returns true, move on if new stone is the same colour as prev stone
            % \+ succeeds if it is not provable, fails if it is
            \+ (is_visited((Row,Column), ListOfVisitedSpots)),
            % if we are here, stone has not already been visited

            % coordinates for this stone's neighbours
            (Up is (Row-1), Right is (Column+1), Down is (Row+1), Left is (Column-1),

                % checks all neighbours in the order: right, up, left, down
                (check_alive(Row, Right, Board, InitialStone, [(Row, Column) | ListOfVisitedSpots]);
                check_alive(Up, Column, Board, InitialStone, [(Row, Column) | ListOfVisitedSpots]);
                check_alive(Row, Left, Board, InitialStone, [(Row, Column) | ListOfVisitedSpots]);
                check_alive(Down, Column, Board, InitialStone, [(Row, Column) | ListOfVisitedSpots]))))
    ).