%% Exports a 3D tiledlayout plot
function exportTile3D(tile, axArray, figure_high, figuresPath, fileName)
    tile.TileSpacing = 'compact';
    for ax = axArray
        grid(ax,'on')
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
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
