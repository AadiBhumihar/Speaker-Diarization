function change_points = change_point(sig,Fs)


    
        verbose = 0;
        thresh = 100;
        lamda = 10;


  frame_length = 30e-3;
  frame_hop = 10e-3;
  sig = sig(:,1);
   
  S = melcepst(sig,Fs,'0',19, floor(3*log(Fs)) ,frame_length * Fs, frame_hop * Fs);
   
   size(S);
  
  
   window_len = 200 ;
  
    start = 1;
    stop = window_len;
    change_found = 0;
    change_points = [];
    change_points1 = [];
    
   
    
    % Main Loop
    while (stop < length(S))
    
    single_change_block = S(start:stop,:);
    del_BIC = zeros(length(single_change_block),1);
    dis_vec = zeros(length(single_change_block),1);
    
    size(del_BIC);
    p=0;
    
    % H0: There is no change from start:stop
    % H1: There is a change in start:stop at i
    
        for i = 50:length(single_change_block)-50 % keep each block in hypothesis H1 at least 500ms long

            A = single_change_block(1:i,:);
            B = single_change_block(i+1:length(single_change_block),:);
            
            del_BIC(i,:) = deltaBIC(A,B,lamda);
            dis_vec(i,:) = wteucliddis(A,B) ;
            
        end
       del_BIC;
    % Find highest peaks in deltaBIC
        
        [pk,loc] = findpeaks(abs(del_BIC),"MinPeakHeight",1) ; 
        [pk1,loc1] = findpeaks((dis_vec)) ; 
        pks = size(pk) ;
        locs = size(loc)  ;
    if numel(pk ~= 0)
        
        pk = pk(1) ;
        loc = loc(1) ;
        
    % Determine if peak is good enough to declare change
        if (pk > thresh)
            change_found = 1 ;

            change_points = [change_points (start - 1 + loc)];
            
        end
    end
      if numel(pk1 ~= 0)
        pk1 = pk1(1) ;
        loc1 = loc1(1) ;
        change_points1 = [change_points1 (start - 1 + loc1)];
      end 
    % Is there a change?     
        if (change_found==0) % No. So increase search block
            
        % Increase search block     
            stop = stop + 200;

            if (stop - start > 4000)
                start = start + round((stop - start)/2);
                stop = start + 399;
                disp('loop run');
            end

        elseif (change_found  == 1) % Yes. So restart search block
            if (verbose)
                disp(['change detected at ' num2str(change_points(end))]);
            end
        
            start = change_points(end) ;
            stop = change_points(end) + window_len ;
            
          
            change_found = 0;
        end

    end
      
    
     change_points = (change_points * frame_hop*Fs + frame_length*Fs)/Fs;
    if(verbose)
        disp('Change Detection Complete');
end

end
