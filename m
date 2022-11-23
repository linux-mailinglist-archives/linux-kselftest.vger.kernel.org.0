Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E508E6368B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiKWS0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiKWS0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 13:26:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9165E7B
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 10:26:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s16-20020a25aa10000000b006e894071c9bso14094731ybi.20
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 10:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTKNLC3sEdwi5W/ymGUtZmoZguoXsDn/aCWMxA6BdqI=;
        b=C481PNvkzc7DlwTXHqN6vgdKjEiKOZnqhh7vA0BivRUkiGDBXsfWvS+aqM5Ic5Wpcr
         h7TE7cu1aHQBNdQt9cVHoSTn5X/FI6z1WUmc/WH/2irT5ZVuYUrsmoGq+7REt8EMy8Xr
         LT99NwXUsIsKyziGRB2YdrYPgYvuu/1AgG7fZrP4NEhbz4CYoNKCezhyiawzabFM4gsV
         FHTTgGH0JjD0Ldd56wLkoug2iKXIqt/VCCNDAttGe7me/pQqjrTnITOjk3W2vpNQBpuh
         X8jWdEkyx1H/07IRdWUKa3qts7P4tzAuMO2cbuD36k7R4XIooaLcepvvCPlEmleFBNO3
         e+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTKNLC3sEdwi5W/ymGUtZmoZguoXsDn/aCWMxA6BdqI=;
        b=FNtKPnXPpnjraB7fPPo+/BjVmu/Xw/ITXpABP35tjIB/XS2Ymh5Wy61L+KJSyPwjYt
         IhTwGySOiGRMvjAXup3Ns9JvsdCHQ5pdtqpQEMZXTZCVPly5yh5y+en5ABlV02ybOsg3
         IKVqCcmPCBi9325MvlE1ehZ2SI2+/acTxgE1y4ykj5/YFygrCfggmQhfjPqZukdm4bKH
         3+D2LT/jm/RsWXYcBjylfRnt9PbTEh9R9AnvPaiEu/AIQZ9ZbpU1yInJVbd+jOWH87uO
         OaMB6Ff/KMTOAPZO8B+jCsb73liqN7pHJlD4aVxqIsEpJWZ72RPyDBSXDDU3w+4tRoRg
         hYog==
X-Gm-Message-State: ANoB5pnfmi3OWUT0s/8WGPKN/HtBnG0AgZkjlM3c+8So8KYQjBBRZa+I
        G5SyhBzDoQZMG31ETzxjKcrR0Rq8uw==
X-Google-Smtp-Source: AA0mqf57QKKtP0tON+EX1hzSS75r5iZXu4m+XxHfZ+JzNm7z7paq9qM8MkTK6KL/0k9/L1QsReYByH15dw==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1805:b0:6e3:9a1d:c569 with SMTP id
 cf5-20020a056902180500b006e39a1dc569mr5ybb.130.1669227968620; Wed, 23 Nov
 2022 10:26:08 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:25:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123182558.2203639-1-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: tool: parse KTAP compliant test output
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change the KUnit parser to be able to parse test output that complies with
the KTAP version 1 specification format found here:
https://kernel.org/doc/html/latest/dev-tools/ktap.html. Ensure the parser
is able to parse tests with the original KUnit test output format as
well.

KUnit parser now accepts any of the following test output formats:

Original KUnit test output format:

 TAP version 14
 1..1
   # Subtest: kunit-test-suite
   1..3
   ok 1 - kunit_test_1
   ok 2 - kunit_test_2
   ok 3 - kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 - kunit-test-suite

KTAP version 1 test output format:

 KTAP version 1
 1..1
   KTAP version 1
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 ok 1 kunit-test-suite

New KUnit test output format (changes made in the next patch of
this series):

 KTAP version 1
 1..1
   KTAP version 1
   # Subtest: kunit-test-suite
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kunit-test-suite

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/all/CA+GJov4QZ8yrD8sgGeMYJ4zYkg2CEUX8owqzPFE0BQGe_f=
0bFQ@mail.gmail.com/
- Rebased onto linux-kselftest/kunit to correct merge conflict with
  recently approved patch
- Fixed typo
- Added test_parse_subtest_header to test whether the =E2=80=9C# Subtest:=
=E2=80=9D
  line is being parsed correctly when using the new test format

