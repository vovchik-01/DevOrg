public class AnimalLocator {
    
    public static String getAnimalNameById (Integer i) {
        String result ='';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + i);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

         
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> results2 = (Map<String, Object>)results.get('animal');
             result = (String)results2.get('name');
            }
          return result;
       
    }
}