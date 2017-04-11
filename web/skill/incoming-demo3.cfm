<!---
  Copyright 2017 - Nick Kwiatkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

  Created by quetwo on 4/9/2017.
--->

<cfscript>

    if (cgi.http_accept EQ "application/json")
    {
        myData = deserializeJSON(ToString(getHTTPRequestData().content));
    }
    else
    {
        myData = "Not JSON";
    }

    myReturn = structNew();
    myReturn['version'] = "1.0";
    myReturn['response'] = structNew();
    myReturn.response['outputSpeech'] = structNew();
    myReturn.response.outputSpeech['type'] = "SSML";

    if(myData.request.intent.name EQ "WhoIsColdFusionIntent")
    {
        if(myData.request.intent.slots.PersonName.value EQ "randy")
        {
            myReturn.response.outputSpeech['ssml'] = "Sure, why not.";
        }
        else
        {
            myReturn.response.outputSpeech['ssml'] = "<speak>Well, let me check. <audio src='https://alexa-demo.suroot.com/skill_assets/Sad.mp3' /> I don't think so.</speak>";
        }
    }
    else
    {
        myReturn.response.outputSpeech['ssml'] = "<speak>Randy Brown is the best programmer in the room</speak>";
    }





</cfscript>

<cfsavecontent variable="writeToDisk">
    <cfdump var="#cgi#">
    <cfdump var="#getHTTPRequestData()#">
    <cfdump var="#toString(getHTTPRequestData().content)#">
    <cfdump var="#myData#">
</cfsavecontent>

<cffile action="write" output="#writeToDisk#" file="/tmp/call.html">

<cfcontent type="application/json"><cfoutput>#serializeJSON(myReturn)#</cfoutput>