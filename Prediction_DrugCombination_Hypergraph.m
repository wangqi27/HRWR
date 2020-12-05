function p=Prediction_DrugCombination_Hypergraph(H)
%H=xlsread('lung_eff_dianbianguanlian.xlsx');
%H=xlsread('breast_eff_dianbianguanlian.xlsx');
%H=xlsread('colon_eff_dianbianguanlian.xlsx');
c=0.2;
[cc,dd]=size(H);

De=diag(sum(H));
We=De;
Dv=diag(sum(H*We,2));
w=pinv(Dv)*H*We*pinv(De)*H';

for k=1:cc
    p0=zeros(cc,1);
    p0(k)=1;
    p1=p0;
    p(:,k)=(1-c)*w'*p0+c*p0;
    while max(abs(p(:,k)-p1))>10^(-6)
        p1=p(:,k);
        p(:,k)=(1-c)*w'*p1+c*p0;
    end
end

%  lung
%  p(15,11)=0;
%  p(11,15)=0;
%  p(6,11)=0;
%  p(11,6)=0;

%  breast
% p(17,18)=0;
% p(18,17)=0;
% p(28,18)=0;
% p(18,28)=0;
% p(55,18)=0;
% p(18,55)=0;
% p(30,31)=0;
% p(31,30)=0;

% colon
% p(17,4)=0;
% p(4,17)=0;
% p(2,22)=0;
% p(22,2)=0;

score=zeros(cc,cc);
for i=1:(cc-1)
    for j=i+1:cc
        score(i,j)=p(i,j)+p(j,i);
    end
end

B=sort(score(:),'descend');
p;
end
