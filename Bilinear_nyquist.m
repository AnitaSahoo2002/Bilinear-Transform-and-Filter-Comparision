%OBJECTIVE 2: Comparision of Bilinear Filter And Nyquist Sampling
clc;                % Clear the command window
clear;              % Remove all variables from the workspace
close all;          % Close all open figure windows

% Step 1: Generate High-Frequency Continuous-Time Signal (Simulated)
fs_ct = 10000;                        % Sampling frequency to simulate a continuous-time (CT) signal
T_ct = 1/fs_ct;                       % Sampling period for CT signal
t_ct = 0:T_ct:0.05;                   % Time vector from 0 to 50 ms at fs_ct sampling
f_ct = sin(2*pi*100*t_ct) + sin(2*pi*700*t_ct); 
% Continuous-time signal made of two sine waves: 100 Hz (valid) and 700 Hz (to simulate aliasing)

% Step 2: Sample at a Rate Below Nyquist (Aliased Sampling)
fs_nyq = 800;                         % Nyquist sampling rate chosen too low (should be > 2*700 = 1400 Hz)
T_nyq = 1/fs_nyq;                     % Sampling period for low-rate sampling
t_nyq = 0:T_nyq:max(t_ct);           % Time vector for downsampled (aliased) signal
f_nyq = interp1(t_ct, f_ct, t_nyq);  % Interpolate CT signal at Nyquist-rate sample points (causes aliasing)

% Step 3:Bilinear Transform Low-Pass Filtering
a = 600;                              % Cutoff frequency of analog low-pass filter (in Hz)
[num_s, den_s] = deal(a, [1 a]);      % Define analog filter transfer function H(s) = a / (s + a)
[num_z, den_z] = bilinear(num_s, den_s, fs_ct); 
% Convert analog filter to digital using bilinear transform at fs_ct rate
f_bil = filter(num_z, den_z, f_ct);  % Apply digital IIR filter to the CT-sampled signal
f_bil_ds = interp1(t_ct, f_bil, t_nyq); 
% Downsample filtered signal to match low Nyquist-rate sample points (post-filtering alias reduction)

% Proper Nyquist Sampling for Reference (No Aliasing)
fs_good = 2000;                       % Good sampling rate > 2 * 700 Hz (meets Nyquist)
T_good = 1/fs_good;                  % Sampling period for proper Nyquist sampling
t_good = 0:T_good:max(t_ct);         % Time vector for proper sampling
f_good = interp1(t_ct, f_ct, t_good); 
% Properly sampled version of original CT signal (no aliasing expected)

%Step 4: Time-Domain Analysis
figure('Name', 'Time-Domain Comparison with Aliasing and No-Aliasing'); % Create a new figure window

subplot(4,1,1);                       % First subplot: original signal
plot(t_ct, f_ct, 'k');               % Plot continuous-time signal in black
title('Input Continuous-Time Signal (with 700 Hz)'); % Title for first subplot
xlabel('Time (s)'); ylabel('Amplitude'); % Axis labels

subplot(4,1,2);                       % Second subplot: aliased sampled signal
stem(t_nyq, f_nyq, 'b');             % Discrete stem plot of aliased samples in blue
title('Aliased Nyquist Sampled Signal (Fs = 800 Hz)'); % Title
xlabel('Time (s)'); ylabel('Amplitude'); % Axis labels

subplot(4,1,3);                       % Fourth subplot: properly sampled signal
stem(t_good, f_good, 'g');           % Discrete stem plot of properly sampled signal in green
title('Proper Nyquist Sampling (No Aliasing, Fs = 2000 Hz)'); % Title
xlabel('Time (s)'); ylabel('Amplitude'); % Axis labels

subplot(4,1,4);                       % Third subplot: bilinear filtered and downsampled
stem(t_nyq, f_bil_ds, 'r');          % Discrete stem plot of filtered signal in red
title('Bilinear Filtered + Downsampled (Aliasing Reduced)'); % Title
xlabel('Time (s)'); ylabel('Amplitude'); % Axis labels

% Step 5: Frequency Domain Analysis
N_fft = 1024;                         % Number of FFT points
f_axis = linspace(0, fs_ct/2, N_fft/2); 
% Frequency axis from 0 to Nyquist frequency (fs_ct / 2) for plotting

F_ct = abs(fft(f_ct, N_fft));        % FFT magnitude of original CT signal
F_nyq = abs(fft(f_nyq, N_fft));      % FFT magnitude of aliased downsampled signal
F_bil = abs(fft(f_bil_ds, N_fft));   % FFT magnitude of bilinear-filtered downsampled signal

% Plot frequency-domain spectra
figure('Name', 'Frequency Domain Comparison - Aliasing Case'); % figure for frequency plots
plot(f_axis, F_ct(1:N_fft/2), 'k', 'LineWidth', 1.2); hold on; 
% Plot original signal FFT (black solid line)

plot(f_axis, F_nyq(1:N_fft/2)*fs_ct/fs_nyq, 'b--', 'LineWidth', 1.2); 
% Plot aliased signal FFT (blue dashed), scaled for visual alignment

plot(f_axis, F_bil(1:N_fft/2)*fs_ct/fs_nyq, 'r:', 'LineWidth', 1.2); 
% Plot filtered signal FFT (red dotted), scaled similarly

legend('Input', 'Nyquist (Aliased)', 'Bilinear (Filtered)'); % legend
xlabel('Frequency (Hz)'); ylabel('Magnitude');                      % Axis labels
title('Frequency Domain Analysis of Input Signal Aliased Nyquist and Bilinear'); %title
grid on;                                                           % Enable grid
