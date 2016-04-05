allFiles = dir( 'C:\Users\Chris\Dropbox\CMU\IACD\pills\images' );
allNames = {allFiles.name};
for fname = allNames
    if strcmp(fname,'.') || strcmp(fname,'..')
        continue;
    else
        temp = ['images\' fname];
        process(cell2mat(temp));
    end
end