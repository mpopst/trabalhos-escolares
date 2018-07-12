function questao4()
%Renomeei a planília pq era mto comprido.
proc=xlsread('brazil.xlsx', 1, 'B1:B1');
A=xlsread('brazil.xlsx', 3);
s=0;
for i=1:size(A, 1)
    for j=1:size(A,2)
        if A(i,j)==proc
            s=s+1;
            resultado(s,1)=i;
            resultado(s,2)=j;
        end
    end
end
xlswrite('brazil.xlsx', s, 4, 'B1:B1')
se=int2str(s);
local=['A3:B',se];
%Existe uma maneira menos gambiarra de se fazer isso?
xlswrite('brazil.xlsx', resultado, 4, local)
disp 'FOI!'