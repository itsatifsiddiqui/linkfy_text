import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';
import 'package:test/test.dart';

void main() {
  group('Regular Expression', () {
    // test values
    const urlText =
        "My website url: https://hello.com/GOOGLE search using: www.google.com, social media is facebook.com, http://example.com/method?param=fullstackoverflow.dev";
    const hashtagText = "#helloWorld and #dev are trending";
    const emailText =
        "My email address is hey@stanleee.me and dev@gmail.com, yah!";

    const phoneText = "My phone number is (222)322-3222 or +15552223333";
    const userTagText = "Follow me @user_name";
    const text = urlText + hashtagText + emailText + phoneText + userTagText;

    const emails = ["hello@world.com", "foo.bar@js.com"];

    const urls = [
      "http://domain.com",
      "http://domain.com/",
      "http://192.168.8.2:9990",
      "http://localhost:8080",
      "https://localhost:8080?hsh=123&q=hello",
      'http://localhost',
      "https://localhost:8080",
      "https://domain.com",
      "https://domain.com/",
      "https://www.domain.com",
      "www.domain.com",
      "https://domain.com/Google?",
      "https://domain.com/Google/search",
      "https://domain.com/Google?param=",
      "https://domain.com/Google?param=helloworld",
      "https://sub.domain.com/Google?param=helloworld#hash",
       "https://my-domain.com",
      "http://my-awesome-website.com",
      "www.my-site-with-hyphens.com",
      "https://sub-domain.example.com"
    ];

    const hashtags = [
      "#123",
      "#H",
      "#0",
      "#trending",
      "#_trending",
      "#TRENDING",
      "#trending_topic",
    ];

    const userTags = [
      '@helloWorld',
      '@helloWorld123',
      '@hello_world',
      '@hello_world123',
      '@hello_world_123'
    ];

    const phoneNums = [
      "1112223333",
      "(111)222 3333",
      "+5444333222",
      "+91 (123) 456-7890",
      "123-456-7890",
    ];

    const ukPhoneNums = [
      // UK mobile
      "+44 7911 123456",
      "+447911123456",
      "+44.7911.123456",
      "07911 123456",
      "07911123456",
      "0791 112 3456",
      "07700 900123",
      "44 7911 123456",
      // UK London landline
      "020 7946 0958",
      "02079460958",
      "+44 20 7946 0958",
      "+442079460958",
      "020-7946-0958",
      "020.7946.0958",
      // UK other landlines
      "0121 496 0123",
      "0113 496 0123",
      "+44 121 496 0123",
      "+44 113 496 0123",
      // UK freephone / special
      "0800 123 4567",
      "08001234567",
      "0808 123 4567",
      "+44 800 123 4567",
      "0300 123 4567",
      "0345 123 4567",
    ];

    const usPhoneNums = [
      "555-123-4567",
      "(555) 123-4567",
      "+1 555 123 4567",
      "5551234567",
      "+1-555-123-4567",
      "1-800-555-1234",
      "555.123.4567",
      "555 123 4567",
      "+1(555)123-4567",
      "+15551234567",
    ];

    const pkPhoneNums = [
      "03456643045",
      "0345-6643045",
      "+92 345 664 3045",
      "+923456643045",
      "0300-1234567",
      "0300 1234567",
      "+92 300 123 4567",
      "0321-1234567",
      "03211234567",
    ];

    const singleDigitAreaCodes = [
      "+44 (0) 7911 123456", // UK trunk in parens
      "+81 3 1234 5678", // Japan Tokyo
      "+61 2 1234 5678", // Australia Sydney
      "+82 2 1234 5678", // South Korea Seoul
      "+33 1 23 45 67 89", // France (5 groups of 2)
    ];

    const notPhoneNums = [
      "2.0.1",
      "10.3.4",
      "1.2.3.4",
      "19.99",
      "123",
      "12345",
      "2024-06-01",
    ];

    const shortPlusNotPhone = [
      "+425",
      "+1234",
      "+12 34",
      "+1 2 3",
    ];

    ///
    test("Should match all emails", () {
      for (final email in emails) {
        expect(RegExp(emailRegExp).hasMatch(email), isTrue);
        expect(getMatchedType(email), equals(LinkType.email));
      }
    });

    test("Should match all urls", () {
      for (final url in urls) {
        expect(RegExp(urlRegExp).hasMatch(url), isTrue);
        expect(getMatchedType(url), equals(LinkType.url));
      }
    });

    test("Should match all hashtags", () {
      for (final tag in hashtags) {
        expect(RegExp(hashtagRegExp).hasMatch(tag), isTrue);
        expect(getMatchedType(tag), equals(LinkType.hashTag));
      }
    });
    test("Should match all usertags", () {
      for (final tag in userTags) {
        expect(RegExp(userTagRegExp).hasMatch(tag), isTrue);
        expect(getMatchedType(tag), equals(LinkType.userTag));
      }
    });
    test("Should match all phones", () {
      for (final phone in phoneNums) {
        expect(RegExp(phoneRegExp).hasMatch(phone), isTrue);
        expect(getMatchedType(phone), equals(LinkType.phone));
      }
    });

    test("Should match UK phone numbers", () {
      for (final phone in ukPhoneNums) {
        expect(RegExp(phoneRegExp).hasMatch(phone), isTrue,
            reason: 'Failed to match UK phone: $phone');
        expect(getMatchedType(phone), equals(LinkType.phone),
            reason: 'Failed getMatchedType for UK phone: $phone');
      }
    });

    test("Should match US phone numbers", () {
      for (final phone in usPhoneNums) {
        expect(RegExp(phoneRegExp).hasMatch(phone), isTrue,
            reason: 'Failed to match US phone: $phone');
        expect(getMatchedType(phone), equals(LinkType.phone),
            reason: 'Failed getMatchedType for US phone: $phone');
      }
    });

    test("Should match Pakistani phone numbers", () {
      for (final phone in pkPhoneNums) {
        expect(RegExp(phoneRegExp).hasMatch(phone), isTrue,
            reason: 'Failed to match PK phone: $phone');
        expect(getMatchedType(phone), equals(LinkType.phone),
            reason: 'Failed getMatchedType for PK phone: $phone');
      }
    });

    test("Should match international numbers with single-digit area codes", () {
      for (final phone in singleDigitAreaCodes) {
        expect(RegExp(phoneRegExp).hasMatch(phone), isTrue,
            reason: 'Failed to match: $phone');
        expect(getMatchedType(phone), equals(LinkType.phone),
            reason: 'Failed getMatchedType for: $phone');
      }
    });

    test("Should NOT match non-phone strings as phone", () {
      final phoneRegex = RegExp(phoneRegExp);
      for (final text in notPhoneNums) {
        final match = phoneRegex.firstMatch(text);
        // If regex matches, the match should not cover the full string
        // (i.e., only a substring matched, not the intended text)
        if (match != null) {
          // Ensure it doesn't match the entire string as a phone number
          expect(match.group(0) == text, isFalse,
              reason: 'Full false positive phone match: $text');
        }
      }
    });

    test("Short + numbers should NOT match as phone", () {
      final phoneRegex = RegExp(phoneRegExp);
      for (final text in shortPlusNotPhone) {
        final match = phoneRegex.firstMatch(text);
        if (match != null) {
          expect(match.group(0) == text, isFalse,
              reason: 'False positive phone match: $text');
        }
      }
    });

    test("Version/build strings with + should NOT match as phone", () {
      final regex = constructRegExpFromLinkType([
        LinkType.url, LinkType.phone,
      ]);
      final text = 'build 0.7.9 +425';
      final matches = regex.allMatches(text).toList();
      for (final m in matches) {
        expect(m.group(0), isNot(equals('+425')),
            reason: '"+425" in build string matched as phone');
      }
    });

    test("IP addresses should match as URL, not phone", () {
      const ip = "192.168.1.1";
      expect(getMatchedType(ip), equals(LinkType.url));
    });

    test("Phone regex should not match across newlines", () {
      final regex = constructRegExpFromLinkType([
        LinkType.url, LinkType.phone,
      ]);
      final text = "07911 123456\n020 7946 0958\n0345-6643045\n0300-1234567";
      final matches = regex.allMatches(text).toList();

      for (final m in matches) {
        expect(m.group(0)!.contains('\n'), isFalse,
            reason: 'Cross-line match: "${m.group(0)}"');
      }
      expect(matches.length, equals(4));
      expect(matches[0].group(0), equals('07911 123456'));
      expect(matches[1].group(0), equals('020 7946 0958'));
      expect(matches[2].group(0), equals('0345-6643045'));
      expect(matches[3].group(0), equals('0300-1234567'));
    });

    test("Phones in sentences should match correctly", () {
      final regex = constructRegExpFromLinkType([LinkType.url, LinkType.phone]);

      final match1 = regex.allMatches('Call us on 07911 123456 for info');
      expect(match1.first.group(0), equals('07911 123456'));

      final match2 = regex.allMatches('Our landline is 020 7946 0958 thanks');
      expect(match2.first.group(0), equals('020 7946 0958'));
    });

    test("URLs with digits should not match as phone", () {
      expect(getMatchedType('https://example.com/order/5551234567'),
          equals(LinkType.url));
      expect(getMatchedType('https://example.com/phone=03456643045'),
          equals(LinkType.url));
    });

    test("Phone right after URL should both work independently", () {
      final regex = constructRegExpFromLinkType([LinkType.url, LinkType.phone]);
      final text = 'Visit https://example.com or call 07911 123456';
      final matches = regex.allMatches(text).toList();
      expect(matches.length, equals(2));
      final types = matches.map((m) => getMatchedType(m.group(0)!)).toList();
      expect(types, contains(LinkType.url));
      expect(types, contains(LinkType.phone));
    });

    test(
        "Should construct regex pattern from LinkTypes and match required output",
        () {
      final urlRegExp = constructRegExpFromLinkType([LinkType.url]);
      final hashtagRegExp = constructRegExpFromLinkType([LinkType.hashTag]);
      final emailRegExp = constructRegExpFromLinkType([LinkType.email]);
      final phoneRegExp = constructRegExpFromLinkType([LinkType.phone]);
      final userTagRegExp = constructRegExpFromLinkType([LinkType.userTag]);
      final textRegExp = constructRegExpFromLinkType([
        LinkType.url,
        LinkType.hashTag,
        LinkType.email,
        LinkType.phone,
        LinkType.userTag,
      ]);

      expect(urlRegExp.allMatches(urlText).length, 4);
      expect(userTagRegExp.allMatches(userTagText).length, 1);
      expect(hashtagRegExp.allMatches(hashtagText).length, 2);
      expect(emailRegExp.allMatches(emailText).length, 2);
      expect(phoneRegExp.allMatches(phoneText).length, 2);
      expect(textRegExp.allMatches(text).length, 10);
    });
  });
}
