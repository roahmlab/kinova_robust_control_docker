clc;

dumbbell_name = '7lb';

model = URDF_to_spatialv2_model(['models/urdf/gen3_2f85_dumbbell_', dumbbell_name, '.urdf']);
theta_groundtruth = getModelInertialParams(model);
theta_groundtruth = theta_groundtruth(61:70);
theta_groundtruth = theta_groundtruth([1:4, 5, 10, 6, 9, 8, 7]);

%%
thetas = [];
theta_uncertainties = [];
theta_lbs = [];
theta_ubs = [];
for i = 1:5
    result = load(['results/sysid_result_', num2str(i-1), '.mat']);
    thetas = [thetas; result.theta_solution];
    theta_uncertainties = [theta_uncertainties; result.theta_uncertainty];
    theta_lbs = [theta_lbs; result.theta_lb];
    theta_ubs = [theta_ubs; result.theta_ub];
end

figure;
for i = 1:10
    subplot(2,5,i);
    errorbar(0:4, thetas(:,i), theta_uncertainties(:,i), 'b');
    hold on;
    plot(0:4, theta_groundtruth(i) * ones(1,5), 'ro-');
    plot(0:4, theta_lbs(:, i), 'g*');
    plot(0:4, theta_ubs(:, i), 'g*');
    if i == 1
        legend('estimation', 'groundtruth', 'updated lower bound', 'updated upper bound');
    end
    xlim([-1,5]);
    xticks(0:4);
    xlabel('number of exciting trajectories');
    if i == 1
        ylabel('value (mass: kg)');
    elseif i <= 4
        ylabel('value (center of mass: kg * m)');
    else
        ylabel('value (inertia: kg * m^2)');
    end
    title(params_names{i});
end
sgtitle(['gripper + ', dumbbell_name, ' dumbbell']);

%%
te = readmatrix('log/tracking_error.txt');
t3 = te(:,1);
e = te(:,2:8);
t3 = t3 / 1e9;
t3 = t3 - t3(1);
figure;
for i = 1:7
    subplot(2,4,i);
    hold on;
    plot(t3(te(:,end) == 1), rad2deg(e(te(:,end) == 1,i)), 'b.');
    plot([t3(1), t3(end)], [0, 0], 'k');
    xlabel('time (sec)');
    ylabel('tracking error (degree)');
    title(['joint ', num2str(i)]);
end
sgtitle([dumbbell_name, ' dumbbell tracking error']);