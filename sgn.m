function y = sgn(x)

%   For each element of X, SIGN(X) returns 1 if the element
%   is greater than or equal to zero, and -1 if it is
%   less than zero.


y = (x>=0) + (-1)*(x<0);