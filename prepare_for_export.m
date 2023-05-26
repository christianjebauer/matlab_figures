%% Prepares a plot for export
function [] = prepare_for_export(figure_high,comma)
ax = gca;
figure1 = gcf;
grid on;
ax.LabelFontSizeMultiplier = 1;
ax.TitleFontSizeMultiplier = 1;
ax.FontSizeMode = 'manual';
ax.FontSize = 10;
ax.FontName = 'Times New Roman';
set(figure1,'units','centimeters','position',[0 0 14.7 figure_high])
    if (comma==true)
        xl = get(ax,'YTickLabel');
        new_xl = strrep(xl(:),'.',',');
        set(ax,'YTickLabel',new_xl);
    end
end