Changes since v1:
https://lore.kernel.org/all/20221104194705.3245738-2-rmoar@google.com/
- Switch order of patches to make changes to the parser before making
changes to the test output
- Change placeholder label for test header from =E2=80=9CTest suite=E2=80=
=9D to empty
string
- Change parser to approve the new KTAP version line in the subtest header
to be before the subtest header line rather than after.
- Note: Considered changing parser to allow for the top-level of testing
to have a '# Subtest' line as discussed in v1 but this breaks the missing
test plan test. So I think it would be best to add this ability at a later
time or after top-level test name and result lines are discussed for
KTAP v2.

 tools/testing/kunit/kunit_parser.py           | 79 ++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py        | 14 ++++
 .../test_data/test_parse_ktap_output.log      |  8 ++
 .../test_data/test_parse_subtest_header.log   |  7 ++
 4 files changed, 80 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.lo=
g
 create mode 100644 tools/testing/kunit/test_data/test_parse_subtest_header=
.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kuni=
t_parser.py
index d0ed5dd5cfc4..4cc2f8b7ecd0 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -441,6 +441,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	- '# Subtest: [test name]'
 	- '[ok|not ok] [test number] [-] [test name] [optional skip
 		directive]'
+	- 'KTAP version [version number]'
=20
 	Parameters:
 	lines - LineStream of KTAP output to parse
@@ -449,8 +450,9 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log =3D []  # type: List[str]
-	while lines and not TEST_RESULT.match(lines.peek()) and not \
-			TEST_HEADER.match(lines.peek()):
+	non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START]
+	while lines and not any(re.match(lines.peek())
+			for re in non_diagnostic_lines):
 		log.append(lines.pop())
 	return log
=20
@@ -496,11 +498,15 @@ def print_test_header(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	message =3D test.name
+	if message !=3D "":
+		# Add a leading space before the subtest counts only if a test name
+		# is provided using a "# Subtest" header line.
+		message +=3D " "
 	if test.expected_count:
 		if test.expected_count =3D=3D 1:
-			message +=3D ' (1 subtest)'
+			message +=3D '(1 subtest)'
 		else:
-			message +=3D f' ({test.expected_count} subtests)'
+			message +=3D f'({test.expected_count} subtests)'
 	stdout.print_with_timestamp(format_test_divider(message, len(message)))
=20
 def print_log(log: Iterable[str]) -> None:
@@ -647,7 +653,7 @@ def bubble_up_test_results(test: Test) -> None:
 	elif test.counts.get_status() =3D=3D TestStatus.TEST_CRASHED:
 		test.status =3D TestStatus.TEST_CRASHED
=20
-def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Te=
st:
+def parse_test(lines: LineStream, expected_num: int, log: List[str], is_su=
btest: bool) -> Test:
 	"""
 	Finds next test to parse in LineStream, creates new Test object,
 	parses any subtests of the test, populates Test object with all
@@ -665,15 +671,32 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str]) -> Test:
 	1..4
 	[subtests]
=20
-	- Subtest header line
+	- Subtest header (must include either the KTAP version line or
+	  "# Subtest" header line)
=20
-	Example:
+	Example (preferred format with both KTAP version line and
+	"# Subtest" line):
+
+	KTAP version 1
+	# Subtest: name
+	1..3
+	[subtests]
+	ok 1 name
+
+	Example (only "# Subtest" line):
=20
 	# Subtest: name
 	1..3
 	[subtests]
 	ok 1 name
=20
+	Example (only KTAP version line, compliant with KTAP v1 spec):
+
+	KTAP version 1
+	1..3
+	[subtests]
+	ok 1 name
+
 	- Test result line
=20
 	Example:
@@ -685,28 +708,29 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str]) -> Test:
 	expected_num - expected test number for test to be parsed
 	log - list of strings containing any preceding diagnostic lines
 		corresponding to the current test
+	is_subtest - boolean indicating whether test is a subtest
=20
 	Return:
 	Test object populated with characteristics and any subtests
 	"""
 	test =3D Test()
 	test.log.extend(log)
-	parent_test =3D False
-	main =3D parse_ktap_header(lines, test)
-	if main:
-		# If KTAP/TAP header is found, attempt to parse
+	if not is_subtest:
+		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
 		test.name =3D "main"
+		ktap_line =3D parse_ktap_header(lines, test)
 		parse_test_plan(lines, test)
 		parent_test =3D True
 	else:
-		# If KTAP/TAP header is not found, test must be subtest
-		# header or test result line so parse attempt to parser
-		# subtest header
-		parent_test =3D parse_test_header(lines, test)
+		# If not the main test, attempt to parse a test header containing
+		# the KTAP version line and/or subtest header line
+		ktap_line =3D parse_ktap_header(lines, test)
+		subtest_line =3D parse_test_header(lines, test)
+		parent_test =3D (ktap_line or subtest_line)
 		if parent_test:
-			# If subtest header is found, attempt to parse
-			# test plan and print header
+			# If KTAP version line and/or subtest header is found, attempt
+			# to parse test plan and print test header
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count =3D test.expected_count
@@ -721,7 +745,7 @@ def parse_test(lines: LineStream, expected_num: int, lo=
g: List[str]) -> Test:
 		sub_log =3D parse_diagnostic(lines)
 		sub_test =3D Test()
 		if not lines or (peek_test_name_match(lines, test) and
-				not main):
+				is_subtest):
 			if expected_count and test_num <=3D expected_count:
 				# If parser reaches end of test before
 				# parsing expected number of subtests, print
