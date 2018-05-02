function [neg, pos, posS, pos0, posResults] = saveNegPosImg(reader, sortedResult, numImg)
cNeg=0;
cPos=0;
% pos=[];
% neg=[];
% posS=[];
% pos0=[];
posResults=[];
for i=1:numImg
    if i ~= 1
        if sortedResult(i-1,1)~= 1 && sortedResult(i,1) > 0 % save background image in RAM
           posB(:,:)=bfGetPlane(reader, i-1);
        end
    end
    
    if sortedResult(i,1) == -1 % sort negative images 
       xPos=sortedResult(i,6);
       cNeg=cNeg+1;
       neg(:,:,cNeg)=bfGetPlane(reader, i);
    elseif sortedResult(i,1) > 0 % sort positive images
       xPos=sortedResult(i,6);
       cPos=cPos+1;
       posResults(cPos,1:10)=sortedResult(i,1:10);
       posResults(cPos,11)=i;
       pos(:,:,cPos)=bfGetPlane(reader, i);
       xDim = size(pos);
       yU=round(xPos-xDim(1)/2);
       yO=round(xPos+xDim(1)/2);
       if yU < 1 % cut images and make sure to not cut outside of image
           yU=1;
           yO=xDim(1)+1;
       elseif yO > xDim(2)-xDim(1)
           yU=xDim(2)-xDim(1);
           yO=xDim(2);
       end
           posS(:,:,cPos)=pos(:,yU:yO,cPos);
           pos0(:,:,cPos)=posB(:,yU:yO);
    end
end

% fpathSneg=strcat(fpath(1:end-4), 'foundNeg.ome.tiff');
% bfsave(neg, fpathSneg);
% fpathSpos=strcat(fpath(1:end-4), 'foundPos.ome.tiff');
% bfsave(pos, fpathSpos);
% fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut.ome.tiff');
% bfsave(posS, fpathSposCut);
% fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut_Background.ome.tiff');
% bfsave(pos0, fpathSposCut);