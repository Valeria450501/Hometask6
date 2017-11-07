package com.soapserver.core.dao;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

public interface CitiesDAO {
	@Transactional(
			readOnly = true, 
			rollbackFor = Throwable.class
	)
	
	List<String> getCitiesNames();
}
