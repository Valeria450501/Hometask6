<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ent="http://soapserver.com/entities"
	xmlns:sutil="http://xml.apache.org/xalan/java/com.soapserver.core.helpers.StringUtil"
	xmlns:queryutil="http://xml.apache.org/xalan/java/com.soapserver.core.helpers.SqlQueriesUtil"
	exclude-result-prefixes="ent sutil queryutil">
	
	<xsl:output method="xml"/>
	
	<xsl:template match="/">
		<xsl:variable name="locations" select="queryutil:subQuery('select id, code from gpt_location')"/>
				
		<ent:HotelsResponse>
			<xsl:for-each select="Result/Entry">
				<xsl:variable name="countryCode" select="code"/>				
				<!-- xsl:variable name="trr" select="string($locations/Entry[code = $countryCode]/id)"/-->
				<xsl:variable name="HotelName" select="hotel_name"/>
				<xsl:variable name="HotelCode" select="hotel_code"/>
				<xsl:variable name="HotelPhone" select="hotel_phone"/>
				<xsl:variable name="HotelFax" select="hotel_fax"/>
				<ent:Country>
					<ent:Name>
						<xsl:value-of select="name"/>
					</ent:Name>
					<ent:Code>
						<xsl:value-of select="code"/>
					</ent:Code>
				</ent:Country>	
				
				<ent:Hotels>
					<ent:Hotel Code="{$HotelCode}">
						<ent:Name>
							<xsl:value-of select="$HotelName"/>
						</ent:Name>					
						<ent:Phone>
							<xsl:value-of select="$HotelPhone"/>
						</ent:Phone>
						<ent:Fax>
							<xsl:value-of select="$HotelFax"/>
						</ent:Fax>
						<ent:Email>
							<xsl:value-of select="hotel_email"></xsl:value-of>
						</ent:Email>
						<ent:Url>
							<xsl:value-of select="hotel_url"></xsl:value-of>
						</ent:Url>
						<ent:Check_in>
							<xsl:value-of select="hotel_check_in"></xsl:value-of>
						</ent:Check_in>
						<ent:Check_out>
							<xsl:value-of select="hotel_check_out"></xsl:value-of>
						</ent:Check_out>
						<ent:Coordinates>
							<ent:Latitude>
								<xsl:value-of select="hotel_latitude"/>
							</ent:Latitude>
							<ent:Longitude>
								<xsl:value-of select="hotel_longitude"/>
							</ent:Longitude>						
						</ent:Coordinates>
					</ent:Hotel>
				</ent:Hotels>
			</xsl:for-each>
		</ent:HotelsResponse>
	</xsl:template>
	
</xsl:stylesheet>