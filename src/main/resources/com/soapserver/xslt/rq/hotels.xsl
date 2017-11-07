<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ent="http://soapserver.com/entities"
	xmlns:requtil="http://xml.apache.org/xalan/java/com.soapserver.core.helpers.RequestUtil"
	exclude-result-prefixes="ent requtil">
	
	<xsl:output method="text"/>
	
	<xsl:template match="/">
		<xsl:variable name="countryCode" select="ent:HotelsRequest/ent:Location/ent:Country/ent:Code"/>
		<xsl:variable name="languageCode" select="ent:HotelsRequest/ent:Language"/>
		<xsl:variable name="cityName" select="ent:HotelsRequest/ent:Location/ent:Country/ent:City/ent:Name"/>
		<xsl:variable name="hotelCategory" select="ent:HotelsRequest/ent:HotelInfo/ent:Category"/>
		<xsl:variable name="hotelName" select="ent:HotelsRequest/ent:HotelInfo/ent:HotelName"/>
		
		<xsl:text>select E.id as hotel_id, A.code as code, B.name as name, F.name as hotel_name, E.phone as hotel_phone, E.fax as hotel_fax, </xsl:text>
		<xsl:text>E.code as hotel_code, E.email as hotel_email, E.url as hotel_url, E.check_in as hotel_check_in, E.check_out as hotel_check_out, </xsl:text>
		<xsl:text>E.latitude as hotel_latitude, E.longitude as hotel_longitude </xsl:text>
		<xsl:text>from gpt_location A </xsl:text>
		<xsl:text>join gpt_location_name B </xsl:text>
		<xsl:text>join gpt_language C </xsl:text>
		<xsl:text>join gpt_location_type D </xsl:text>
		<xsl:text>join gpt_hotel E </xsl:text>
		<xsl:text>join gpt_hotel_name F </xsl:text>
		<xsl:text>on C.Id = B.lang_id and F.lang_id=C.id and F.hotel_id=E.id and B.location_id=A.id</xsl:text>
		<xsl:if test="string-length($languageCode) &gt; 0">
			<xsl:text> and C.code="</xsl:text>
			<xsl:value-of select="$languageCode"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:if test="string-length($hotelCategory) &gt; 0">
			<xsl:text> and E.CATEGORY_ID="</xsl:text>
			<xsl:value-of select="$hotelCategory"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:if test="string-length($hotelName) &gt; 0">
			<xsl:text> and F.name like '%</xsl:text>
			<xsl:value-of select="$hotelName"/>
			<xsl:text>%'</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="string-length($cityName) &gt; 0">
				<xsl:text> and D.type_name='city' and E.city_id=A.id and B.name="</xsl:text>
				<xsl:value-of select="$cityName"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise test="string-length($countryCode) &gt; 0">
				<xsl:text> and A.id = B.location_id and D.type_name='country' and A.Code="</xsl:text>
				<xsl:value-of select="$countryCode"/>
				<xsl:text>"</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
			
	</xsl:template>
	
</xsl:stylesheet>