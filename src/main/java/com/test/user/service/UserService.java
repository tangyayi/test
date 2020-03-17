package com.test.user.service;

import com.test.user.model.PageModel;
import com.test.user.model.UserModel;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.List;

public interface UserService {

    /**
     * @description 分页查询用户信息
     * @param  currentPage 当前页码
     * @return
     * @date 2020/3/16 16:44
     * @author tangyy
     */
    public PageModel<UserModel> findByPage(int currentPage,UserModel userModel);

    /**
     * @description 删除用户
     * @param  userModel 传递主键参数userId
     * @return
     * @date 2020/3/16 16:45
     * @author tangyy
     */
    public void deleteUser(UserModel userModel);

    /**
     * @description 保存用户
     * @param  userModel 传递用户信息参数
     * @return
     * @date 2020/3/16 16:45
     * @author tangyy
     */
    public void saveUser(UserModel userModel) throws ParseException, UnsupportedEncodingException;

    /**
     * @description 根据用户id获取用户信息
     * @param  userId 用户id
     * @return
     * @date 2020/3/16 16:45
     * @author tangyy
     */
    public UserModel getOneUser(int userId);
}
