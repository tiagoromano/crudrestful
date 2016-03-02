package br.com.romano.crudrestful;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import br.com.romano.model.*;
import br.com.romano.service.ProductService;

/**
 * Root resource (exposed at "myresource" path)
 */
@Path("myresource")
public class MyResource {
	
	private ProductService service;
	
	public MyResource() {
		service = new ProductService();
	}

    
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() {
        return "Hello world timalhado!";
    }
    
   
    @GET
	@Path("/getAll")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Product> getAll() {
		return service.getAll();
	}
    
    @POST	
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)	
	@Path("/create")
	public Product create(Product p) {							    	
    	service.save(p);
    	return p;
	}
    
    @DELETE		
	@Path("/delete/{id}")
	public void delete(@PathParam("id") int id) {		
    	service.remove(id);
	}
}
