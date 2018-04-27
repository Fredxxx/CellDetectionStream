%% read Tiff stack
baseFolder= 'C:\Users\Frederik\Documents\MATLAB\Knop\cellDetection\';
fname = 'oil_small.tif';
fpath = strcat(baseFolder,fname);
[~,~,numImg]=readTifStack(fpath);
%% bioformats
data = bfopen(fpath);
data3D = bfOpen3DVolume(fpath);
reader = bfGetReader(fpath);
out = data;
outR = reader;
%% cell detection
thold = 150;
smoothfac = 10;
close all
[result, img] = cellDetector(reader, numImg, thold, smoothfac);
fpathS=strcat(fpath(1:end-4), 'foundAll.ome.tiff');
bfsave(img, fpathS);
%%  sort cells
tDiff = 940; % in µs
pS = 0.1; % in µm
sortedResult = sortCellData(result, numImg, tDiff, pS);
%% get positive images (full, cut, cut background) and negative images (full only)
[neg, pos, posS, pos0, posResults] = saveNegPosImg(reader, sortedResult, numImg);
% fpathSneg=strcat(fpath(1:end-4), 'foundNeg.ome.tiff');
% bfsave(neg, fpathSneg);
% fpathSpos=strcat(fpath(1:end-4), 'foundPos.ome.tiff');
% bfsave(pos, fpathSpos);
% fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut.ome.tiff');
% bfsave(posS, fpathSposCut);
% fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut_Background.ome.tiff');
% bfsave(pos0, fpathSposCut);
%% get Y information 



%find(~cellfun('isempty', result(:,1)))

% %% get one image with a cell
% close all
% imgCell0(:,:,1)=bfGetPlane(reader, 1);
% imgCell0_x=squeeze(sum(imgCell0));
% x=1:length(imgCell0_x);
% for i=32
%     imgCell2(:,:,1)=bfGetPlane(reader, i);
%     imgCell2_x=squeeze(sum(imgCell2));
%     y=imgCell2_x-imgCell0_x;
%     yy=y;
%     yS=smooth(y,10,'moving');
%     y=yS;
%     figure
%     plot(x,yy,x,yS)
%     yIfind=find(y>400);
%     yInegFind=find(y<-400);
%     if length(yIfind) < 0
%         for i=1:length(yIfind)
%             if yIfind(i+1)-yIfind(1) == 1
%             else
%                 maxis=yIfind(1)+(yIfind(1)-yIfind(i))/2;
%                 yIfind=yIfind(i:end);
%                 break
%             end
%         end
%         
%     end
% 
% 
% end
% %%
% yI=y>400;
% yIneg=y<-400;
% yNew=yI.*y+yIneg.*y;
% 
% figure
% plot(x,yy,x,yNew)
% yIfind=find(y>400);
% yInegFind=mean(find(y<-400));
% [pks,locs] = findpeaks(yNew);
% yNewNeg = -yNew;
% [pksN,locsN] = findpeaks(yNewNeg);
% figure
% plot(x,yy,x(locs),pks,'or',x(locsN),-pksN,'r*')
% axis tight
% pos(i)=length(pks);
% posN(i)=length(pksN);