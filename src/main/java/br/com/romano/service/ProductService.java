package br.com.romano.service;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import br.com.romano.model.Product;


public class ProductService {
	
	static{ try { DriverManager.registerDriver(new org.h2.Driver()); } catch (SQLException e) { e.printStackTrace(); } } 
	
	EntityManagerFactory ef;
	EntityManager em;
	
	public ProductService(){
		ef = Persistence.createEntityManagerFactory("crudrestful");
		em = ef.createEntityManager();
	}
	
	public void save(Product p) {
		em.getTransaction().begin();
		em.merge(p);
		em.getTransaction().commit();
		ef.close();
	}
	
	public void remove(int id) {
		em.getTransaction().begin();
		Product p = em.find(Product.class, id);	
		em.remove(p);
		em.getTransaction().commit();
		ef.close();
	}
		
	public List<Product> getAll() {
		em.getTransaction().begin();
		Query q = em.createQuery("select product from Product product");
		List<Product> products = q.getResultList();
		em.getTransaction().commit();
		ef.close();
		return products;
	}
	
	public Product getById(int id) {
		em.getTransaction().begin();
		Product product = em.find(Product.class, id);			
		em.getTransaction().commit();
		ef.close();
		return product;
	}
}
