function z = f(x,y)
z = (0.3 -0.6 .* exp(-x.^2)) .* x - (0.8 +0.9 .* exp(-x.^2)) .* y +0.3.*sin(pi.*x);
end