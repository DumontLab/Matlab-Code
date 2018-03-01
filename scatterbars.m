function [dothandles, linehandles] = scatterbars(varargin)
%Accepts a arbitrary amount of datasets and makes plots where individual
%points are displayed. Like a barplot, but better. handles returns figure
%handles (either for the dots or the average lines)
num_sets = length( varargin );
%get number of inputs
figure

for i = 1:num_sets
    
    data = varargin{i};
    
    x = i * ones(length(data),1);
    %get numbers to position dots;
    dothandles(i) = scatter(x, data);
    
    hold on
    
    linehandles( i ) = plot( [i - 0.2 i + 0.2], [ mean( data ) mean( data ) ]);
    %plot line at the average value
end
