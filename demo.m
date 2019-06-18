I = imread('lena.png'); 
I=double(I);
I = I./max(I(:));
%J=imnoise(I, 'poisson');
%J=imnoise(I,'gaussian');
J=imnoise(I,'salt & pepper',0.02);
% if length(size(RGB))>2
%     for i=1:3
%         I(:,:,i) = I(:,:,i)./max(I(:));
%         %res1(:,:,i) = wlsFilter(I(:,:,i));
%         %res2(:,:,i) = anisotropic_diffusion(I(:,:,i));
%         %res3(:,:,i) = SideWindowBoxFilter(I(:,:,i),2,20);
%         %res4(:,:,i) = bilateralFilter(I(:,:,i));
%         %res4(:,:,i) = guidedfilter(I(:,:,i), I(:,:,i), 4, 0.2^2);
%         res4(:,:,i) = tv(I(:,:,i),1.0,100);
%     end
% end
res1 = tv(J,1.0,100);
res2 = wlsFilter(J);
res3 = anisotropic_diffusion(J);
res4 = bilateralFilter(J,J,2,10);
res5 = guidedfilter(J,J , 4, 0.2^2);
[res6,energy]=CF(J,2, 60);
res6=double(res6);
mse1=psnr(res1,I);
mse2=psnr(res2,I);
mse3=psnr(res3,I);
mse4=psnr(res4,I);
mse5=psnr(res5,I);
mse6=psnr(res6,I);
figure,
subplot(241), imshow(I),title('\fontsize{20}原图');
subplot(242),imshow(J),title('\fontsize{20}噪声图像');
subplot(243), imshow(res1),title('\fontsize{20}全变分');
subplot(244), imshow(res2),title('\fontsize{20}最小二乘');
subplot(245), imshow(res3),title('\fontsize{20}各向异性扩散');
subplot(246), imshow(res4),title('\fontsize{20}双边滤波');
subplot(247), imshow(res5),title('\fontsize{20}导向滤波');
subplot(248), imshow(res6),title('\fontsize{20}曲率滤波');



