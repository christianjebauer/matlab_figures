%% Converts deciamal dots to commas in 3D plots
function decimalComma3D(ax)
% source: https://www.gomatlab.de/decimalpunkt-in-plot-als-komma-t18608.html

    % check if there is an exponent 10^K currently in the plot and save info 
    xVisibility = ax.XAxis.SecondaryLabel.Visible ; 
    yVisibility = ax.YAxis.SecondaryLabel.Visible ; 
    zVisibility = ax.ZAxis.SecondaryLabel.Visible ; 

    % get the ticklabels with decimal POINTS 
    xLabels = get(ax.XAxis, 'TickLabels');
    yLabels = get(ax.YAxis, 'TickLabels');
    zLabels = get(ax.ZAxis, 'TickLabels');

    % replace decimal points with decimal commas 
    for i = 1:size(xLabels,1) 
        xLabels(i,:) = strrep(xLabels(i,:), '.', ','); 
    end 

    for i = 1:size(yLabels,1) 
        yLabels(i,:) = strrep(yLabels(i,:), '.', ','); 
    end 

    for i = 1:size(zLabels,1) 
        zLabels(i,:) = strrep(zLabels(i,:), '.', ','); 
    end 

    % set the plot labels to the new labels with decimal commas 
    ax.XAxis.TickLabels = xLabels; 
    ax.YAxis.TickLabels = yLabels; 
    ax.ZAxis.TickLabels = zLabels; 

    % setting the ticklabels manually will automatically disable the visibility 
    % of the exponent (saved in .SecondaryLabel). Reactivate the visibility of 
    % the exponent if necessary. 
    ax.XAxis.SecondaryLabel.Visible = xVisibility; 
    ax.YAxis.SecondaryLabel.Visible = yVisibility; 
    % ax.ZAxis.SecondaryLabel.Visible = zVisibility;
    
end
