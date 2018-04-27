function [resCell, p] = cellDetector(reader, numImg, thold, smoothfac)
%thold = 150;
%smoothfac = 10;
imgCell0(:,:,1)=bfGetPlane(reader, 1);
imgCell0_x=squeeze(sum(imgCell0));
x=1:length(imgCell0_x);
resCell=cell(numImg,3);
cc=0;
for ii=1:numImg
    imgCell2(:,:,1)=bfGetPlane(reader, ii);
    imgCell2_x=squeeze(sum(imgCell2));
    y=imgCell2_x-imgCell0_x;
    yy=y;
    yS=smooth(y,smoothfac,'moving');
    y=yS;
%     figure
%     plot(x,yy,x,yS)
    yIfind=find(y>thold);
    yInegFind=find(y<-thold);
    count=0; 
    maxis=[];
    minis=[];
    
    while ~isempty(yIfind)
        count = count + 1;
        for i=1:length(yIfind)
            if yIfind(i) == yIfind(end)
               maxis(count)=yIfind(1)+(yIfind(i)-yIfind(1))/2;
               yIfind=[];
               cc=cc+1;
               p(:,:,cc)=imgCell2(:,:,1);
            elseif yIfind(i+1)-yIfind(i) ~= 1
               maxis(count)=yIfind(1)+(yIfind(i)-yIfind(1))/2;
               yIfind=yIfind(i+1:end);
               break
            end
        end 
    end % loop to find maxima
    count=0;
    while ~isempty(yInegFind)
       count = count + 1;
            for i=1:length(yInegFind)
                if yInegFind(i) == yInegFind(end)
                   minis(count)=yInegFind(1)+(yInegFind(i)-yInegFind(1))/2;
                   yInegFind=[];
                elseif yInegFind(i+1)-yInegFind(i) ~= 1
                   minis(count)=yInegFind(1)+(yInegFind(i)-yInegFind(1))/2;
                   yInegFind=yInegFind(i+1:end);
                   break
                end
            end
    end % loop to find minima
    resCell{ii,1}=maxis;
    resCell{ii,2}=minis;
  
    if ~isempty(maxis)||~isempty(minis)
%         figure
%         plot(x,yy,x,yS)
    else
       imgCell0_x=imgCell2_x;
    end
end