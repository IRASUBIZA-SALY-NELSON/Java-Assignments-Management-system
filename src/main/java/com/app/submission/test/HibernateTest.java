package com.app.submission.test;
import org.hibernate.Session;
import com.app.submission.util.HibernateUtil;

public class HibernateTest {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        System.out.println("Hibernate connection successful!");
        session.close();
    }
}
