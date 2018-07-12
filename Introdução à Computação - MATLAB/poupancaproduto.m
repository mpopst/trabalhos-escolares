function [nmeses, pcompra, saldo]=poupancaproduto(di, dm, tpoup, p, tpreco)
%di=deposito inicial da poupan�a
%dm=deposito final da poupan�a
%tpoup= taxa de rendimento mensal da poupan�a
%p= pre�o atual do produto
%tpreco= aumento atual de pre�o
%nmeses= numero de meses
%pcompra= pre�o pago na compra
%saldo= o que restou no final na poupan�a

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
    if pcompra1-saldo1<pcompra-saldo; %teste l�gico da diverg�ncia
        disp 'Esta fun��o diverge!'
        nmeses=inf;
        pcompra=NaN;
        saldo=NaN
        return
    end
end
saldo=saldo-pcompra;