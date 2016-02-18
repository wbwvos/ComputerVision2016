function G = gaussian(sigma, kernelLength)

G = 1/(sigma*sqrt(2*pi))*exp(-power(x, 2)/(2*power(sigma, 2)))
end