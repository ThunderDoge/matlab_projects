x = -6.5:0.1:6.5;
y = x;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);

if evalin( 'base', 'exist(''net30'',''var'') == 0' )
[net30,tr] = genrbfnet(X, Y, Z, 30, 5);
end

if evalin( 'base', 'exist(''net60'',''var'') == 0' )
[net60,tr] = genrbfnet(X, Y, Z, 60, 10);
end

if evalin( 'base', 'exist(''net90'',''var'') == 0' )
[net90,tr] = genrbfnet(X, Y, Z, 90, 15);
end
