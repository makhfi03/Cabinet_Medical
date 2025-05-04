package services;

import dao.UserDao;
import entities.User;
import java.util.List;

public class UserService implements IService<User> {
    
    private final UserDao dao;
    
    public UserService() {
        this.dao = new UserDao();
    }
    
    @Override
    public boolean create(User o) {
        return dao.create(o);
    }
    
    @Override
    public boolean delete(User o) {
        return dao.delete(o);
    }
    
    @Override
    public boolean update(User o) {
        return dao.update(o);
    }
    
    @Override
    public List<User> findAll() {
        return dao.findAll();
    }
    
    @Override
    public User findById(int id) {
        return dao.findById(id);
    }
    
    public User findUserByEmail(String email) {
        return dao.findUserByEmail(email);
    }
}
