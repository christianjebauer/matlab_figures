%% Exports a 3D tiledlayout plot
function exportTile3D(tile, axArray, figure_high, figuresPath, fileName)
    tile.TileSpacing = 'compact';
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
        ax.FontSize = 9;
        ax.FontName = 'CMU Serif'; % Use listfonts to see all available fonts
    end
    set(gcf, 'units', 'centimeters', 'position', [0 0 14.8 figure_high]);
    for ax = axArray
        decimalComma3D(ax);
    end
    if ~contains(fileName, '.pdf')
        fileName = strcat(fileName, '.pdf');
    end
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
