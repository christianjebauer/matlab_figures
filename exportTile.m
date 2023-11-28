%% Exports a tiledlayout plot
function exportTile(tile, axArray, lgdArray, figure_high, figuresPath, fileName, varargin)
    prepare_tile_for_export(tile, axArray, lgdArray, figure_high, true, varargin);
    if ~contains(fileName, '.pdf')
        fileName = strcat(fileName, '.pdf');
    end
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
