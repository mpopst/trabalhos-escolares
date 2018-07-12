function resp=questao5(k)
for n=1:100 %calcula o somatório até o infinito, também conhecido como 100
    A(n)=(k^(n) * factorial(n))/(n^n);
end
if abs(A(100)-A(99))>abs(A(99)-A(98))
    %divergente
    resp=inf(1)
else
    %converge
    resp=sum(transpose(A));
end