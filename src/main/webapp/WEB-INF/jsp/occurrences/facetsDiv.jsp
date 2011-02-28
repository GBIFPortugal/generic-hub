<%-- 
    Document   : facetsDiv
    Created on : Feb 24, 2011, 11:39:45 AM
    Author     : "Nick dos Remedios <Nick.dosRemedios@csiro.au>"
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<div id="SidebarBox">
    <div class="sidebar">
        <h3>Refine Results</h3>
    </div>
    <div class="sidebar">
        <c:if test="${not empty searchResults.query}">
            <c:set var="queryParam">q=<c:out value="${param['q']}" escapeXml="true"/><c:if test="${not empty param.fq}">&fq=${fn:join(paramValues.fq, "&fq=")}</c:if>
            </c:set>
        </c:if>
        <c:if test="${not empty facetMap}">
            <h4><span class="FieldName">Current Filters</span></h4>
            <div id="subnavlist">
                <ul>
                    <c:forEach var="item" items="${facetMap}">
                        <li>
                        <c:set var="closeLink">&nbsp;[<b><a href="#" onClick="removeFacet('${item.key}:${item.value}'); return false;" class="removeLink" title="remove">X</a></b>]</c:set>
                        <fmt:message key="facet.${item.key}"/>:
                        <c:choose>
                            <c:when test="${fn:containsIgnoreCase(item.key, 'month')}">
                                <b><fmt:message key="month.${item.value}"/></b>${closeLink}
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(item.key, 'occurrence_date') && fn:startsWith(item.value, '[*')}">
                                <c:set var="endYear" value="${fn:substring(item.value, 6, 10)}"/><b>Before ${endYear}</b>${closeLink}
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(item.key, 'occurrence_date') && fn:endsWith(item.value, '*]')}">
                                <c:set var="startYear" value="${fn:substring(item.value, 1, 5)}"/><b>After ${startYear}</b>${closeLink}
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(item.key, 'occurrence_date') && fn:endsWith(item.value, 'Z]')}">
                                <c:set var="startYear" value="${fn:substring(item.value, 1, 5)}"/><b>${startYear} - ${startYear + 10}</b>${closeLink}
                            </c:when>
                            <c:otherwise>
                                <b><fmt:message key="${item.value}"/></b>${closeLink}
                            </c:otherwise>
                        </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        <c:forEach var="facetResult" items="${searchResults.facetResults}">
            <c:if test="${fn:length(facetResult.fieldResult) > 0 && empty facetMap[facetResult.fieldName]}"> <%-- || not empty facetMap[facetResult.fieldName] --%>
                <h4><span class="FieldName"><fmt:message key="facet.${facetResult.fieldName}"/></span></h4>
                <div id="subnavlist">
                    <ul>
                        <c:set var="lastElement" value="${facetResult.fieldResult[fn:length(facetResult.fieldResult)-1]}"/>
                        <c:if test="${lastElement.label eq 'before' && lastElement.count > 0}">
                            <li><c:set var="firstYear" value="${fn:substring(facetResult.fieldResult[0].label, 0, 4)}"/>
                            <a href="?${queryParam}&fq=${facetResult.fieldName}:[* TO ${facetResult.fieldResult[0].label}]">Before ${firstYear}</a>
                            (<fmt:formatNumber value="${lastElement.count}" pattern="#,###,###"/>)
                            </li>
                        </c:if>
                        <c:forEach var="fieldResult" items="${facetResult.fieldResult}" varStatus="vs"> <!-- ${facetResult.fieldName} -->
                            <c:if test="${fieldResult.count > 0}">
                                <c:set var="dateRangeTo"><c:choose><c:when test="${vs.last || facetResult.fieldResult[vs.count].label=='before'}">*</c:when><c:otherwise>${facetResult.fieldResult[vs.count].label}</c:otherwise></c:choose></c:set>
                                <c:choose>
                                    <c:when test="${fn:containsIgnoreCase(facetResult.fieldName, 'occurrence_date') && fn:endsWith(fieldResult.label, 'Z')}">
                                        <li><c:set var="startYear" value="${fn:substring(fieldResult.label, 0, 4)}"/>
                                        <a href="?${queryParam}&fq=${facetResult.fieldName}:[${fieldResult.label} TO ${dateRangeTo}]">${startYear} - ${startYear + 10}</a>
                                        (<fmt:formatNumber value="${fieldResult.count}" pattern="#,###,###"/>)</li>
                                    </c:when>
                                    <c:when test="${fn:containsIgnoreCase(facetResult.fieldName, 'data_resource')}">
                                        <li><a href="?${queryParam}&fq=${facetResult.fieldName}:${fieldResult.label}"><fmt:message key="${fn:replace(fieldResult.label, ' provider for OZCAM', '')}"/></a>
                                            (<fmt:formatNumber value="${fieldResult.count}" pattern="#,###,###"/>)</li>
                                    </c:when>
                                    <c:when test="${fn:containsIgnoreCase(facetResult.fieldName, 'institution_code_name')}">
                                        <li><a href="?${queryParam}&fq=${facetResult.fieldName}:${fn:replace(fieldResult.label, ',', '%2C')}"><fmt:message key="${fn:replace(fieldResult.label, ',', ',')}"/></a>
                                            (<fmt:formatNumber value="${fieldResult.count}" pattern="#,###,###"/>)</li>
                                    </c:when>
                                    <c:when test="${fn:endsWith(fieldResult.label, 'before')}"><%-- skip, otherwise gets inserted at bottom, not top of list --%></c:when>
                                    <c:when test="${fn:containsIgnoreCase(facetResult.fieldName, 'month')}">
                                        <li><a href="?${queryParam}&fq=${facetResult.fieldName}:${fieldResult.label}"><fmt:message key="month.${not empty fieldResult.label ? fieldResult.label : 'unknown'}"/></a>
                                            (<fmt:formatNumber value="${fieldResult.count}" pattern="#,###,###"/>)</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="?${queryParam}&fq=${facetResult.fieldName}:${fieldResult.label}"><fmt:message key="${not empty fieldResult.label ? fieldResult.label : 'unknown'}"/></a>
                                            (<fmt:formatNumber value="${fieldResult.count}" pattern="#,###,###"/>)</li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div><!--end facets-->