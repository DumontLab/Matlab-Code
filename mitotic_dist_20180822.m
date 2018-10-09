%using surfaces made in Imaris, distances already in microns

cd '/Users/lila/Desktop/UCSF/Dumont Lab/Trichoplax Project/Dividing Cells/20180822';

MIfigurename = '20180822_MI.tif';
figurename561 = '20180822_561hist.tif';
figurename405 = '20180822_405hist.tif';
filename561 = '568_XY.csv';
filename405 = '405_XY.csv';

%read in coordinates
cellCoords561 = csvread(filename561);
cellCoords405 = csvread(filename405);

%create the boundary
x = cellCoords405(:,1);
y = cellCoords405(:,2);
edge = boundary(x,y);
edgemat = [x(edge),y(edge)];

%initialize empty lists for for loops
dists561 = [];
dists405 = [];

%find distance to closest point in boundary, for 561 channel
for i = 1:length(cellCoords561)
    %compute Euclidean distances:
    cellCoord = cellCoords561(i,:); 
    distances = sqrt(sum(bsxfun(@minus, edgemat, cellCoord).^2,2));
    mindist = min(distances);
    dists561 = [dists561, mindist];
    i
    
end

%find distance to closest point in boundary, for 405 channel
for i = 1:length(cellCoords405)
    cellCoord = cellCoords405(i,:);
    distances = sqrt(sum(bsxfun(@minus, edgemat, cellCoord).^2,2));
    mindist = min(distances);
    dists405 = [dists405, mindist];
    i
    
end

%bin data and calculate mitotic index
binEdges = linspace(0,400,41);
N561 = histcounts(dists561,binEdges);
N405 = histcounts(dists405,binEdges);
binnedMI = rdivide(N561,N405);

%make and save plots
fig = plot(binEdges(2:end),binnedMI);
xlabel('Distance to Edge, µm');
ylabel('Mitotic Index');
saveas(fig, MIfigurename);

fig = histogram(dists405,binEdges,'FaceColor','b');
xlabel('Distance to Edge, µm');
saveas(fig, figurename405);

fig = histogram(dists561,binEdges,'FaceColor','r');
xlabel('Distance to Edge, µm');
saveas(fig,figurename561);
