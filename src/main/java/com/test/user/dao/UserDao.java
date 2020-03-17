package com.test.user.dao;

import com.test.user.model.UserModel;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * @Classname UserDao
 * @Description 用户dao接口
 * @Date 2020/3/13 10:15
 * @Created by tangyy
 */
public interface UserDao {
    /**
     * @description 查询所有用户数据
     * @param  
     * @return 用户数据list
     * @date 2020/3/13 10:15
     * @author tangyy
     */
    List<UserModel> findAllUsers(@Param("map")HashMap<String,Object> map, @Param("userModel")UserModel userModel);

    /**
     * @description 查询用户总数
     * @param
     * @return 数据总数量
     * @date 2020/3/13 14:05
     * @author tangyy
     */
    int selectCount();

    /**
     * @description 新增用户
     * @param  userModel 用户对象用来传递参数
     * @return
     * @date 2020/3/13 10:19
     * @author tangyy
     */
    void addUser(UserModel userModel);

    /**
     * @description 编辑用户
     * @param  userModel 用户对象用来传递参数
     * @return
     * @date 2020/3/13 10:20
     * @author tangyy
     */
    void updateUser(UserModel userModel);

    /**
     * @description 获取单个用户
     * @param  userModel 用户对象用来传递参数
     * @return
     * @date 2020/3/13 10:20
     * @author tangyy
     */
    UserModel getOneUser(UserModel userModel);

    /**
     * @description 获取用户表主键
     * @param
     * @return
     * @date 2020/3/13 10:20
     * @author tangyy
     */
    int getPrimaryKey();

    /**
     * @description 删除用户
     * @param  userModel 用户对象用来传递参数
     * @return
     * @date 2020/3/13 10:20
     * @author tangyy
     */
    void deleteUser(UserModel userModel);
}
