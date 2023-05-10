
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 22 (11.0 per locale)
 *
 * Built on 2023-03-29 at 06:47 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.th;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.th) // set locale
/// - Locale locale = AppLocale.th.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.th) // locale check
enum AppLocale {
	th, // 'th' (base locale, fallback)
	en, // 'en'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of AppLocalizations).
///
/// Usage:
/// String a = AppLocalizations.someKey.anotherKey;
/// String b = AppLocalizations['someKey.anotherKey']; // Only for edge cases!
_TranslationsTh _AppLocalizations = _currLocale.translations;
_TranslationsTh get AppLocalizations => _AppLocalizations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final AppLocalizations = Translations.of(context); // Get AppLocalizations variable.
/// String a = AppLocalizations.someKey.anotherKey; // Use AppLocalizations variable.
/// String b = AppLocalizations['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _TranslationsTh of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_AppLocalizations = _currLocale.translations;

		// force rebuild if TranslationProvider is used
		_translationProviderKey.currentState?.setLocale(_currLocale);

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _TranslationsTh _translationsTh = _TranslationsTh.build();
late _TranslationsEn _translationsEn = _TranslationsEn.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_TranslationsTh get translations {
		switch (this) {
			case AppLocale.th: return _translationsTh;
			case AppLocale.en: return _translationsEn;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.th.build(); // build
	/// String a = t.my.path; // access
	_TranslationsTh build() {
		switch (this) {
			case AppLocale.th: return _TranslationsTh.build();
			case AppLocale.en: return _TranslationsEn.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.th: return 'th';
			case AppLocale.en: return 'en';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.th: return const Locale.fromSubtags(languageCode: 'th');
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'th': return AppLocale.th;
			case 'en': return AppLocale.en;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _TranslationsTh translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _TranslationsTh {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsTh.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	late final _TranslationsTh _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsGlobalTh global = _TranslationsGlobalTh._(_root);
}

// Path: global
class _TranslationsGlobalTh {
	_TranslationsGlobalTh._(this._root);

	final _TranslationsTh _root; // ignore: unused_field

	// Translations
	String get data_not_found => 'ไม่พบข้อมูล';
	String get ok => 'ตกลง';
	String get save => 'บันทึก';
	String get cancel => 'ยกเลิก';
	String get camera => 'กล้องถ่ายรูป';
	String get gallery => 'อัลบั้มรูป';
	String get logout => 'ออกจากระบบ';
	String get login => 'เข้าสู่ระบบ';
	String get hi => 'สวัสดี';
	String get search => 'ค้นหา';
	String get not_data_show => 'ไม่มีข้อมูลให้แสดง';
}

// Path: <root>
class _TranslationsEn implements _TranslationsTh {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGlobalEn global = _TranslationsGlobalEn._(_root);
}

// Path: global
class _TranslationsGlobalEn implements _TranslationsGlobalTh {
	_TranslationsGlobalEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get data_not_found => 'ไม่พบข้อมูล';
	@override String get ok => 'ตกลง';
	@override String get save => 'บันทึก';
	@override String get cancel => 'ยกเลิก';
	@override String get camera => 'กล้องถ่ายรูป';
	@override String get gallery => 'อัลบั้มรูป';
	@override String get logout => 'ออกจากระบบ';
	@override String get login => 'เข้าสู่ระบบ';
	@override String get hi => 'สวัสดี';
	@override String get search => 'ค้นหา';
	@override String get not_data_show => 'ไม่มีข้อมูลให้แสดง';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _TranslationsTh {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'global.data_not_found': 'ไม่พบข้อมูล',
			'global.ok': 'ตกลง',
			'global.save': 'บันทึก',
			'global.cancel': 'ยกเลิก',
			'global.camera': 'กล้องถ่ายรูป',
			'global.gallery': 'อัลบั้มรูป',
			'global.logout': 'ออกจากระบบ',
			'global.login': 'เข้าสู่ระบบ',
			'global.hi': 'สวัสดี',
			'global.search': 'ค้นหา',
			'global.not_data_show': 'ไม่มีข้อมูลให้แสดง',
		};
	}
}

extension on _TranslationsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'global.data_not_found': 'ไม่พบข้อมูล',
			'global.ok': 'ตกลง',
			'global.save': 'บันทึก',
			'global.cancel': 'ยกเลิก',
			'global.camera': 'กล้องถ่ายรูป',
			'global.gallery': 'อัลบั้มรูป',
			'global.logout': 'ออกจากระบบ',
			'global.login': 'เข้าสู่ระบบ',
			'global.hi': 'สวัสดี',
			'global.search': 'ค้นหา',
			'global.not_data_show': 'ไม่มีข้อมูลให้แสดง',
		};
	}
}
