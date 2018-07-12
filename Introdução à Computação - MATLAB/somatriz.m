function A=somatriz(A, um, dois, tres, operador)
tamanho=size(A)
if tamanho(1)<um || tamanho(1)<dois || tamanho(1)<tres
    disp 'Parem as maquinas!'
    return
end
if operador~=1 && operador~=2 && operador~=3 && operador~=4
    disp 'Falso operador'
    return
end

if operador==1
    for i=1:tamanho(2)
        A(tres, i)=A(um, i)+A(dois, i);
    end
end
if operador==2
    for i=1:tamanho(2)
        A(tres, i)=A(um, i)-A(dois, i);
    end
end
if operador==3
    for i=1:tamanho(2)
        A(tres, i)=A(um, i)*A(dois, i);
    end
end
if operador==4
    for i=1:tamanho(2)
        A(tres, i)=A(um, i)/A(dois, i);
    end
end