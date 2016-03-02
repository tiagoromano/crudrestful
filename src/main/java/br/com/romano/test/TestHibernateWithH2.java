package br.com.romano.test;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import br.com.romano.model.Product;

public class TestHibernateWithH2 {
	//test
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EntityManagerFactory ef = Persistence.createEntityManagerFactory("crudrestful");
		EntityManager em = ef.createEntityManager();
		Product product = new Product();
		product.setName("mem");
		product.setPrice((float)200.21);
		
		em.getTransaction().begin();
		em.merge(product);
		//em.getTransaction().commit();
		
		Query q = em.createQuery("select product from Product product");
		List<Product> products = q.getResultList();
		em.getTransaction().commit();
		
		
		ef.close();

	}

}
