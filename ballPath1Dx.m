function [t, x, vx, ux] = ballPath1Dx(x0, vx0, wx0, muFunc, plot_text)
% If plot_text was not provided, do not plot
if ~exist("plot_text", "var") || isempty(plot_text)
    do_plot = false;
else
    do_plot = true;
end
% CONSTANT VALUES
lane_wid = 3.5;  % Length of bowling lane    (ft)
r = 0.716;      % Radius of ball            (ft)
g = 32;         % Acceleration of gravity   (ft/s2)
t_max = 5;      % Maximum time to calculate (s)
dt = 0.01;      % Time step                 (s)
tol = 0.05;
% ARRAYS TO STORE VALUES
max_t_steps = t_max / dt;
t = zeros(1, max_t_steps);
x = zeros(1, max_t_steps);
vx = zeros(1, max_t_steps);
ux = zeros(1, max_t_steps);
x_dir = zeros(1, max_t_steps);
x_skidding = true;
% INITIAL VALUES
t(1) = 0;
x(1) = x0;
vx(1) = vx0;
ux(1) = r*wx0;
i = 2;
% Increment values over time
while true
    % Increment t and y
    t(i) = t(i-1) + dt;
    x(i) = x(i-1) + (vx(i-1)*dt);
    x_dir(i) = sign(ux(i-1)-vx(i-1));
    % If the ball is skidding, change the translational and
    % tangential velocities
    if x_skidding == true
%         fprintf("t = %d, x=%d\n", t(i), x(i));
%         fprintf("sign: %d\n", x_dir(i));
%         fprintf("dvx: %d\n", (-x_dir(i) * g * muFunc(x(i)) * dt));
%         fprintf("dux: %d\n\n", (x_dir(i) * 5 * g * muFunc(x(i)) * dt / 2));
        vx(i) = vx(i-1) - (x_dir(i) * g * muFunc(x(i)) * dt);
        ux(i) = ux(i-1) + (x_dir(i) * 5 * g * muFunc(x(i)) * dt / 2);
        % If the ball is no longer skidding, change y_skidding
        if withinTol(vx(i), ux(i), tol)
            fprintf("Stopped spinning at x=%d, t=%d\n", x(i), t(i))
            vx(i) = ux(i);
            x_skidding = false;
        end
    % Otherwise, keep them the same
    else 
        vx(i) = vx(i-1);
        ux(i) = ux(i-1);
    end
    % If the ball has reached the end of the lane, break
    if x(i) > lane_wid/2 || x(i) < -lane_wid/2 || i >= max_t_steps-1
        break
    end
    % fprintf("Time: %d\n", t(i))
    % fprintf("Y position: %d\n\n", y(i))
    i = i + 1;
end
% Remove the unused space at the end of the arrays
t = t(1:i);
x = x(1:i);


% Plotting if desired
if do_plot
    figure;
    hold on;
    set(gcf, "Position", [200, 200, 800, 350])
    plot(t, x, "LineWidth", 2.5);
%     plot(x, ux, "LineWidth", 2.5);
    xlim([0, t(i)]);
    ylim([-lane_wid/2, lane_wid/2]);
    xlabel("Time (s)");
    ylabel("Position (ft)");
%     legend("Translational Velocity", "Tangential Velocity", "Location", "Best")
    title("Bowling Ball Speeds Over Time");
    subtitle(plot_text);
    hold off;
end

end

