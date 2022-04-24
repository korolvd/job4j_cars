package ru.job4j.car.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.car.model.Post;

import java.util.List;
import java.util.function.Function;

public class AdRepository {

    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    private final String queryPostsFetch = "select distinct p from Post p "
            + "join fetch p.car c "
            + "join fetch p.user "
            + "join fetch c.brand "
            + "join fetch c.body "
            + "join fetch c.engine "
            + "join fetch c.users ";

    public List<Post> findPostsByLastDay() {
        return transaction(session -> session.createQuery(
                queryPostsFetch
                        + "where p.created >= current_date ", Post.class
        ).list());
    }

    public List<Post> findPostsWithPhoto() {
        return transaction(session -> session.createQuery(
                queryPostsFetch
                        + "where p.photo is not null", Post.class
        ).list());
    }

    public List<Post> findPostsByBrand(int brandId) {
        return transaction(session -> session.createQuery(
                queryPostsFetch
                        + "where c.brand.id = :sId", Post.class
        ).setParameter("sId", brandId).list());
    }

    private <T> T transaction(final Function<Session, T> command) {
        final Session session = sf.openSession();
        final Transaction transaction = session.beginTransaction();
        try {
            T rsl = command.apply(session);
            transaction.commit();
            return rsl;
        } catch (final Exception e) {
            session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
