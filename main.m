clc;
close all;
clear all;

filename = 'arctic_a0001.wav';
[speech, srate] = audioread(filename);

samples = 2*srate/1000;
s=srate/8;
zff_output = zeroFreqFilter(speech(:,1), s, samples);
subplot(4,1,2);
plot(zff_output);
xlabel("zff");

energy = zeros(size(speech, 1), 1);
duration = 20/1000;
samples = duration * srate;
for i = 1:size(zff_output, 1)
    interval = min(i+samples-1, size(speech,1));
    signal = zff_output(i:interval, 1);
    esq = signal.^2;
    energy(i) = (sum(esq(:))); 
end

energy_threshold = zeros(size(speech, 1), 1);
for i=1:size(zff_output, 1)
    if (energy(i) > 0.3*((10)^10)) 
        energy_threshold(i)=1;
    else
        energy_threshold(i)=0;
    end
end
x=1:size(zff_output, 1);

subplot(4,1,1);
plot(speech(:,1));
xlabel("speech signal");
hold on;
plot(x,2*(energy_threshold-0.5));

subplot(4,1,3);
plot(x,energy);
xlabel("energy");
subplot(4,1,4);
plot(x,energy_threshold);
xlabel("threshold");