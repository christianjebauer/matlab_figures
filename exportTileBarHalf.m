%% Exports a tiledlayout plot
function exportTileBarHalf(tile, axArray, lgdArray, figure_high, figuresPath, fileName)
    prepare_tile_for_export_half(tile, axArray, lgdArray, figure_high, true);
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
