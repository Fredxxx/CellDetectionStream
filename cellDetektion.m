%% read Tiff stack
baseFolder= 'C:\Users\Frederik\Documents\MATLAB\Knop\cellDetection\test\';
fname = 'oil.tif';
fpath = strcat(baseFolder,fname);
[~,~,numImg]=readTifStack(fpath);
%% bioformats
%data = bfopen(fpath);
%data3D = bfOpen3DVolume(fpath);
reader = bfGetReader(fpath);
%out = data;
%outR = reader;
%% cell detection
thold = 200;
smoothfac = 10;
close all
[result, img] = cellDetector(reader, numImg, thold, smoothfac);

%%  sort cells data
tDiff = 940; % in µs
pS = 0.1; % in µm
sortedResult = sortCellData(result, numImg, tDiff, pS);
%% get positive images (full, cut, cut background) and negative images (full only)
[neg, pos, posS, pos0, posResults] = saveNegPosImg(reader, sortedResult, numImg);
%% get Y information 
resCellY = analyseInY(posS, pos0, thold, smoothfac);
posResults = writeYData(posResults, resCellY);
%% show Data

plot(posResults(:,10),'o')
%% save Data
% fpathS=strcat(fpath(1:end-4), 'foundAll2.ome.tiff');
% bfsave(img, fpathS);
fpathSneg=strcat(fpath(1:end-4), 'foundNeg2.ome.tiff');
bfsave(neg, fpathSneg);
fpathSpos=strcat(fpath(1:end-4), 'foundPos2.ome.tiff');
bfsave(pos, fpathSpos);
fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut2.ome.tiff');
bfsave(posS, fpathSposCut);
% % fpathSposCut=strcat(fpath(1:end-4), 'foundPosCut_Background.ome.tiff');
% % bfsave(pos0, fpathSposCut);