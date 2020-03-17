package com.test.user.controller;

import com.test.user.model.UserModel;
import com.test.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * @description 展示所有用户列表
     * @param  currentPage 当前页码
     * @return
     * @date 2020/3/13 14:09
     * @author tangyy
     */
    @RequestMapping(value = "/listAllUsers.do")
    public String listAllUsers(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage, Model model,UserModel userModel){
        //List<UserModel> userList = userService.findAllUsers();
        model.addAttribute("userList", userService.findByPage(currentPage,userModel));
        //model.addAttribute("userList",userList);
        return "userList";
    }

    /**
     * @description 跳转到新增或者编辑用户页面
     * @param  userId 编辑用户时需要的用户id
     * @return
     * @date 2020/3/16 9:45
     * @author tangyy
     */
    @RequestMapping(value = "/editOrAddUser.do")
    public String editOrAddUser(@RequestParam(value="userId")int userId, Model model){
//        System.out.println(userId);
        model.addAttribute("userModel", userService.getOneUser(userId));
        return "editUser";
    }

    /**
     * @description 保存用户信息
     * @param  userModel 传递用户信息
     * @return
     * @date 2020/3/13 14:10
     * @author tangyy
     */
    @RequestMapping(value = "/saveUser.do")
    @ResponseBody
    public Map<String,String> saveUser(UserModel userModel){
        Map<String,String> map = new HashMap<String, String>();
        try{
            userService.saveUser(userModel);
            map.put("result","提交成功");
        } catch (Exception e){
            map.put("result","提交失败");
        }
        return map;
    }

    /**
     * @description 删除用户
     * @param  userModel 传递用户id
     * @return
     * @date 2020/3/13 14:10
     * @author tangyy
     */
    @RequestMapping(value = "/deleteUser.do")
    @ResponseBody
    public Map<String,String> deleteUser(UserModel userModel){
        Map<String,String> map = new HashMap<String, String>();
        try{
            userService.deleteUser(userModel);
            map.put("result","提交成功");
        } catch (Exception e){
            map.put("result","提交失败");
        }
        return map;
    }
}

