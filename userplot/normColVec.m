function A = normColVec(A)
n = size(A, 2);
for i=1:n
A(i,:) = A(i,:) / norm(A(i,:));
end
end