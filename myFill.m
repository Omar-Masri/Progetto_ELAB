function res = myFill(bw)
    % TOP RIGHT
    bw_a = padarray(bw,[1 1],1,'pre');
    bw_a_filled = imfill(bw_a,'holes');
    bw_a_filled = bw_a_filled(2:end,2:end);

    % TOP LEFT  
    bw_b = padarray(padarray(bw,[1 0],1,'pre'),[0 1],1,'post');
    bw_b_filled = imfill(bw_b,'holes');
    bw_b_filled = bw_b_filled(2:end,1:end-1);
    
    % BOTTOM RIGHT
    bw_c = padarray(bw,[1 1],1,'post');
    bw_c_filled = imfill(bw_c,'holes');
    bw_c_filled = bw_c_filled(1:end-1,1:end-1);
    
    % BOTTOM LEFT
    bw_d = padarray(padarray(bw,[1 0],1,'post'),[0 1],1,'pre');
    bw_d_filled = imfill(bw_d,'holes');
    bw_d_filled = bw_d_filled(1:end-1,2:end);
    imshow(bw_d_filled)

    res = bw_a_filled | bw_b_filled | bw_c_filled | bw_d_filled;
end
