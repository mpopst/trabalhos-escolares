function nprimo(n)
primo=0; %qtd de primos
i=2; %contador
lastprimo=2
while primo~=n;
    if isprime(i)==1;
        primo=primo+1;
        lastprimo=lastprimo
    end
    i=i+1;
end
i