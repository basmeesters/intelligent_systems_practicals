% Wumpus exploration route
wumpus(1,1,1).
wumpus(2,1,2).
wumpus(3,3,2).
wumpus(4,5,2).
wumpus(5,6,2).
wumpus(6,6,3).
wumpus(7,8,3).
wumpus(8,9,3).
wumpus(9,9,5).
wumpus(10,9,6).
wumpus(11,10,6).
wumpus(12,10,7).
wumpus(13,11,7).
wumpus(14,11,9).
wumpus(15,11,11).
wumpus(16,11,13).
wumpus(17,11,14).
wumpus(18,12,14).
wumpus(19,12,15).
wumpus(20,14,15).
wumpus(21,16,15).
wumpus(22,17,15).
wumpus(23,17,16).
wumpus(24,18,16).
wumpus(25,18,17).
wumpus(26,19,17).

walkingRule1(9,3, 9,5).
walkingRule1(11,7, 11,9).
walkingRule1(11,9, 11,11).

walkingRule2(1,2, 3,2).
walkingRule2(3,2, 5,2).
walkingRule2(6,3, 8,3).
walkingRule2(12,15, 14,15).
walkingRule2(14,15, 16,15).

walkingRule3(1,1, 1,2).
walkingRule3(6,2, 6,3).
walkingRule3(10,6, 10,7).
walkingRule3(11,13, 11,14).
walkingRule3(17,15, 17,16).
walkingRule3(18,16, 18,17).

walkingRule4(5,2, 6,2).
walkingRule4(8,3, 9,3).
walkingRule4(9,6, 10,6).
walkingRule4(10,7, 11,7).
walkingRule4(11,14, 12,14).
walkingRule4(17,16, 18,16).
walkingRule4(18,17, 19,17).
