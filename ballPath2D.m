function [t, x, y, vx, vy, ux, uy] = ballPath2D(x0, y0, vx0, vy0, wx0, wy0, muFunc, plot_text)
% If plot_text was not provided, do not plot
if ~exist("plot_text", "var") || isempty(plot_text)
    do_plot = false;
else
    do_plot = true;
end

% CONSTANT VALUES
lane_len = 60;  % Length of bowling lane    (ft)
lane_wid = 3.5; % Length of bowling lane    (ft)
r = 0.716;      % Radius of ball            (ft)
g = 32;         % Acceleration of gravity   (ft/s2)
t_max = 5;      % Maximum time to calculate (s)
dt = 0.01;      % Time step                 (s)
tol = 0.1;

% ARRAYS TO STORE VALUES
max_t_steps = t_max / dt;
t = zeros(1, max_t_steps);
x = zeros(1, max_t_steps);
y = zeros(1, max_t_steps);
vx = zeros(1, max_t_steps);
vy = zeros(1, max_t_steps);
ux = zeros(1, max_t_steps);
uy = zeros(1, max_t_steps);
% theta = zeros(1, max_t_steps);
x_skidding = true;
y_skidding = true;

% INITIAL VALUES
t(1) = 0;
x(1) = x0;
y(1) = y0;
vx(1) = vx0;
vy(1) = vy0;
ux(1) = r*wx0;
uy(1) = r*wy0;
x_dir = sign(vx(1)*ux(1));
% theta(1) = atan(vx(1)/vy(1));

% Increment values over time
i = 2;
while true
    % Increment t and y
    t(i) = t(i-1) + dt;
%     theta(i) = atan(vx(i-1)/vy(i-1));
    x(i) = x(i-1) + (vx(i-1)*dt);
    y(i) = y(i-1) + (vy(i-1)*dt);
    % If the ball is skidding, change the translational and
    % tangential velocities
    if y_skidding == true
        vy(i) = vy(i-1) - (g * muFunc(x(i), y(i)) * dt);
        uy(i) = uy(i-1) + (5 * g * muFunc(x(i), y(i)) * dt / 2);
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
    if x_skidding == true
        vx(i) = vx(i-1) + (x_dir * g * muFunc(x(i), y(i)) * dt);
        ux(i) = ux(i-1) + (x_dir * 5 * g * muFunc(x(i), y(i)) * dt / 2);
        % If the ball is no longer skidding, change x_skidding
        if withinTol(vx(i) + ux(i), 0, tol)
%             fprintf("%s Stopped spinning at x=%d, t=%d\n", plot_text, x(i), t(i))
            vx(i) = -ux(i);
            x_skidding = false;
        end
    % Otherwise, keep them the same
    else 
        vx(i) = vx(i-1);
        ux(i) = ux(i-1);
    end
    % Break if the max time has been reached
    if t(i) >= max_t_steps
        break
    end
    % If the ball has reached the end of the lane, break
    if y(i) > lane_len
        break
    end
    % If the ball has gone into the gutter, break
    if x(i) < -lane_wid/2 || x(i) > lane_wid/2
        break;
    end
    i = i + 1;
end

% Remove the unused space at the end of the arrays
t = t(1:i);
x = x(1:i);
y = y(1:i);
vx = vx(1:i);
vy = vy(1:i);
ux = ux(1:i);
uy = uy(1:i);

% Plotting if desired
if do_plot
    figure;
    hold on;
    set(gcf, "Position", [200, 200, 800, 250]);
    set(gca, "YAxisLocation", "left")
    set(gca, "YAxisLocation", "right")
    plot(y, x, "LineWidth", 2.5);
    ylim([-lane_wid/2, lane_wid/2]);
    yticks([-1.75, 0, 1.75]);
    xlim([0, 60]);
    xlabel("Y-Position (ft)");
    ylabel("X-Position (ft)");
    title("Bowling Ball Path for Amateur Shot");
    % title("Bowling Ball Path for Professional Shot");
    % title("Bowling Ball Path For Over-Spinning Professional Shot");
    subtitle(plot_text);
    hold off;
end

end

