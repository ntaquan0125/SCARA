function set_joints_params(scara, handles)
    if scara.theta(2) < deg2rad(-118)
        scara.theta(2) = scara.theta(2) + 2*pi;
    end
    set(handles.q1_slider, 'Value', rad2deg(scara.theta(2)));
    set(handles.q2_slider, 'Value', rad2deg(scara.theta(3)));
    set(handles.q3_slider, 'Value', scara.d(4));
    set(handles.q4_slider, 'Value', rad2deg(scara.theta(5)));
end