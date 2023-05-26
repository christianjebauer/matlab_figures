%% Converts deciamal dots to commas
function removeCommas
    xl = get(gca,'YTickLabel');
    new_xl = strrep(xl(:),'.',',');
    set(gca,'YTickLabel',new_xl);
end
