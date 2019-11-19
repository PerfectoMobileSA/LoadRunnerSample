/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 *                     
 */

import lrapi.lr;
import java.io.*;
import java.net.*;
import java.util.*;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.*;
import org.openqa.selenium.html5.*;
import org.openqa.selenium.logging.*;
import org.openqa.selenium.remote.*;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.Cookie.Builder;

import io.appium.java_client.*;
import io.appium.java_client.android.*;
import io.appium.java_client.ios.*;

public class Actions
{

	public int init() throws Throwable {
		return 0;
	}//end of init


	public int action() throws Throwable {
		System.out.println("Run started");
        
        String browserName = "mobileOS";
        DesiredCapabilities capabilities = new DesiredCapabilities(browserName, "", Platform.ANY);
        String host = "demo.perfectomobile.com";
        capabilities.setCapability("securityToken",
				"TOKEN");
		
        
        //TODO: Change your device ID
        capabilities.setCapability("deviceName", "DEVICEID");
        
        // Use the automationName capability to define the required framework - Appium (this is the default) or PerfectoMobile.
        capabilities.setCapability("automationName", "Appium");

        
        //AndroidDriver driver = new AndroidDriver(new URL("https://" + host + "/nexperience/perfectomobile/wd/hub"), capabilities);
        IOSDriver driver = new IOSDriver(new URL("https://" + host + "/nexperience/perfectomobile/wd/hub"), capabilities);
        driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
        
        try {
        	lr.start_transaction("Navigate to Google");
        	navigateToPage(driver,"https://www.google.com");
        	lr.end_transaction("Navigate to Google", lr.AUTO);
        	
        	lr.start_transaction("Search Perfecto");
    		setText(driver, By.name("q"), "perfecto");
    		lr.end_transaction("Search Perfecto", lr.AUTO);
    		
    		setText(driver, By.name("q"), "sauce");
    		setText(driver, By.name("q"), "selenium");
    		setText(driver, By.name("q"), "appium");
    		setText(driver, By.name("q"), "automation");
        	//uxTimer(driver, "automation");

        	//lr.start_transaction("Launch Website");
        	//lr.end_transaction("Launch Website", lr.AUTO);
        } catch (Exception e) {
            
        } finally {
            try {
                driver.quit();
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        System.out.println("Run ended");
        return 0;
	}//end of action


	public int end() throws Throwable {
		return 0;
	}//end of end
	
    
	public void click(RemoteWebDriver driver, By by) {
		WebElement element = new WebDriverWait(driver, 30).until(ExpectedConditions.elementToBeClickable(by));
		element.click();
	}
	public String getTextOCR(RemoteWebDriver driver, String needle) {
		Map<String, Object> params = new HashMap<>();
		params.put("content", needle);
		params.put("timeout", "20");
		String resultString = (String) driver.executeScript("mobile:checkpoint:text", params);
		return resultString;
	}
	public static void setText(RemoteWebDriver driver, By by, String text) {
		WebElement element = new WebDriverWait(driver, 30).until(ExpectedConditions.elementToBeClickable(by));
		element.click();
		element.clear();
		element.sendKeys(text);
	}
	public static void navigateToPage(RemoteWebDriver driver, String url) {
		driver.get(url);
	}
	
	public String startApp(RemoteWebDriver driver, String identifier) {
		Map<String, Object> params = new HashMap<>();
		params.put("identifier", identifier);
		String resultString = (String) driver.executeScript("mobile:application:open", params);
		return resultString;
	}
	
	public String closeApp(RemoteWebDriver driver, String identifier) {
		Map<String, Object> params = new HashMap<>();
		params.put("identifier", identifier);
		String resultString = (String) driver.executeScript("mobile:application:close", params);
		return resultString;
	}

	public static void clickText(RemoteWebDriver driver, String text) {
		Map<String, Object> params = new HashMap<>();
		params.put("content", text);
		params.put("timeout", "20");
		String resultString = (String) driver.executeScript("mobile:text:select", params);

	}
	
	public static void uxTimer(RemoteWebDriver driver, String timerName) {
		Map<String, Object> params = new HashMap<>();
		params = new HashMap<>();
		params.put("timerId", timerName);
		params.put("timerType", "ux");
		long timeEx = (long) driver.executeScript("mobile:timer:info", params);
		lr.set_transaction(timerName, timeEx, lr.PASS);
	}
	
		public static void uxTimer(RemoteWebDriver driver, String timerName, long thresold) {
		Map<String, Object> params = new HashMap<>();
		params = new HashMap<>();
		params.put("timerId", timerName);
		params.put("timerType", "ux");
		long timeEx = (long) driver.executeScript("mobile:timer:info", params);
		if (timeEx > thresold) {
			lr.set_transaction(timerName, timeEx, lr.FAIL);
		} else {
			lr.set_transaction(timerName, timeEx, lr.PASS);
		}
	}
	
	
	
	

}
