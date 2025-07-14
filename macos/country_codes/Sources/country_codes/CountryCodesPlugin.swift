
import Cocoa
import FlutterMacOS

public class CountryCodesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "country_codes", binaryMessenger: registrar.messenger)
    let instance = CountryCodesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  switch call.method {
  case "getRegion":
    if #available(macOS 13, *) {
      result(Locale.current.region?.identifier ?? "")
    } else {
      result(Locale.current.regionCode ?? "")
    }
    break
  case "getLanguage":
    if #available(macOS 13, *) {
      result(Locale.current.language.languageCode?.identifier ?? "")
    } else {
      result(Locale.current.languageCode ?? "")
    }
    break
  case "getLocale":
    if #available(macOS 13, *) {
      result([
        Locale.current.language.languageCode?.identifier as Any,
        Locale.current.region?.identifier as Any,
        getLocalizedCountryNames(localeTag: call.arguments as? String)
      ])
    } else {
      result([
        Locale.current.languageCode as Any,
        Locale.current.regionCode as Any,
        getLocalizedCountryNames(localeTag: call.arguments as? String)
      ])
    }
    break
  default:
    result(FlutterMethodNotImplemented)
  }
}

  func getLocalizedCountryNames(localeTag: String?) -> Dictionary<String, String> {
    var localizedCountries: [String: String] = [:]
    for countryCode in NSLocale.isoCountryCodes {
      let locale = NSLocale(localeIdentifier: localeTag ?? Locale.preferredLanguages[0])
      let countryName = locale.displayName(forKey: .countryCode, value: countryCode)
      localizedCountries[countryCode.uppercased()] = countryName ?? ""
    }
    return localizedCountries
  }
}