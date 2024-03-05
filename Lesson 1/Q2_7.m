u = input('Please enter a vector [u1 u2]: ');

v = input('Please enter a vector [v1 v2]: ');

dot_product = dot(u, v);

magnitude_u = norm(u);
magnitude_v = norm(v);

cos_theta = dot_product / (magnitude_u * magnitude_v);

theta_degrees = acosd(cos_theta);

fprintf('The angle is %f: ', theta_degrees);

