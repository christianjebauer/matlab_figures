function DistColors = imtdistcolors(N)
% USDISTCOLORS creates distinguishable colors complying with University of
% Stuttgart CD
%
%   Inputs:
%
%   N                   Number of distinguishable colors to create.
%
%   Outputs:
%
%   DISTCOLORS          Nx3 array of distinguishable colors.



%% File information
% Author: Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>
% Date: 2018-05-14
% Changelog:
%   2018-05-14
%       * Change ordering of colors to match powerpoint color layout
%   2017-02-24
%       * Initial release
%   2023-04-23
%       * Adaption to IMT colors



%% Do your code magic here

% The 6 base colors
vCDBaseColors = [...
     0, 190, 255 ; ... US light blue
     0,  81, 158 ; ... US dark blue
   159, 153, 154 ; ... light grey
    62,  68,  76 ; ... US dark grey
   % 255, 213,   0 ; ... yellow, not allowed at IMT
   118, 130, 118 ; ... IMT dark green
   231,  81,  18 ; ... red
   % 61, 71, 80; ... IMT dark grey, to close to US dark grey
]./255;

% \definecolor{UStuttDarkBlue}{RGB}{0,81,158}
% \definecolor{UStuttLightBlue}{RGB}{0,190,255}
% \definecolor{UStuttDarkGreen}{RGB}{59,140,122}
% \definecolor{UStuttLightGreen}{RGB}{125,155,101}
% \definecolor{UStuttDarkOrange}{RGB}{228,175,52}
% \definecolor{UStuttLightOrange}{RGB}{236,218,145}

% Count the number of base colors
nBaseColors = size(vCDBaseColors, 1);
% How many colors to create are left?
nRemain = N - nBaseColors;

% Now pad these colors so long till we have N colors
if nRemain > 0
    % How many lighter and darker will we need to obtain?
    nChanges = ceil(nRemain/nBaseColors);
    % How many changes to lighter colors?
    nChanges_Lighter = ceil(nChanges/2);
    % How many changes to darker colors
    nChanges_Darker = nChanges - nChanges_Lighter;
    
    % We will alternate between making colors brighter and then darker till we
    % meet the final N
    ceChanges = cell(1, nChanges);
    [ceChanges{1:2:end}] = deal(@rgb_lighter);
    [ceChanges{2:2:end}] = deal(@rgb_darker);
    
    % Now calculate the changes in lightness/darkness
    vChanges = zeros(1, nChanges);
    vScaling_Lighter = linspace(0, nChanges_Lighter, nChanges_Lighter + 1)./(nChanges_Lighter + 1);
    vScaling_Darker = linspace(0, nChanges_Darker, nChanges_Darker + 1)./(nChanges_Darker + 1);
    % And assing the scaling factors
    vChanges(1:2:end) = vScaling_Lighter(2:end);
    vChanges(2:2:end) = vScaling_Darker(2:end);
    
    % And change the colors
    aChanged = arrayfun(@(ii) ceChanges{ii}(vCDBaseColors, vChanges(ii)), 1:nChanges, 'UniformOutput', false);
    
    % Create output
    DistColors = vertcat(vCDBaseColors, aChanged{:});
% No additional colors requested
else
    DistColors = vCDBaseColors;
end

% And select only as much as is needed
DistColors = DistColors(1:N,:);


end

%------------- END OF CODE --------------
% Please send suggestions for improvement of this file to the original author as
% can be found in the header Your contribution towards improving this function
% will be acknowledged in the "Changes" section of the header
