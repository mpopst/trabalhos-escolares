function [nmeses, pcompra, saldo]=poupancaproduto(di, dm, tpoup, p, tpreco)
%di=deposito inicial da poupança
%dm=deposito final da poupança
%tpoup= taxa de rendimento mensal da poupança
%p= preço atual do produto
%tpreco= aumento atual de preço
%nmeses= numero de meses
%pcompra= preço pago na compra
%saldo= o que restou no final na poupança

%%%%teste logico das taxas
if tpoup<1 || tpreco<1
    disp 'Verifique suas taxas!'
    return
end

%programa em si
saldo=di;
pcompra=p;
nmeses=0;
while saldo<pcompra;
    saldo1=saldo;
    pcompra1=pcompra; %variaveis para impedir divergencia
    saldo=saldo*(tpoup);
    saldo=saldo+dm;
    pcompra=pcompra*(tpreco);
    nmeses=nmeses+1;
    if pcompra1-saldo1<pcompra-saldo; %teste lógico da divergência
        disp 'Esta função diverge!'
        nmeses=inf;
        pcompra=NaN;
        saldo=NaN
        return
    end
end
saldo=saldo-pcompra;