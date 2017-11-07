package com.soapserver.core.dao.impl;
import org.springframework.jdbc.core.RowMapper;

import com.soapserver.core.dao.CitiesDAO;
import com.soapserver.core.dao.JdbcExt;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CitiesDAOImpl extends JdbcExt implements CitiesDAO{
	private static final String CITIES_NAMES = "select B.name from gpt_location A join gpt_location_name B join gpt_language C join gpt_location_type D on B.lang_id=C.id and A.id=B.location_id and A.type_id=D.id and D.type_name='city'";
	
		@Override
		public List<String> getCitiesNames() {
			return getJdbcTemplate().query(CITIES_NAMES, new RowMapper<String>() {
				
				@Override
				public String mapRow(ResultSet rs, int index) throws SQLException {
					return rs.getString("name");
				}
				
			});
	}
}