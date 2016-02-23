function G = gaussian(sigma, kernelLength)

%kernel = linspace((-3*sigma),(3*sigma), kernelLength)
kernel = linspace((-(kernelLength-1)/2),((kernelLength-1)/2), kernelLength);
kernel = (-(kernel.^2))./(2*sigma^2);
kernel = exp(kernel);
kernel = (1/(sigma*sqrt(2*pi)))*kernel;
kernel = kernel./sum(kernel);

h = fspecial('gaussian', [1,kernelLength], sigma);
G = kernel;
end

