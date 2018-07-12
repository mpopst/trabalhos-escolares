function quadmagic(A)
T=size(A);
if T(1)~=T(2)
    disp 'Nao e um quadrado 1'
    return
end
M=histcounts(A, T(1)*T(1));
if prod(M)~=1
    disp 'Nao e um quadrado magico 2'
    return
end
B=sum(A);
a=B(1);
for i=1:T(1)
    if B(i)~=a
        disp 'Nao e um quadrado magico! 3 '
        return
    end
end
B=sum(A, 2);
for i=1:T(1)
    if B(i)~=a
        disp 'Nao e um quadrado magico! 4'
        return
    end
end
c=0;
for i=1:T(1)
    c=c+A(i, i);
end
if c~=a
    disp 'Nao e um quadrado magico! 5'
    return
end
c
c=0;
for i=1:T(1)
    c=c+A(i, T(1)+1-i);
end
if c~=a
    disp 'Nao e um quadrado magico 6'
    return
end
disp 'E um quadrado magico'