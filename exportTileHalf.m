%% Exports a tiledlayout plot with half textwidth
function exportTileHalf(tile, axArray, lgdArray, figure_high, figuresPath, fileName)
    prepare_tile_for_export_half(tile, axArray, lgdArray, figure_high, true);
    exportgraphics(gcf, strcat(figuresPath, fileName), 'BackgroundColor', 'none', ...
        'ContentType', 'vector');
end