@@ -735,20 +759,19 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str]) -> Test:
 				test.log.extend(sub_log)
 				break
 		else:
-			sub_test =3D parse_test(lines, test_num, sub_log)
+			sub_test =3D parse_test(lines, test_num, sub_log, True)
 		subtests.append(sub_test)
 		test_num +=3D 1
 	test.subtests =3D subtests
-	if not main:
+	if is_subtest:
 		# If not main test, look for test result line
 		test.log.extend(parse_diagnostic(lines))
-		if (parent_test and peek_test_name_match(lines, test)) or \
-				not parent_test:
-			parse_test_result(lines, test, expected_num)
-		else:
+		if test.name !=3D "" and not peek_test_name_match(lines, test):
 			test.add_error('missing subtest result line!')
+		else:
+			parse_test_result(lines, test, expected_num)
=20
-	# Check for there being no tests
+	# Check for there being no subtests within parent test
 	if parent_test and len(subtests) =3D=3D 0:
 		# Don't override a bad status if this test had one reported.
 		# Assumption: no subtests means CRASHED is from Test.__init__()
@@ -758,11 +781,11 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str]) -> Test:
=20
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
-	if parent_test and not main:
+	if parent_test and is_subtest:
 		# If test has subtests and is not the main test object, print
 		# footer.
 		print_test_footer(test)
-	elif not main:
+	elif is_subtest:
 		print_test_result(test)
 	return test
=20
@@ -785,7 +808,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Te=
st:
 		test.add_error('Could not find any KTAP output. Did any KUnit tests run?=
')
 		test.status =3D TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		test =3D parse_test(lines, 0, [])
+		test =3D parse_test(lines, 0, [], False)
 		if test.status !=3D TestStatus.NO_TESTS:
 			test.status =3D test.counts.get_status()
 	stdout.print_with_timestamp(DIVIDER)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index 84a08cf07242..d7f669cbf2a8 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -312,6 +312,20 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser._summarize_failed_tests(result),
 			'Failures: all_failed_suite, some_failed_suite.test2')
=20
+	def test_ktap_format(self):
+		ktap_log =3D test_data_path('test_parse_ktap_output.log')
+		with open(ktap_log) as file:
+			result =3D kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3D3))
+		self.assertEqual('suite', result.subtests[0].name)
+		self.assertEqual('case_1', result.subtests[0].subtests[0].name)
+		self.assertEqual('case_2', result.subtests[0].subtests[1].name)
+
+	def test_parse_subtest_header(self):
+		ktap_log =3D test_data_path('test_parse_subtest_header.log')
+		with open(ktap_log) as file:
+			result =3D kunit_parser.parse_run_tests(file.readlines())
+		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
=20
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=3D1))
diff --git a/tools/testing/kunit/test_data/test_parse_ktap_output.log b/too=
ls/testing/kunit/test_data/test_parse_ktap_output.log
new file mode 100644
index 000000000000..ccdf244e5303
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_ktap_output.log
@@ -0,0 +1,8 @@
+KTAP version 1
+1..1
+  KTAP version 1
+  1..3
+  ok 1 case_1
+  ok 2 case_2
+  ok 3 case_3
+ok 1 suite
diff --git a/tools/testing/kunit/test_data/test_parse_subtest_header.log b/=
tools/testing/kunit/test_data/test_parse_subtest_header.log
new file mode 100644
index 000000000000..216631092e7b
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_subtest_header.log
@@ -0,0 +1,7 @@
+KTAP version 1
+1..1
+  KTAP version 1
+  # Subtest: suite
+  1..1
+  ok 1 test
+ok 1 suite
\ No newline at end of file

base-commit: 99c8c9276be71e6bc98979e95d56cdcbe0c2454e
--=20
2.38.1.584.g0f3c55d4c2-goog

