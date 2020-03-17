package com.test.user.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.test.user.dao.UserDao;
import com.test.user.model.PageModel;
import com.test.user.model.UserModel;
import com.test.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired(required = false)
    private UserDao userDao;

    @Override
    public PageModel<UserModel> findByPage(int currentPage,UserModel userModel) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageModel<UserModel> pageModel = new PageModel<UserModel>();

        //封装当前页数
        pageModel.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageModel.setPageSize(pageSize);

        //封装总记录数
        int totalCount = userDao.selectCount();
        pageModel.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageModel.setTotalPage(num.intValue());
//        System.out.println((currentPage-1)*pageSize);
//        System.out.println((currentPage-1)*pageSize+pageModel.getPageSize());
        map.put("start",(currentPage-1)*pageSize);
        map.put("size", (currentPage-1)*pageSize+pageModel.getPageSize()+1);
        //封装每页显示的数据
        List<UserModel> lists = userDao.findAllUsers(map,userModel);
        pageModel.setLists(lists);

        return pageModel;

    }

    @Override
    public void deleteUser(UserModel userModel) {
        userDao.deleteUser(userModel);
    }

    @Override
    public void saveUser(UserModel userModel) throws ParseException, UnsupportedEncodingException {
        //用户生日date设置
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
        Date date = simpleDateFormat.parse(userModel.getBirthdayString());
        userModel.setBirthday(date);
        //用户姓名编码解码
        userModel.setUserName(java.net.URLDecoder.decode(userModel.getUserName(),"UTF-8"));

        if(userModel.getUserId() == 0){//新增用户
            userModel.setUserId(userDao.getPrimaryKey()+1);
            userDao.addUser(userModel);
        }else{//编辑用户
            userDao.updateUser(userModel);
        }
    }

    @Override
    public UserModel getOneUser(int userId) {
        UserModel userModel = new UserModel();
        userModel.setUserId(userId);
        userModel = userDao.getOneUser(userModel);
        return userModel;
    }
}
