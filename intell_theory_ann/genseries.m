function y = genseries(fcn,y0,y1,n)
% generates a series by 2-var function @fcn, with initial value.
% fcn:      the function. 
%           if u wanna use f() pls call like 'genseries(@f,y0,y1,n)'
% y0, y1:   the initial values.
% n:        length of series. include y0 and y1.
if n < 2
    y = NaN;
    return;
end
y = zeros(1,n);
y(1) = y0;
y(2) = y1;
if n<3
    return;
end
for i = 3:n
    y(i) = fcn(y(i-1),y(i-2));
end
%% plotting
tiledlayout(1,2);

nexttile
plot(y);
title('y(t) series');
xlabel('t');
ylabel('y');

nexttile;
plot3(y(1:end-2), y(2:end-1),y(3:end),'-.');
title('f(x,y) plot');
xlabel('x');
ylabel('y');
zlabel('f(x,y)')

axis equal;
end