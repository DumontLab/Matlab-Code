function histogram_normalizer(varargin)
%function to accept an arbitrary number of datasets, choose a uniform
%number of bins, and plot histograms normalized to the total number of
%observations in each set

%%colorcheck=input('Do you want to define colors y/n? ','s');


for i=1:length(varargin)
    [counts, edges]=histcounts(varargin{i});
    
    limits(i,:)=[edges(1) edges(length(edges))];
    
    numbins(i)=length(edges);
end


start=min(limits(:));
stop=max(limits(:));
%finds the range (start to stop) large enough to encompass all the data

finalbinnum=min(numbins);

%finds the target bin number. Here defined as the widest ones determined on
%a dataset by matlab

binwidth= (stop-start)/finalbinnum;

%finds the bin width large enough to go from start to encompass the stop
%(will overestimate by a bit)

bins=start:binwidth:start+binwidth*finalbinnum;

%builds bin vector for histograms
figure
hold all
for i=1:length(varargin)
    counts=histcounts(varargin{i},bins);
    %makes a frequency vector using defined binsize
    counts=counts/sum(counts);
    %normalizes to the number of counts
    text=sprintf('Please input color in format [r g b] (0-1). COLOR %d',i);
%     if colorcheck=='y'
%         histcolor=input(text);
%         plot(bins(1:length(bins)-1),counts,'Color',histcolor)
%     else
    plot(bins(1:length(bins)-1),counts)
%     end
    %Makes a line histogram plot using left edges
end

    