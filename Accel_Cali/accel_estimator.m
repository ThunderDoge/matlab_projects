classdef accel_estimator

    properties
        F
        F2
        b
        g_const
    end

    methods
        function obj = accel_estimator()
            % accel_estimate constructor
            obj.F = zeros(3,3);
            obj.F2 = zeros(3,3);
            obj.b = zeros(3,1);
            obj.g_const = 9.8;
        end

        function D_a = amToDa(~, am)
            D_a = zeros(3, 9);
            D_a(1, 1:3) = am';
            D_a(2, 4:6) = am';
            D_a(3, 7:9) = am';
        end

        function [eF, eF2, eb] = estimate(obj, am, rotm)
            % estimate parameters by observation
            [~,n] = size(am);
            X = zeros(3.*n, 9+3+3);

            for i = 1:n
                Dai = amToDa(obj, am(:,i));
                X(3*i-2 : 3*i, 1:9) = Dai;
                X(3*i-2 : 3*i, 10:12) = rotm(:,:,i)';
                X(3*i-2 : 3*i, 13:15) = -1*eye(3);
            end
            % Solve min ||X*x0|| that ||x0||==1 by SVD
            [U,S,V] = svd(X,"econ");

            % S is diag of sigular values in decending order.
            % The unit norm solution of which is the last column of V.
            x0 = V(:, end);

            % (De)normalize x0 by gravity constant.
            gT = x0(10:12);
            norm_g = norm(gT);
            x0 = -sign(gT(3)) * obj.g_const / norm_g * x0;
            gT = x0(10:12); % The extimated gravity vector

            gT0 = [0,0,0];
            while norm(gT-gT0) >= (0.001 * norm(gT))    % exit condition = error < 0.1%
                gT0 = gT; % record old gravity

                X2 = zeros(n, 9+3+3+3);
                for i = 1:n
                    Dai = amToDa(obj, am(:,i));
                    X2(3*i-2 : 3*i, 1:9) = Dai;
                    RT = rotm(:,:,i)';
                    X2(3*i-2 : 3*i, 10:12) = RT;
                    X2(3*i-2 : 3*i, 13:15) = -diag((RT*gT).^2);
                    X2(3*i-2 : 3*i, 16:18) = -1*eye(3);
                end

                [~,~,V2] = svd(X2,"econ");

                % S is diag of sigular values in decending order
                % The unit norm solution of which is the last column of V.
                % "Calibration of high-grade inertial measurement units using a rate table"
                x2 = V2(:, end);
                gT = x2(10:12); % The extimated gravity vector
                norm_g = norm(gT);
                x2 = -sign(gT(3)) * obj.g_const ./ norm_g .* x2;
                gT = x2(10:12);%  Update the extimated gravity vector
            end
            % Output
            eF = inv ([x2(1:3)' ; x2(4:6)'; x2(7:9)']);
            eF2 = diag(x2(13:15));
            eb = x2(16:18);

        end
    end
end