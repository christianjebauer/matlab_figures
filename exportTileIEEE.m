%% Exports figure with fullfills the format requirements of an IEEE paper
function exportTileIEEE(figure, tile, axArray, lgdArray, figure_high, figurePathArray, fileName, varargin)

    % Some general settings
    try 
        settingsIEEE.expFactor = cell2mat(varargin{1, 1}{1, 1});
    catch
        settingsIEEE.expFactor = [  1, 1;
                                    0.9, 1.02;
                                    1, 1];
    end
    settingsIEEE.font = 'Times New Roman';
    settingsIEEE.fontSize = 8;
    settingsIEEE.MarkerSize = 3;
    tile.TileSpacing = 'compact';
    tile.Padding = 'tight';
    set(gcf, 'units', 'centimeters', 'position', [0 0 8.63477 figure_high]);

    % Some settings for every axis
    for ax = axArray
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.ZGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        ax.ZMinorGrid = 'on';
        ax.Box = 'on';
        ax.BoxStyle = 'full';
        ax.LabelFontSizeMultiplier = 1;
        ax.TitleFontSizeMultiplier = 1;
        ax.FontSizeMode = 'manual';
        ax.FontSize = settingsIEEE.fontSize;
        ax.FontName = settingsIEEE.font;
        try
            for indexChildren = 1 : length(ax.Children)
                ax.Children(indexChildren,1).MarkerSize = settingsIEEE.MarkerSize;
            end
        end
    end

    % Adapt the legend accordingly
    for lgd = lgdArray
        lgd.FontSize = 6.5;
        lgd.FontName = settingsIEEE.font;
    end

    % Leave "plot edit" mode
    plotedit('off');

    % Safe figure with original exponent
    fileName = erase(fileName, '.pdf');
    for pathIndex = 1 : length(figurePathArray)
        path = figurePathArray(pathIndex);
        savefig(figure, strcat(path, fileName));
    end

    % Replaces the exponents in a figure by annotations
    for ax = axArray
        exponentValue = [ax.XAxis.Exponent; ax.YAxis.Exponent; ax.ZAxis.Exponent];
        exponentFnc(figure, ax, settingsIEEE, exponentValue)
    end

    % Prevents undesired cropping of the figure by exportgraphics
    % annotation('rectangle',[0 0 1 1],'Color','w');
    
    for pathIndex = 1 : length(figurePathArray)
        path = figurePathArray(pathIndex);
        % Export as eps file
        exportgraphics(gcf, strcat(path, strcat(fileName, '.eps')), 'BackgroundColor', 'none', ...
            'ContentType', 'vector', 'Resolution', 300);
        % Export as pdf file
        exportgraphics(gcf, strcat(path, strcat(fileName, '.pdf')), 'BackgroundColor', 'none', ...
            'ContentType', 'vector', 'Resolution', 300);
    end
end
