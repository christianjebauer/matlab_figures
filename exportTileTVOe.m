%% Exports a 3D tiledlayout plot
function exportTileTVOe(figure, tile, axArray, lgdArray, figure_high, figurePathArray, fileName, cropping, varargin)

    % Some general settings
    try 
        settings.expFactor = cell2mat(varargin{1, 1}{1, 1});
    catch
        settings.expFactor = [  1, 1;
                                0.9, 1.02;
                                1, 1];
    end
    settings.font = 'Calibri';
    settings.fontSize = 9;
    settings.MarkerSize = 8;
    tile.TileSpacing = 'compact';
    tile.Padding = 'tight';
    set(gcf, 'units', 'centimeters', 'position', [0 0 14.8 figure_high]);
    for ax = axArray
        decimalComma3D(ax);
    end

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
        ax.FontSize = settings.fontSize;
        ax.FontName = settings.font;
        try
            for indexChildren = 1 : length(ax.Children)
                ax.Children(indexChildren,1).MarkerSize = settings.MarkerSize;
            end
        end
    end

    % Adapt the legend accordingly
    for lgd = lgdArray
        lgd.FontSize = 6.5;
        lgd.FontName = settings.font;
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
        exponentFnc(figure, ax, settings, exponentValue)
    end

    % Prevents undesired cropping of the figure by exportgraphics
    if cropping == false
        annotation('rectangle',[0 0 1 1],'Color','w');
    end
    
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
