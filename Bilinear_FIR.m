% OBJECTIVE 1 Bilinear Filter And FIR Filter
clc;                        % Clear the command window
clear;                      % Remove all variables from the workspace
close all;                  % Close all open figure windows

fs = 1000;                  % Define the sampling frequency (Hz)
T = 1/fs;                   % Calculate the sampling period
t = 0:T:1;                  % Create a time vector from 0 to 1 second
N = length(t);              % Determine the number of samples in the signal
a_base = 100;               % Define the base value for 'a' used in the bilinear filter

% Generate a normalized sinc signal centered at 0.5 seconds
signal = sinc(100*(t - 0.5));   % Create a narrow sinc function (bandlimited signal)
signal = signal / norm(signal);% Normalize the signal's energy (L2 norm = 1)

% Define analog filter: numerator is a constant, denominator is 1st-order polynomial
[num_s, den_s] = deal(a_base, [1 a_base]);      % Use 'deal' to assign values to num_s and den_s

% Apply bilinear transform to convert analog filter to digital filter
[num_z_base, den_z_base] = bilinear(num_s, den_s, fs);  % Compute digital filter coefficients

% Filter the signal using the digital bilinear filter
filtered_signal_base = filter(num_z_base, den_z_base, signal);  % Apply the filter to the signal

% ---------------------- Bilinear Basis Expansion ----------------------
figure('Name', 'Objective 1: Bilinear Expansion');  % Create a new figure for Objective 1
plot(t, signal, 'b', t, filtered_signal_base, 'r'); % Plot original and filtered signal
legend('Original', 'Bilinear Filtered');            % Add legend
title(' Bilinear Basis Expansion');     % Set the title for the figure

% ----------------------Effect of Parameter a ----------------------
a_vals = [10, 50, 100, 200];        % Define array of 'a' values to test the effect
figure('Name', 'Effect of Parameter a');  % New figure for this objective

for i = 1:length(a_vals)           % Loop over each value of 'a'
    a = a_vals(i);                 % Assign current value of 'a'
    
    % Generate digital filter coefficients using bilinear transform
    [num_z, den_z] = bilinear(a, [1 a], fs);  
    
    % Filter the signal using the new filter
    filt = filter(num_z, den_z, signal);   
    
    % Plot the filtered result in subplot
    subplot(2,2,i);                % Create subplot for each 'a'
    plot(t, filt);                 % Plot the filtered signal
    title(['a = ' num2str(a)]);   % Title with current 'a' value
    xlabel('Time (s)');           % X-axis label
    ylabel('Amplitude');          % Y-axis label
end

% ----------------------FIR vs Bilinear Comparison ----------------------
fc = 0.1;                         % Normalized cutoff frequency for FIR filter (0.1 of Nyquist)
fir_coeff = fir1(100, fc);       % Design a low-pass FIR filter of order 100
fir_out = filter(fir_coeff, 1, signal);  % Apply the FIR filter to the signal

M = 50;                          % Number of largest coefficients to retain (sparse approx.)

% --- FIR Sparse Approximation ---
[~, idx_fir] = maxk(abs(fir_out), M);  % Find indices of M largest-magnitude FIR outputs
fir_approx = zeros(1, N);              % Initialize FIR approximation as zeros
fir_approx(idx_fir) = fir_out(idx_fir);% Retain only M largest coefficients

% --- Bilinear Sparse Approximation ---
[~, idx_bil] = maxk(abs(filtered_signal_base), M);  % Get indices of top M bilinear outputs
bil_approx = zeros(1, N);               % Initialize bilinear approximation as zeros
bil_approx(idx_bil) = filtered_signal_base(idx_bil);% Keep only top M responses

% Compute Mean Squared Error (MSE) between original and approximations
mse_fir = mean((signal - fir_approx).^2);   % MSE for FIR sparse approx
mse_bil = mean((signal - bil_approx).^2);   % MSE for bilinear sparse approx

% --- Plot Sparse Approximations ---
figure('Name','FIR vs Bilinear Approximation');  % New figure
title('Approximation Analysis Of FIR Filter And Bilinear Filter');
subplot(2,1,1);                        % Upper subplot for FIR
plot(t, signal, t, fir_approx, 'g');  % Plot original and FIR approx
title('FIR Approximation');           % Title
legend('Original', 'FIR');            % Legend
grid on;                              % Enable grid

subplot(2,1,2);                        % Lower subplot for bilinear
plot(t, signal, t, bil_approx, 'r');  % Plot original and bilinear approx
title('Bilinear Approximation');      % Title
legend('Original', 'Bilinear');       % Legend
grid on;                              % Enable grid

% ---To Plot MSE Comparison ---
figure('Name', ' MSE Comparison');  % Create bar chart for MSEs
bar([mse_fir mse_bil]);                        % Create bar plot
set(gca, 'XTickLabel', {'FIR', 'Bilinear'});   % Label x-axis categories
ylabel('MSE');                                % Y-axis label
title('MSE: FIR vs Bilinear');                % Title
grid on;                                      % Enable grid

% ---To Print MSE Values in Command Window ---
fprintf('\nMSE Comparison:\n');  % Heading for display
fprintf('FIR Approximation  MSE : %.6f\n', mse_fir);     % Print FIR MSE
fprintf('Bilinear Approximation MSE : %.6f\n', mse_bil); % Print bilinear MSE

% ----------------------Comparison Plot ----------------------
figure('Name', 'Final Comparison: Original, FIR, and Bilinear');  % Create final figure

% --- Original Signal ---
subplot(3,1,1);                  
plot(t, signal);          
title('Original Signal'); legend('Original'); grid on;
xlabel('Time (s)'); ylabel('Amplitude');     % Label axes

% --- FIR Output ---
subplot(3,1,2);                  
plot(t, fir_approx, 'g');       
title('FIR Filter Output'); legend('FIR Filtered'); grid on;
xlabel('Time (s)'); ylabel('Amplitude');     % Label axes

% --- Bilinear Output ---
subplot(3,1,3);                  
plot(t, bil_approx, 'r');       
title('Bilinear Filter Output'); legend('Bilinear Filtered'); grid on;
xlabel('Time (s)'); ylabel('Amplitude');     % Label axes
