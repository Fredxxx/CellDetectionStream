function [max] = sortCellData(result, numImg, tDiff, pS)
cc=0;
%tDiff=940;
%pS=0.1;
% xlabel = pos Max1 Max2 Min cellcount Xpos Ypos dx dy v 
x=zeros(numImg,10);
for k = 1:length(result)
    if ~isempty(result{k})   
        t=result{k,1};
        tt=result{k,2};  
        if length(t) == 2 && length(tt) == 1
             x(k,1)=1;
             x(k,2)=t(1);
             x(k,3)=t(2);
             x(k,4)=tt;
             x(k,6)=t(1)+(t(2)-t(1))/2;
             x(k,8)=t(2)-t(1);
        else
             x(k,1)=-1;
        end
    end
end% chuck negative results

max=x;
for i=1:numImg-1
   if max(i,1)~=1 && max(i+1,1)==1
       cc=cc+1;
   elseif max(i,1)==1 && max(i+1,1)==1
       max(i,10) = (max(i,6)-max(i+1,6))*pS/tDiff;
       max(i,5) = cc;
   elseif max(i,1)==1 && max(i+1,1)~=1
       max(i,5) = cc;
   end       
end% calculate velocity and count cells
