function [h,h2]=areaplotter(x,y,E)
%close all
lower=y-E;
width=2*E;

if size(lower,2) > 1

lower = lower';

width = width';

x = x';

end

area1=[lower width];

h=area([x x],area1);

set(h(1),'FaceColor','None')
set(h(1),'EdgeColor','None')
set(h(2),'FaceColor',[1 0 1])
set(h(2),'EdgeColor','None')

hold on
h2=plot(x,y,'LineWidth',0.5);


