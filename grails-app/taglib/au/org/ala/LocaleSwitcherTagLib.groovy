package au.org.ala

import javax.servlet.http.HttpServletRequest

class LocaleSwitcherTagLib {

    static namespace = 'locale'     // namespace for headers and footers

    def locales = ["pt_PT", "en"]

    def switchLocale = {  attrs ->

        def url_pt = getCurrentUrl(request, "pt_PT")
        def url_en = getCurrentUrl(request, "en")

        out << "<li><a style='width:20px !important;' href='${url_pt}'><img src='http://www.gbif.pt/sites/all/modules/languageicons/flags/pt-pt.png' /></a></li>"
        out << "<li><a style='width:20px !important;' href='${url_en}'><img src='http://www.gbif.pt/sites/all/modules/languageicons/flags/en.png' /></a></li>"
    }

    String getCurrentUrl(HttpServletRequest request, String locale){

        StringBuilder sb = new StringBuilder()

        sb << request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        sb << request.getAttribute("javax.servlet.forward.request_uri")


        def queryStr = request.getAttribute("javax.servlet.forward.query_string")
        if(queryStr){
            sb << "?"
            locales.each {
                queryStr = queryStr.replaceAll("lang=" + it, "")
            }
            sb << queryStr
        }

        if(queryStr){
            sb << "&lang=${locale}"
        } else {
            sb << "?lang=${locale}"
        }
        return sb.toString();
    }
}
