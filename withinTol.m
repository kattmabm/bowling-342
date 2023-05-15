function [r] = withinTol(x, y, tol)
    r = (x - y <= tol) && (y - x <= tol);
end