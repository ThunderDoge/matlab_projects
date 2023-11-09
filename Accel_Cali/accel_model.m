classdef accel_model

    properties
        F
        F2
        b
        r
        g_const
    end

    methods
        function obj = accel_model(F, F2, b, r, g_const)
            % method to construct accel_model
            %   F, F2: initial F & F2 (3*3 matrix)
            obj.F = F;
            obj.F2 = F2;
            obj.b = b;
            obj.r = r;
            obj.g_const = g_const;
        end

        function [am, a, rotm] = gen_static_measure(obj, rotm)
            % Generate measurement in static condition
            % Rotation: sensor to inertia
            [~,~,n] = size(rotm);
            a = repmat( (-1) * [0,0,-1]' * obj.g_const, [1,n]); % gravity.
            am = zeros(size(a));
            % *notice that a is -g. IMPORTANT.
            for i = 1:n
                a(:,i) = rotm(:,:,i)' * a(:,i);
                am(:,i) = obj.measure(a(:,i)); % measure gravity
            end
        end

        function am = measure(obj, a)
            % make measure with Gaussian noise
            am = obj.F * (a + obj.F2 * a.^2) + obj.b + normrnd(0,obj.r, size(a));
        end
    end
end