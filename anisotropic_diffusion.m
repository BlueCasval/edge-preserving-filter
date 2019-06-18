function diff = anisotropic_diffusion(img, lambda, k, N)
%   Input arguments:
%   ----------------
%     img             Input image (2-D, double, N-by-M matrix). 
%       
%     lambda          控制平滑.Default value is 0.15
%       
%     k               导热系数,控制平滑 Default value:20
%       
%     N               迭代次数. Default:20
%

if(~exist('N', 'var')) %如果参数不存在，所取默认值，下同
    N = 5;
end

if(~exist('k', 'var'))
    k = 20;
end

if(~exist('lambda', 'var'))
    lambda = 0.15;
end


img = double(img);
[rows,cols] = size(img);
diff = img;

for i = 1:N

  % Construct diffl which is the same as diff but
  % has an extra padding of zeros around it.
  diffl = zeros(rows+2, cols+2);
  diffl(2:rows+1, 2:cols+1) = diff;

  % North, South, East and West differences
  deltaN = diffl(1:rows,2:cols+1)   - diff;
  deltaS = diffl(3:rows+2,2:cols+1) - diff;
  deltaE = diffl(2:rows+1,3:cols+2) - diff;
  deltaW = diffl(2:rows+1,1:cols)   - diff;

  % Conduction

  cN = exp(-(deltaN/k).^2);
  cS = exp(-(deltaS/k).^2);
  cE = exp(-(deltaE/k).^2);
  cW = exp(-(deltaW/k).^2);


  diff = diff + lambda*(cN.*deltaN + cS.*deltaS + cE.*deltaE + cW.*deltaW);
end
