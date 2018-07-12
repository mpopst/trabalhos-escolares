function A=meupascal(n)
A=NaN(n);
for i=1:n
A(i, 1)=1;
A(1, i)=1;
end
for i=2:n+1
    for j=2:(n+1-i)
        A(i,j)=A(i-1,j)+A(i, j-1);
    end
end

