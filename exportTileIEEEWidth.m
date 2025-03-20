%% Exports figure with fullfills the format requirements of an IEEE paper
function exportTileIEEEWidth(figure, tile, axArray, lgdArray, figure_size, figurePathArray, fileName, cropping, LaTeX, varargin)

    % Some general settings
    try 
        settingsIEEE.expFactor = varargin{1, 1};
    catch
        settingsIEEE.expFactor = [  1, 1;
                                    0.9, 1.02;
                                    1, 1];
        if LaTeX
            settingsIEEE.expFactor = [  1, 1;
                                    0.9, 0.99;
                                    1, 1];
        end
    end
    settingsIEEE.font = 'Times New Roman';
    settingsIEEE.fontSize = 8;
    % settingsIEEE.MarkerSize = 3;
    tile.TileSpacing = 'compact';
    tile.Padding = 'tight';
    tile.OuterPosition = [0.005 0 0.995 1];

    % Some settings for every axis
    for ax = axArray
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.ZGrid = 'on';
        ax.XMinorGrid = 'off';
        ax.YMinorGrid = 'off';
        ax.ZMinorGrid = 'off';
        ax.Box = 'on';
        ax.BoxStyle = 'full';
        ax.LabelFontSizeMultiplier = 1;
        ax.TitleFontSizeMultiplier = 1;
        ax.FontSizeMode = 'manual';
        ax.FontSize = settingsIEEE.fontSize;
        if ~LaTeX
            ax.FontName = settingsIEEE.font;
        end
        if LaTeX
            ax.XLabel.Interpreter = 'latex';
            ax.YLabel.Interpreter = 'latex';
            ax.ZLabel.Interpreter = 'latex';
            ax.TickLabelInterpreter = 'latex';
            try
                ax.Legend.Interpreter = 'latex';
            end
        end
        try
            for indexChildren = 1 : length(ax.Children)
                ax.Children(indexChildren,1).MarkerSize = settingsIEEE.MarkerSize;
            end
        end
    end

    % Adapt the legend accordingly
    for lgd = lgdArray
        lgd.FontSize = 6.5;
        if ~LaTeX
            lgd.FontName = settingsIEEE.font;
        end
    end

    % Leave "plot edit" mode
    plotedit('off');

    set(figure, 'units', 'centimeters', 'position', [3 3 figure_size(1) figure_size(2)]);

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
        % Export as png file
        exportgraphics(gcf, strcat(path, strcat(fileName, '.png')), 'BackgroundColor', 'white', ...
            'ContentType', 'image', 'Resolution', 600);
    end
end
