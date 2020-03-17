import com.test.user.dao.UserDao;
import com.test.user.model.UserModel;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class UserDaoTest extends  UserTest{
    @Autowired
    private UserDao userDao;
    @Test
    public void findAllUsers() throws Exception {
//        List<UserModel> userList = userDao.findAllUsers();
//        if(userList.size() != 0){
//            System.out.println(userList.get(0).getUserName());
//        }
    }
}
