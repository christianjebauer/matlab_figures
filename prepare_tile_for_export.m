%% Prepares a tiledlayout plot for export
function [] = prepare_tile_for_export(tile, axArray, lgdArray, figure_high, comma, varargin)
% Exports figures for an IMT thesis
    figure1 = gcf;
    tile.TileSpacing = 'compact';
    % tile.Padding = 'tight'; % To: Find a way to make this compatible with
    % exponents, with "tile.Padding = 'tight';" the font size is correctly
    % exported
    for ax = axArray
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        ax.Box = 'on';
        ax.BoxStyle = 'full';
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
    set(figure1,'units','centimeters','position',[0 0 14.7 figure_high]); % Adapt too textwidth
    if (comma==true)
        for ax = axArray
            decimalComma(ax, varargin);
            % xl = get(ax,'YTickLabel');
            % new_xl = strrep(xl(:),'.',',');
            % set(ax,'YTickLabel',new_xl);
        end
    end
end
