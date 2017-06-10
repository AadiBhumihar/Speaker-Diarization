function dBIC = deltaBIC(A,B,lamda)


% H0: hypothesis that A and B will be modelled best by 1 Gaussian
% H1: hypothesis that A and B will be modelled best by 2 separate Gaussians


    d = size(A,2);
    if (isempty(lamda))
        lamda = 00;
    end

    n = size(A,1);
    m = size(B,1);
    
    fused = [A;B];
    
   
    
    fusedBIC = (n + m)/2*log(abs(det(cov(fused))));
    
    ABIC = n/2*log(abs(det(cov(A))));
    BBIC = m/2*log(abs(det(cov(B))));
    
    % deltaBIC = (N+M)log(merged) -N.log(data1) -M.log(data2) -const(N,M)
    
    P = 0.5*(d + d*(d+1)/2) + log(n + m);

    dBIC = fusedBIC - ABIC - BBIC - lamda*P;

end