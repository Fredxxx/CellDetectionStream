function [posResults] = writeYData(posResults, resCellY)
s1=size(posResults);
s=s1(1);
for k = 1:s
    t=resCellY{k,1};
    if length(t) == 2
         posResults(k,7)=t(1)+(t(2)-t(1))/2;
         posResults(k,9)=t(2)-t(1);
    else
         posResults(k,7)=-1;
         posResults(k,9)=-1;
    end
end