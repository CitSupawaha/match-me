import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Match Me'**
  String get appTitle;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @thai.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get thai;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Match Me'**
  String get welcomeMessage;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @yourNextMatch.
  ///
  /// In en, this message translates to:
  /// **'Your Next Match'**
  String get yourNextMatch;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Your Performance'**
  String get performance;

  /// No description provided for @courtsNearby.
  ///
  /// In en, this message translates to:
  /// **'Courts Nearby'**
  String get courtsNearby;

  /// No description provided for @recommendedMatches.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommendedMatches;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @winRate.
  ///
  /// In en, this message translates to:
  /// **'Win Rate'**
  String get winRate;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get match;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @matchResults.
  ///
  /// In en, this message translates to:
  /// **'Match Results'**
  String get matchResults;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @ago.
  ///
  /// In en, this message translates to:
  /// **'ago'**
  String get ago;

  /// No description provided for @rallies.
  ///
  /// In en, this message translates to:
  /// **'Rallies'**
  String get rallies;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @smashes.
  ///
  /// In en, this message translates to:
  /// **'Smashes'**
  String get smashes;

  /// No description provided for @createNextGame.
  ///
  /// In en, this message translates to:
  /// **'Create Next Game'**
  String get createNextGame;

  /// No description provided for @court.
  ///
  /// In en, this message translates to:
  /// **'Court'**
  String get court;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Marcus'**
  String get greeting;

  /// No description provided for @readyToPlay.
  ///
  /// In en, this message translates to:
  /// **'Ready to strike?'**
  String get readyToPlay;

  /// No description provided for @eloScore.
  ///
  /// In en, this message translates to:
  /// **'ELO Score'**
  String get eloScore;

  /// No description provided for @played.
  ///
  /// In en, this message translates to:
  /// **'Played'**
  String get played;

  /// No description provided for @hoursPerWeek.
  ///
  /// In en, this message translates to:
  /// **'hours / week'**
  String get hoursPerWeek;

  /// No description provided for @playFrequency.
  ///
  /// In en, this message translates to:
  /// **'Play Frequency'**
  String get playFrequency;

  /// No description provided for @weekTrend.
  ///
  /// In en, this message translates to:
  /// **'{value} this week'**
  String weekTrend(Object value);

  /// No description provided for @findNewCourts.
  ///
  /// In en, this message translates to:
  /// **'Find New Courts'**
  String get findNewCourts;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get openMap;

  /// No description provided for @courtsOpenToday.
  ///
  /// In en, this message translates to:
  /// **'{count} courts open today'**
  String courtsOpenToday(Object count);

  /// No description provided for @matchDetails.
  ///
  /// In en, this message translates to:
  /// **'View Match Details'**
  String get matchDetails;

  /// No description provided for @spotsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} spots left'**
  String spotsLeft(Object count);

  /// No description provided for @joinMatch.
  ///
  /// In en, this message translates to:
  /// **'Join Match'**
  String get joinMatch;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @friendsPlaying.
  ///
  /// In en, this message translates to:
  /// **'+{count} friends are playing'**
  String friendsPlaying(Object count);

  /// No description provided for @startInMinutes.
  ///
  /// In en, this message translates to:
  /// **'Starts in {count} mins'**
  String startInMinutes(Object count);

  /// No description provided for @yourPerformance.
  ///
  /// In en, this message translates to:
  /// **'Your Performance'**
  String get yourPerformance;

  /// No description provided for @comparedToLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Vs last month {value}'**
  String comparedToLastMonth(Object value);

  /// No description provided for @exploreMatches.
  ///
  /// In en, this message translates to:
  /// **'Explore Matches'**
  String get exploreMatches;

  /// No description provided for @searchCourtsOrClubs.
  ///
  /// In en, this message translates to:
  /// **'Search courts or clubs...'**
  String get searchCourtsOrClubs;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @skillLevel.
  ///
  /// In en, this message translates to:
  /// **'Skill Level'**
  String get skillLevel;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @perPlayer.
  ///
  /// In en, this message translates to:
  /// **'PER PLAYER'**
  String get perPlayer;

  /// No description provided for @mapView.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapView;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvanced;

  /// No description provided for @hostMatch.
  ///
  /// In en, this message translates to:
  /// **'Host Match'**
  String get hostMatch;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @matchName.
  ///
  /// In en, this message translates to:
  /// **'Match Name'**
  String get matchName;

  /// No description provided for @matchNameHint.
  ///
  /// In en, this message translates to:
  /// **'Evening Smash Sessions'**
  String get matchNameHint;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTime;

  /// No description provided for @locationMap.
  ///
  /// In en, this message translates to:
  /// **'Location Map'**
  String get locationMap;

  /// No description provided for @selectCourt.
  ///
  /// In en, this message translates to:
  /// **'Select badminton court...'**
  String get selectCourt;

  /// No description provided for @currentSelection.
  ///
  /// In en, this message translates to:
  /// **'Current Selection'**
  String get currentSelection;

  /// No description provided for @playerSpecs.
  ///
  /// In en, this message translates to:
  /// **'Player Specs'**
  String get playerSpecs;

  /// No description provided for @availableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots'**
  String get availableSlots;

  /// No description provided for @excludingYourself.
  ///
  /// In en, this message translates to:
  /// **'Excluding yourself'**
  String get excludingYourself;

  /// No description provided for @keyDetails.
  ///
  /// In en, this message translates to:
  /// **'Key Details'**
  String get keyDetails;

  /// No description provided for @shuttlecockType.
  ///
  /// In en, this message translates to:
  /// **'Shuttlecock Type'**
  String get shuttlecockType;

  /// No description provided for @estCost.
  ///
  /// In en, this message translates to:
  /// **'Est. Cost'**
  String get estCost;

  /// No description provided for @perPerson.
  ///
  /// In en, this message translates to:
  /// **'/ person'**
  String get perPerson;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// No description provided for @airCon.
  ///
  /// In en, this message translates to:
  /// **'Air-con'**
  String get airCon;

  /// No description provided for @fan.
  ///
  /// In en, this message translates to:
  /// **'Fan'**
  String get fan;

  /// No description provided for @rubberFloor.
  ///
  /// In en, this message translates to:
  /// **'Rubber Floor'**
  String get rubberFloor;

  /// No description provided for @woodFloor.
  ///
  /// In en, this message translates to:
  /// **'Wood Floor'**
  String get woodFloor;

  /// No description provided for @hostsNote.
  ///
  /// In en, this message translates to:
  /// **'Host\'s Note'**
  String get hostsNote;

  /// No description provided for @hostsNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Mention any specific rules or pre-game meet points...'**
  String get hostsNoteHint;

  /// No description provided for @createMatch.
  ///
  /// In en, this message translates to:
  /// **'Create Match'**
  String get createMatch;

  /// No description provided for @uploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get uploadPhotos;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @photoLimit.
  ///
  /// In en, this message translates to:
  /// **'Max 5 photos'**
  String get photoLimit;

  /// No description provided for @recordMatch.
  ///
  /// In en, this message translates to:
  /// **'Record Match'**
  String get recordMatch;

  /// No description provided for @recordResult.
  ///
  /// In en, this message translates to:
  /// **'Record Result'**
  String get recordResult;

  /// No description provided for @matchSetup.
  ///
  /// In en, this message translates to:
  /// **'Match Setup'**
  String get matchSetup;

  /// No description provided for @doubles.
  ///
  /// In en, this message translates to:
  /// **'Doubles'**
  String get doubles;

  /// No description provided for @singles.
  ///
  /// In en, this message translates to:
  /// **'Singles'**
  String get singles;

  /// No description provided for @scoringSystem.
  ///
  /// In en, this message translates to:
  /// **'Scoring System'**
  String get scoringSystem;

  /// No description provided for @quickSwitch.
  ///
  /// In en, this message translates to:
  /// **'Quick Switch'**
  String get quickSwitch;

  /// No description provided for @selectPlayer.
  ///
  /// In en, this message translates to:
  /// **'Select Player...'**
  String get selectPlayer;

  /// No description provided for @team1.
  ///
  /// In en, this message translates to:
  /// **'Team 1'**
  String get team1;

  /// No description provided for @team2.
  ///
  /// In en, this message translates to:
  /// **'Team 2'**
  String get team2;

  /// No description provided for @matchType.
  ///
  /// In en, this message translates to:
  /// **'Match Type'**
  String get matchType;

  /// No description provided for @unlockPerformance.
  ///
  /// In en, this message translates to:
  /// **'Unlock Performance Tracking'**
  String get unlockPerformance;

  /// No description provided for @guestPerformanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to track your ELO rating, games played, win rate, and view detailed insights.'**
  String get guestPerformanceSubtitle;

  /// No description provided for @signInOrSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign In / Sign Up'**
  String get signInOrSignUp;

  /// No description provided for @noUpcomingMatches.
  ///
  /// In en, this message translates to:
  /// **'No upcoming matches'**
  String get noUpcomingMatches;

  /// No description provided for @guestNextMatchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see your schedule, or explore open matches near you.'**
  String get guestNextMatchSubtitle;

  /// No description provided for @exploreMatchesBtn.
  ///
  /// In en, this message translates to:
  /// **'Explore Matches'**
  String get exploreMatchesBtn;

  /// No description provided for @guestNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see updates about your matches, invitations, and results.'**
  String get guestNotificationsSubtitle;

  /// No description provided for @joinTheCourt.
  ///
  /// In en, this message translates to:
  /// **'Join the Court'**
  String get joinTheCourt;

  /// No description provided for @guestProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to track your stats, join matches, and connect with other players.'**
  String get guestProfileSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
