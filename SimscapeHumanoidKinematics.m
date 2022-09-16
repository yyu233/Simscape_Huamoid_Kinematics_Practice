mdl = 'sm_import_humanoid_urdf';
load_system(mdl);
ik = simscape.multibody.KinematicsSolver(mdl);

base = 'sm_import_humanoid_urdf/World/W';
follower = 'sm_import_humanoid_urdf/right_wrist/B';
addFrameVariables(ik, 'Wrist', 'translation', base, follower);

frameVariables(ik)
targetIDs = ["Wrist.Translation.x"; "Wrist.Translation.y";...
    "Wrist.Translation.z"];
addTargetVariables(ik, targetIDs);

jointPositionVariables(ik)
outputIDs = ["j12.Rz.q"; "j16.Rz.q"; "j17.Rz.q"];
addOutputVariables(ik, outputIDs);

targets = [-0.16, -0.12, 0];
[outputVec, statusFlag] = solve(ik, targets);



%guessesIDs = ["j16.Rz.q"; "j17.Rz.q"];
%guessesIDs = ["j16.Rz.q"];
guessesIDs = ["j17.Rz.q"];

%guesses = [90, 90];
guesses = [-90];
addInitialGuessVariables(ik, guessesIDs);
[outputVec, statusFlag] = solve(ik, targets, guesses);
viewSolution(ik);

