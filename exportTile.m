%% Exports a tiledlayout plot
function exportTile(tile, axArray, lgdArray, figure_high, figuresPath, fileName)
    prepare_tile_for_export(tile, axArray, lgdArray, figure_high, true);
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
