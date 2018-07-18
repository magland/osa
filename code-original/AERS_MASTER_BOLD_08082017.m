%%
clear all

path1 = getenv('PATH')
path1 = [path1 ':/usr/local/bin:/Applications/freesurfer/bin:/Applications/freesurfer/fsfast/bin:/Applications/freesurfer/tktools:/usr/local/fsl/bin:/Applications/freesurfer/mni/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/X11/bin']
setenv('PATH', path1)
!echo $PATH
setenv('FSLOUTPUTTYPE', 'NIFTI_GZ')
setenv('FREESURFER_HOME', '/Applications/freesurfer')
setenv('SUBJECTS_DIR', '/home/bonnie/work/FREESURFER')


global SUBJECTS_DIR
SUBJECTS_DIR = '/home/bonnie/work/FREESURFER/'
session_dir = pwd; % session directory  /Volumes/WolkStudy/Data/Visit1/OSA_048_05162017
subject_name = 'OSA_010'; % Freesurfer subject name
Visit = 'Visit1';
%% Sort dicoms, convert to nifti
% Sort dicoms into series specific directories, converts dicoms to nifti
% sort_nifti(session_dir,fullfile(session_dir,'DCM'),0);
sort_nifti(session_dir,fullfile('Volumes/home/bonnie/work/',subject_name,'dicom'),0,0); %Bonnie- additional folder in filename
%% Freesurfer Reconstruction
% If the subject has not been run through the Freesurfer recon-all
%   pipeline, run this step.  If the subject aleady exists, you can skip.
%   Note: this will take 9-24 hours, depending on the CPU.
system(['recon-all -i ' fullfile(session_dir,'MPRAGE','001','ACPC',...
    'MPRAGE.ACPC.nii.gz') ' -s ' subject_name ' -all']);
%% B0 fieldmap
% Creates a B0 field map, and brain extracts the magnitude image by
%   registering that image to the freesurfer "brain.mgz" image. If a B0
%   image was not acquired, you can skip.
make_fieldmap(session_dir,subject_name,fullfile('/home/bonnie/work/',subject_name,'dicom'));
%% Brain extract T1 image
% Creates skull stripped file 'MPRAGE_brain.nii.gz' using FreeSurfer tools
skull_strip(session_dir,subject_name);
%% Segment freesurfer aseg.mgz volume
% Segments the freesurfer anatomical aseg.mgz volume into several ROIs in
%   the session_dir, to be used later for noise removal.
segment_anat(session_dir,subject_name);
%% Cross-hemisphere and fsaverage_sym registration
% Checks that 'xhemireg' and 'surfreg' have been run for the specified
%   freesurfer subject.  If not, this function runs those commands.
% xhemi_check(session_dir,subject_name,SUBJECTS_DIR);
%% Motion correction
% Motion correct functional runs. This script has several options, such as 
%   despikeing and slice timing correction.  
motion_slice_correction(session_dir);
%% Register functional runs to anatomical image
% Registers the functional volumes from to the corresponding Freesurfer 
%   anatomical image for the bold directory specified by 'runNum'. 
register_func(session_dir,subject_name);
%% Project anatomical ROIs to functional space
% Projects anatomical ROIs into functional space for the bold directory
%   specified by 'runNum'.
project_anat2func(session_dir);

%%%%%%%%%%%%%%%%%%%%%
%% Create regressors for noise removal
% Creates a nuisance regressor text file for the bold directory
%   specified by 'runNum', based on physiological noise and motion. If a 
%   task-design, an option exists to make the motion parameters orthogonal 
%   to the task.
% create_regressors(session_dir,runNum);
create_regressors(session_dir);

%% Remove noise
% Removes physiological and other non-neuronal noise regressors for tfethe 
%   bold directory specified by 'runNum'
remove_noise(session_dir);
%% Local White Matter
% Removes the average local white matter signal in the functional volume 
%   for the bold directory specified by 'runNum'
remove_localWM(session_dir);
%% Temporal filter
% Temporally filters the bold data, based on a specified filter (see help), 
%   for the bold directory specified by 'runNum'
temporal_filter(session_dir,1);
%% Spatially smooth functional data
% Spatially smooths the functional data in the volume and on the surface,
%   using a Gaussian kernel (default = 5mm).
smooth_vol_surf(session_dir,1);