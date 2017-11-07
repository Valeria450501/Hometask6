package com.soapserver.core.filters.impl;

import java.util.List;

import com.soapserver.core.dao.CitiesDAO;
import com.soapserver.core.filters.PreFilter;
import com.soapserver.core.processors.ServiceException;
import com.soapserver.entities.HotelsRequest;


public class CheckCitiesFilter implements PreFilter<HotelsRequest> {
	
	private CitiesDAO citiesDAO;
	
	@Override
	public boolean isApplicable(final HotelsRequest request) {
		return true;
	}

	@Override
	public void preProcess(final HotelsRequest request) throws ServiceException {
		if (request.getLocation().getCountry().getCity() != null) {
			final List<String> citiesNames = citiesDAO.getCitiesNames();
			if (!citiesNames.contains(request.getLocation().getCountry().getCity())) {
				throw new ServiceException("Requested city name is incorrect");
			}
		}
	}
	
	public void setCountriesDAO(CitiesDAO citiesDAO) {
		this.citiesDAO = citiesDAO;
	}

}
