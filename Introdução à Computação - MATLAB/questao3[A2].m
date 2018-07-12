function media=questao3(aposta)
vetor=zeros(1, 1000)
for j=1:1000 %Este é o FOR da simulação
saldo=10;
for i=1:100 %Este é o FOR da partida
    c=randi(6);
    d=randi(6);
    soma=c+d;
    if soma==aposta
        saldo=saldo+0.2;
    else
        saldo=saldo-0.1;
    end
end
vetor(1, j)=saldo; %Este vetor guarda o resultado dos jogos do cara
end
s=0;
for i=1:1000 %Este for soma os resultados
    s=vetor(1,i)+s;
end
media=(s)/(1000) %E aqui tu tira a média