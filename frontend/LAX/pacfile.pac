// V2.4
// ADM Pilot Proxy Server auto-configuration file
// 

// Default proxy servers in order of preference.  If modified, use the following syntax as an example.  If syntax is incorrect, the browser will default to deny. 
var proxy = "PROXY 57.47.169.105 8080";


// Default localhost for denied connections
var deny = "PROXY 127.0.0.1:65535";

// Bypass the proxy server and try to connect directly via local network
var bypass = "DIRECT";

function FindProxyForURL(url, host)
{
//
//remarks
//
     if	(
  	 shExpMatch(host, "*.adaptiva.cloud*")
	 || shExpMatch(host, "*.resolver1.opendns.com*")
	 || shExpMatch(host, "*.adm-adaptiva.switzerlandnorth.cloudapp.azure.com*")	 
	 || shExpMatch(host, "*.myip.opendns.com*")
	 || shExpMatch(host, "*.dl.delivery.mp.microsoft.com*")
	 || shExpMatch(host, "*.emdl.ws.microsoft.com*")	
	 || shExpMatch(host, "*.prod.do.dsp.mp.microsoft.com*")
	 || shExpMatch(host, "*.do.dsp.mp.microsoft.com*")	 
	 || shExpMatch(host, "*.geover-prod.do.dsp.mp.microsoft.com*")
	 || shExpMatch(host, "*.geo-prod.do.dsp.mp.microsoft.com*")
	 || shExpMatch(host, "*.sita.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-1.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-2.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-3.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-4.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-5.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-6.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-7.eu.nexthink.cloud*")
	 || shExpMatch(host, "*.sita-engine-8.eu.nexthink.cloud*")	 
	 || shExpMatch(host, "*.login.live.com*")
	 || shExpMatch(host, "*.login.microsoftonline.com*")		 
	 || shExpMatch(host, "*.aadcdn.msftauth.net*")	
	 || shExpMatch(host, "*.aadcdn.msauth.net*")	 
	 || shExpMatch(host, "*.servicegateway.service-now.com*")	 
	 || shExpMatch(host, "*.download.windowsupdate.com*")
	 || shExpMatch(host, "*.update.microsoft.com*")
	 || shExpMatch(host, "*.windowsupdate.com*")
	 || shExpMatch(host, "*.windowsupdate.microsoft.com*")
	 || shExpMatch(host, "*.ws.microsoft.com*")
	 || shExpMatch(host, "*.download.microsoft.com*")	 
	 || shExpMatch(host, "*.ntservicepack.microsoft.com*")	 
	 || shExpMatch(host, "*.wustat.windows.com*")
	 || shExpMatch(host, "*.data.vmwservices.com*")	
	 || shExpMatch(host, "*.digicert.com*")
	 || shExpMatch(host, "*.notify.windows.com*")	 
	 || shExpMatch(host, "*.wns.windows.com*")
	 || shExpMatch(host, "*.notify.live.net*")
	 || shExpMatch(host, "*.as*.awmdm.com*")
	 || shExpMatch(host, "*.rmausession01.awmdm.com*")
	 || shExpMatch(host, "*.rmau01.awmdm.com*")
	 || shExpMatch(host, "*.awcm1750.awmdm.com*")
	 || shExpMatch(host, "*.bspmts.mp.microsoft.com*")	 
	 || shExpMatch(host, "*.rmcasession01.awmdm.com*")
	 || shExpMatch(host, "*.rmca01.awmdm.com*")
	 || shExpMatch(host, "*.CDN*.awmdm.com*")	 
	 || shExpMatch(host, "*.ekcert.spserv.microsoft.com*")
	 || shExpMatch(host, "*.ekop.intel.com/ekcertservice*")
	 || shExpMatch(host, "*.rmdesession01.awmdm.com*")
	 || shExpMatch(host, "*.rmde01.awmdm.com*")
	 || shExpMatch(host, "*.has.spserv.microsoft.com*")
	 || shExpMatch(host, "*.inference.location.live.net*")
	 || shExpMatch(host, "*.rmjpsession01.awmdm.com*")
	 || shExpMatch(host, "*.rmjp01.awmdm.com*")
	 || shExpMatch(host, "*.sita-adm-device.awmdm.com*")	 
	 || shExpMatch(host, "*.rmuksession01.awmdm.com*")
	 || shExpMatch(host, "*.rmuk01.awmdm.com*")
	 || shExpMatch(host, "*.rmsession01.awmdm.com*")
	 || shExpMatch(host, "*.rm01.awmdm.com*")	 
	 || shExpMatch(host, "*.awmdm.com*")
	 || shExpMatch(host, "*.vmservices.com*")
	 || shExpMatch(host, "*.help.esp.aero*")	 
	 || shExpMatch(host, "*.azure.api.net*")
	 || shExpMatch(host, "*.azure-api.net*")
	 || shExpMatch(host, "*.windows.net*")
	 || shExpMatch(host, "*.azure.com*")
	 || shExpMatch(host, "*.sita.aero*")	 
	 || shExpMatch(host, "*.azurefd.net*")
	 || shExpMatch(host, "*.azure.microsoft.com*")
	 || shExpMatch(host, "*.azure-devices.net*")
	 || shExpMatch(host, "*.azuredns-cloud.net*")
	 || shExpMatch(host, "*.azurehdinsight.net*")
	 || shExpMatch(host, "*.azure-mobile.net*")
	 || shExpMatch(host, "*.azurewebsites.net*")
	 || shExpMatch(host, "*.cloudapp.net*")
	 || shExpMatch(host, "*.clouddatahub.net*")
	 || shExpMatch(host, "*.core.windows.net*")
	 || shExpMatch(host, "*.devices.windows.com*")
	 || shExpMatch(host, "*.microsoftonline.com*")
	 || shExpMatch(host, "*.microsoftonline-p.com*")
	 || shExpMatch(host, "*.service.signalr.net*")
	 || shExpMatch(host, "*.servicebus.windows.net*")
	 || shExpMatch(host, "*.trafficmanager.net*")
	 || shExpMatch(host, "*.windows.net*")
	 || shExpMatch(host, "*.windowsazure.com*")
	 || shExpMatch(host, "*.sitaflex.aero*")
	 || shExpMatch(host, "*.aa.com*")
	
    	)
	 // If the host is defined return the proxy list, else bypass the proxy and try to connect via local network. 
	{ return "PROXY 57.47.169.105 8080";
	}
		else 
	 {return "DIRECT";
	 }
}