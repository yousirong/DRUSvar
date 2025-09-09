%% MATLAB Script to Generate SVD .mat files for DRUSvar
%
% This script calculates the Singular Value Decomposition (SVD) of a 
% system matrix H and saves the components (U, S, V) into separate .mat
% files, which are required by the DRUSvar Python scripts.

%% --- USER ACTION REQUIRED --- 
% Define your system matrix H here.
% H should represent the physics of your ultrasound imaging system.
% This is a placeholder example. You MUST replace it with your actual matrix.

% Example: Create a placeholder matrix H (e.g., 1024x1024)
% In a real scenario, this matrix would be derived from your beamforming
% or imaging model.
disp('Defining the system matrix H...');
H = rand(1024, 1024) + 1i * rand(1024, 1024); % Placeholder

% --- END OF USER ACTION --- 


%% Perform Singular Value Decomposition
% This step can be computationally intensive and time-consuming.
disp('Performing Singular Value Decomposition (SVD)...');
[U, S, V] = svd(H, 'econ'); % 'econ' for economy-size decomposition
disp('SVD calculation complete.');

%% Define Save Path
% The .mat files will be saved in a 'SVD' subdirectory.
% This path should correspond to the '--matlab_path' argument used in the Python script.
savePath = fullfile(pwd, 'picmus', 'SVD');

if ~exist(savePath, 'dir')
   mkdir(savePath);
   disp(['Created directory: ', savePath]);
end

%% Save the SVD components to .mat files
% The Python script expects these specific variable names and filenames.

disp('Saving SVD components...');

% Save Ud.mat (U matrix)
Ud = U;
save(fullfile(savePath, 'Ud.mat'), 'Ud', '-v7.3');
disp('Saved Ud.mat');

% Save Sigma.mat (Singular values as a vector)
Sigma = diag(S);
save(fullfile(savePath, 'Sigma.mat'), 'Sigma', '-v7.3');
disp('Saved Sigma.mat');

% Save Vd.mat (V matrix)
Vd = V;
save(fullfile(savePath, 'Vd.mat'), 'Vd', '-v7.3');
disp('Saved Vd.mat');

disp('---');
disp('Successfully generated all required .mat files.');
disp(['Files are located in: ', savePath]);
