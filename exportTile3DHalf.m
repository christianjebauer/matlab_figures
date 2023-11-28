%% Exports a 3D tiledlayout plot with half textwidth
function exportTile3DHalf(tile, axArray, figure_high, figuresPath, fileName)
    tile.TileSpacing = 'compact';
    for ax = axArray
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.ZGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        ax.ZMinorGrid = 'on';
        ax.LabelFontSizeMultiplier = 1;
        ax.TitleFontSizeMultiplier = 1;
        ax.FontSizeMode = 'manual';
        ax.FontSize = 9;
        ax.FontName = 'CMU Serif'; % Use listfonts to see all available fonts
    end
    set(gcf, 'units', 'centimeters', 'position', [0 0 0.5*14.8 figure_high]);
    for ax = axArray
        decimalComma3D(ax);
    end
    if ~contains(fileName, '.pdf')
        fileName = strcat(fileName, '.pdf');
    end
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
