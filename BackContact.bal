import ballerina/io;
import marcus/gcontacts3;
import wso2/gsheets4;
import ballerina/config;

endpoint gcontacts3:Client gContactsEP {
    clientConfig:{
        auth:{
            accessToken:config:getAsString("ACCESS_TOKEN"),
            clientId:config:getAsString("CLIENT_ID"),
            clientSecret:config:getAsString("CLIENT_SECRET"),
            refreshToken:config:getAsString("REFRESH_TOKEN")
        }
    }
};

endpoint gsheets4:Client spreadsheetEP {
    clientConfig:{
        auth:{
            clientId:config:getAsString("CLIENT_ID"),
            clientSecret:config:getAsString("CLIENT_SECRET"),
            refreshToken:config:getAsString("REFRESH_TOKEN")
        }
    }
};

function main(string... args) {
    string userEmail = "default";
    string[][] contactDetailsArray;
    string spreadsheetId = "1YrRVHMwnHMSAsxX7zwHoOBqM3MfxP4vM1tDudblDWt8";

    var response = gContactsEP -> getAllContacts(userEmail);
    //var responseSpread = spreadsheetEP -> openSpreadsheetById(spreadsheetId);

    match response {
        xml xmlRes => {
            string name = xmlRes.elements().getTextValue();
            io:println(name);
        }
        error err => {
            io:println(err);
        }
    }
}