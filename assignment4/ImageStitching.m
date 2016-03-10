%I = vl_impattern('left.jpg') ;
%image(I) ;
ima = rgb2gray(imread('left.jpg'));
Ia = single(ima) ;
imb = rgb2gray(imread('right.jpg'));
Ib = single(imb) ;
%[f,d] = vl_sift(I) ;

%perm = randperm(size(f,2)) ;
%sel = perm(1:100) ;
%h1 = vl_plotframe(f) ;
%h2 = vl_plotframe(f) ;
%set(h1,'color','k','linewidth',3) ;
%set(h2,'color','y','linewidth',2) ;


[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db)
%h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%set(h3,'color','g') ;