%% Converts deciamal dots to commas
function decimalComma(ax)

    % save exponent
    xExponent = ax.XAxis.Exponent;
    yExponent = ax.YAxis.Exponent;

    % get the ticklabels with decimal POINTS 
    xLabels = get(ax.XAxis, 'TickLabels');
    yLabels = get(ax.YAxis, 'TickLabels');

    % replace decimal points with decimal commas 
    for i = 1:size(xLabels,1) 
        xLabels(i,:) = strrep(xLabels(i,:), '.', ','); 
    end 

    for i = 1:size(yLabels,1) 
        yLabels(i,:) = strrep(yLabels(i,:), '.', ','); 
    end 

    % set the plot labels to the new labels with decimal commas 
    ax.XAxis.TickLabels = xLabels; 
    ax.YAxis.TickLabels = yLabels;
    
    if xExponent ~= 0
        annotation('textbox', [(ax.OuterPosition(1)+ax.OuterPosition(3))*0.98, ax.InnerPosition(2)*1.05, 0.1, 0.1], ...
            'String', ['\cdot10^', num2str(yExponent)], 'EdgeColor', 'none', ...
            'FontName', 'Times New Roman', 'FontSize', 10);
    end
    % if yExponent ~= 0
    %     annotation('textbox', [ax.InnerPosition(1)*0.95, (ax.OuterPosition(2)+ax.OuterPosition(4))*0.98, 0.1, 0.1], ...
    %         'String', ['\cdot10^', num2str(yExponent)], 'EdgeColor', 'none', ...
    %         'FontName', 'Times New Roman', 'FontSize', 10);
    % end
    if yExponent ~= 0
        annotation('textbox', [ax.InnerPosition(1)*0.95, (ax.OuterPosition(2)+ax.OuterPosition(4))*0.98, 0.1, 0.1], ...
            'String', ['\cdot10^', num2str(yExponent)], 'EdgeColor', 'none', ...
            'FontName', 'Times New Roman', 'FontSize', 10);
    end
    
end
