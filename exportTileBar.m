%% Exports a tiledlayout plot
function exportTileBar(tile, axArray, lgdArray, figure_high, figuresPath, fileName, varargin)
    prepare_tile_for_export(tile, axArray, lgdArray, figure_high, true, varargin);
    for ax = axArray
        ax.XGrid = 'off';
        ax.XMinorGrid = 'off';
    end
    if ~contains(fileName, '.pdf')
        fileName = strcat(fileName, '.pdf');
    end
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
