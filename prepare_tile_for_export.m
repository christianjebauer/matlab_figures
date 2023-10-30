%% Prepares a tiledlayout plot for export
function [] = prepare_tile_for_export(tile, axArray, lgdArray, figure_high, comma)
% Exports figures for an IMT thesis
    figure1 = gcf;
    tile.TileSpacing = 'compact';
    % tile.Padding = 'tight';
    for ax = axArray
        grid(ax,'on')
        ax.LabelFontSizeMultiplier = 1;
        ax.TitleFontSizeMultiplier = 1;
        ax.FontSizeMode = 'manual';
        ax.FontSize = 9;
        ax.FontName = 'CMU Serif'; % Use listfonts to see all available fonts
    end
    for lgd = lgdArray
        lgd.FontSize = 9;
        lgd.FontName = 'CMU Serif'; % Use listfonts to see all available fonts
    end
    set(figure1,'units','centimeters','position',[0 0 14.7 figure_high]);
    if (comma==true)
        for ax = axArray
            decimalComma(ax);
            % xl = get(ax,'YTickLabel');
            % new_xl = strrep(xl(:),'.',',');
            % set(ax,'YTickLabel',new_xl);
        end
    end
end
