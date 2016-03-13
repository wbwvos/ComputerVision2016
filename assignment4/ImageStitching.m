
run('vlfeat-0.9.20/toolbox/vl_setup')
%I = vl_impattern('left.jpg') ;
%image(I) ;
ima = imread('boat/img1.pgm');
Ia = single(ima) ;
imb = imread('boat/img2.pgm');
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
[matches, scores] = vl_ubcmatch(da, db);
%h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%set(h3,'color','g') ;

iterations = 10;
bestInliers = 0;
bestTransformation = 0;

for i = 1:iterations
    perm = randperm(size(matches, 2));
    nMatches = 3;
    sel = perm(1:nMatches);
    A = zeros(2*nMatches, 6);
    b = zeros(2*nMatches, 1);
    i = 1;
    for matchno = sel
        match = matches(:, matchno);
        xa = fa(1,matches(1,matchno));
        xb = fb(1,matches(2,matchno));
        ya = fa(2,matches(1,matchno));
        yb = fb(2,matches(2,matchno));
        A(i, :) = [xa, ya, 0, 0, 1, 0];
        A(i+1, :) = [0, 0, xa, ya, 0, 1];
        b(i, :) = xb;
        b(i+1, :) = yb;
        i = i + 2;
    end

    transformation = pinv(A)*b;

    transformations = zeros(size(matches,2), 2);
    inliers = 0 ;
    for i = 1:size(matches,2)    
        xa = fa(1,matches(1,i));
        xb = fb(1,matches(2,i));
        ya = fa(2,matches(1,i));
        yb = fb(2,matches(2,i));
        A = [xa, ya, 0,  0,  1, 0 ;
             0 , 0 , xa, ya, 0, 1 ];
        trans = A*transformation;
        xt = trans(1);
        yt = trans(2);
        %transformations(i, 1) = xt;
        %transformations(i, 2) = yt;
        dist = sqrt((xt - xb)^2 + (yt - yb)^2);
        if dist <= 10
            inliers = inliers + 1;
        end

    %     plot(xa,ya,'r.','MarkerSize',20)
    %     plot(xt + size(Ia, 2),yt,'b.','MarkerSize',20)
    %     h = line([xa ; xt + size(Ia, 2)], [ya ; yt]) ;
    %     set(h,'linewidth', 0.5, 'color', 'y') ;
    end
    if inliers > bestInliers
        bestSel = sel;
        bestInliers = inliers;
        bestTransformation = transformation;
    end
end

bestTransformation
m1 = bestTransformation(1);
m2 = bestTransformation(2);
m3 = bestTransformation(3);
m4 = bestTransformation(4);
t1 = bestTransformation(5);
t2 = bestTransformation(6);
bestInliers
totalMatches = size(matches,2)

tform = maketform('affine',[m1 m2 0; m3 m4 0; t1 t2 1]);
Ibt = imtransform(imb, tform, 'nearest');
[left, right] = matchHeight(Ia, Ibt);
imshow(cat(2, left, right)) ;

figure(2) ; clf ;
[Ileft, Iright] = matchHeight(Ia, Ib);
imagesc(cat(2, Ileft, Iright)) ;

xa = fa(1,matches(1,bestSel)) ;
xb = fb(1,matches(2,bestSel)) + size(Ia,2) ;
ya = fa(2,matches(1,bestSel)) ;
yb = fb(2,matches(2,bestSel)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 0.5, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,bestSel))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,bestSel))) ;
axis image off ;





