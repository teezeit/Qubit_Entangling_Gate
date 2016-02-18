function [  ] = ShowRun( result,index,varargin )
%Shows the Runs specified in index.Plots the matrix and the pulses
%1) Load the Solution of the optimization mat-file
%2) Run this function with the result as an argument
%3) Specify in the index vector e.g. [1 3 4] which results to show.
%(this would give the first, third and fourth best gate
%put varargin to 'nice' to remove the imaginary part.

for i=1:length(index)

PlotEps(result.runs(index(i)));

if isempty(varargin)
    Plot_Easy_Gate(result.runs(index(i)).U,'single');
elseif strcmp(varargin{1},'nice')
    Plot_Easy_Gate(result.runs(index(i)).Unice,'single');
else
    error('wrong varargin input');
end

end





end

