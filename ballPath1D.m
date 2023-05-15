function [t, y, vy, uy] = ballPath1D(y0, vy0, wy0, muFunc, plot_text)
% If plot_text was not provided, do not plot
if ~exist("plot_text", "var") || isempty(plot_text)
    do_plot = false;
else
    do_plot = true;
end
% CONSTANT VALUES
lane_len = 60;  % Length of bowling lane    (ft)
r = 0.716;      % Radius of ball            (ft)
g = 32;         % Acceleration of gravity   (ft/s2)
t_max = 5;      % Maximum time to calculate (s)
dt = 0.01;      % Time step                 (s)
% ARRAYS TO STORE VALUES
max_t_steps = t_max / dt;
t = zeros(1, max_t_steps);
y = zeros(1, max_t_steps);
vy = zeros(1, max_t_steps);
uy = zeros(1, max_t_steps);
y_skidding = true;
% INITIAL VALUES
t(1) = 0;
y(1) = y0;
vy(1) = vy0;
uy(1) = r*wy0;
i = 2;
% Increment values over time
while true
    % Increment t and y
    t(i) = t(i-1) + dt;
    y(i) = y(i-1) + (vy(i-1)*dt);
    % If the ball is skidding, change the translational and
    % tangential velocities
    if y_skidding == true
        vy(i) = vy(i-1) - (g * muFunc(y(i)) * dt);
        uy(i) = uy(i-1) + (5 * g * muFunc(y(i)) * dt / 2);
        % If the ball is no longer skidding, change y_skidding
        if vy(i) <= uy(i)
            vy(i) = uy(i);
            y_skidding = false;
        end
    % Otherwise, keep them the same
    else 
        vy(i) = vy(i-1);
        uy(i) = uy(i-1);
    end
    % If the ball has reached the end of the lane, break
    if y(i) > lane_len || i >= max_t_steps-1
        break
    end
    % fprintf("Time: %d\n", t(i))
    % fprintf("Y position: %d\n\n", y(i))
    i = i + 1;
end
% Remove the unused space at the end of the arrays
t = t(1:i);
y = y(1:i);
vy = vy(1:i);
uy = uy(1:i);

% Plotting if desired
if do_plot
    figure;
    hold on;
    set(gcf, "Position", [200, 200, 800, 350])
    plot(y, vy, "LineWidth", 2.5);
    plot(y, uy, "LineWidth", 2.5);
    xlim([0, y(end)]);
    xlabel("Position (ft)");
    ylabel("Velocity (ft/s)");
    legend("Translational Velocity", "Tangential Velocity", "Location", "Best")
    title("Bowling Ball Speeds Over Time");
    subtitle(plot_text);
    hold off;
end

end

