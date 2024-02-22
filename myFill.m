function res = myFill(bw)
    % TOP RIGHT
    bw_a_filled = imfill(padarray(bw,[1 1],1,'pre'),'holes');
    res = bw_a_filled(2:end,2:end);

    % TOP LEFT  
    bw_a_filled = imfill(padarray(padarray(bw,[1 0],1,'pre'),[0 1],1,'post'),'holes');
    res = res | bw_a_filled(2:end,1:end-1);
    
    % BOTTOM RIGHT
    bw_a_filled = imfill(padarray(bw,[1 1],1,'post'),'holes');
    res = res | bw_a_filled(1:end-1,1:end-1);
    
    % BOTTOM LEFT
    bw_a_filled = imfill(padarray(padarray(bw,[1 0],1,'post'),[0 1],1,'pre'),'holes');
    res = res | bw_a_filled(1:end-1,2:end);

end

