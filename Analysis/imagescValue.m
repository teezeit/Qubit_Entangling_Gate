function [] = imagescValue( mat,textanzeigen,plottitle,labels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%figure
load('MyColormaps','rwbmap');


%'Position',[.15 .2 .75 .7],...
% 'FontUnits','points',...
% 'FontWeight','normal',...
% 'FontSize',9,...
% 'FontName','Times')

imagesc(mat);            %# Create a colored plot of the matrix values

caxis([-1 1]);   %set fixed colorscale so that 0 is always white
colormap(rwbmap);

set(gca,...
'YTick',1:1:max(size(mat)),...
'XTick',1:1:max(size(mat)) ...
);

set(gca,'XTickLabel',labels);
set(gca,'YTickLabel',labels);
plotTickLatex2D('',0.2);
set(gca,'XAxisLocation','top') % Set XAxis above
title(plottitle);

colorbar;






%shall the values be put in? Doesnt make sense for 16 dim matrix
if textanzeigen
    textStrings = num2str(mat(:),'%0.3f');  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    [x,y] = meshgrid(1:max(size(mat)));   %# Create x and y coordinates for the strings
    hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');

            %Some of the Text in white?
            
% midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
% textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
%                                              %#   text color of the strings so
%                                              %#   they can be easily seen over
%                                              %#   the background color
% set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

end
set(gca,'PlotBoxAspectRatio',[1 0.8 1]);

end

