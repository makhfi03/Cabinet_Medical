package services;

import java.util.List;

/**
 * Interface générique pour les services
 * @param <T> Type de l'entité
 */
public interface IService<T> {
    boolean create(T o);
    boolean delete(T o);
    boolean update(T o);
    List<T> findAll();
    T findById(int id);
}
