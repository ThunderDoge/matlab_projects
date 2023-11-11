% (if availble) load previous trained network named 'net'.
if evalin( 'base', 'exist(''net'',''var'') == 0' )
[net,tr, performance] = genffn(X,Y,Z);
end

% clear x y X Y Z;
