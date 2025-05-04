package dao;

import java.util.List;

/**
 * Interface générique pour les opérations CRUD de base
 * @param <T> Type de l'entité
 */
public interface IDao<T> {
    boolean create(T o);
    boolean delete(T o);
    boolean update(T o);
    List<T> findAll();
    T findById(int id);
}
