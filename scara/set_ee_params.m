function set_ee_params(scara, handles)
    set(handles.x_start, 'String', num2str(round(scara.end_effector(1), 4)));
    set(handles.y_start, 'String', num2str(round(scara.end_effector(2), 4)));
    set(handles.z_start, 'String', num2str(round(scara.end_effector(3), 4)));
    set(handles.roll_start, 'String', num2str(round(rad2deg(scara.end_effector(6)), 2)));
    set(handles.pitch_start, 'String', num2str(round(rad2deg(scara.end_effector(5)), 2)));
    set(handles.yaw_start, 'String', num2str(round(rad2deg(scara.end_effector(4)), 2)));
end