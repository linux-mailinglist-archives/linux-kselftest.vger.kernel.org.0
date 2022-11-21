Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64E7632C4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 19:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKUSs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 13:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKUSsY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 13:48:24 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF1C67E8
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 10:48:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349423f04dbso120911567b3.13
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+v9EeIFZ7RyvUerteODN5H9jhdDgoezlYo0pDlayPT0=;
        b=NqaHSmHAe7/TLGkCIAtqeIDQkfzZRFvowtcoC4eUtQjXP6D9oaVh8jJEEtejYtZ1wr
         InRjVIVNilE9GLLkC1E3/Q7ItH2WElvNiFz+H5lP0GeOAj0ivZpC3d20KWHQa1tXRgS4
         0zybMy3wWj3ZB40qbhaXkBsrh50IWmJBHgq9E1wgeq6UMieeQFwU1HTbxaEc3RjJUZ8V
         wXMgtyFG61i7ejRvAUVH3EVahESmapTGI4UkMwi3kypXsVxGWWUrrvGfDnQJWKzpfpCn
         Gs0WpX0F0fWDOBjnMHfTW3GwjyM37Vknpdf+/TFNbjTZnXbTLYTfsCnBCJ7UdIZzr3gF
         j1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v9EeIFZ7RyvUerteODN5H9jhdDgoezlYo0pDlayPT0=;
        b=pIvLMSP7R53iRVaP0fN1YXH6r0ceOrT+UEjgZFg0GRfs1HgwCufRt7EqjibISa1cgL
         hPQxLZdH3t6lGVLNtwGBpZMNLSxD3mhVWlWecqB4WTpVa1PKqYosjHYN+x/7k4C+UDLn
         yWBVL33P6W1cgvEXGRAStEldQw0FKkTmToTfP3aLLtkDob3pszCYC0k6LKLzjVgdeNYQ
         +Mzq7w8iyB3hGPMImuovaLk1JMMx0LcF7SbxcLPhS/y/SzpvvjZ5iuzwyHsHCEAQ6MMH
         CELsd/ZIViyEVuOimDE4gFgl1cAadnjpng183Uny6uAiZPzd8xMjGcDf1kN7gT36p3jC
         +CBQ==
X-Gm-Message-State: ANoB5pl0PezPCIOJ19BY1JdeZKD9wAdLbPJYL02tI4rh53HoOFldN5Dv
        5ufD9NBrEh7Mp4fVNlWA9CdSa47Siw==
X-Google-Smtp-Source: AA0mqf6PzdEBIJukoBwRmrMj2XLHxERYeuac++frsEhdwrk24lUBzQNKY0esj0HkPRuiHUUm4BW219NDnQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:ad8b:0:b0:6de:6c43:3991 with SMTP id
 z11-20020a25ad8b000000b006de6c433991mr9821ybi.604.1669056501142; Mon, 21 Nov
 2022 10:48:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:47:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121184743.1123556-1-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: tool: parse KTAP compliant test output
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
  to have a '# Subtest' line as discussed in v1 but this breaks the
  missing test plan test. So I think it would be best to add this ability
  at a later time or after top-level test name and result lines are
  discussed for KTAP v2.

tools/testing/kunit/kunit_parser.py           | 79 ++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py        |  8 ++
 .../test_data/test_parse_ktap_output.log      |  8 ++
 3 files changed, 67 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.lo=
g

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kuni=
t_parser.py
index a56c75a973b5..ed752d53d6a8 100644
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
+		# If not the main test, attempt to parse a test header contatining
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
 		test.add_error('could not find any KTAP output!')
 		test.status =3D TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		test =3D parse_test(lines, 0, [])
+		test =3D parse_test(lines, 0, [], False)
 		if test.status !=3D TestStatus.NO_TESTS:
 			test.status =3D test.counts.get_status()
 	stdout.print_with_timestamp(DIVIDER)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index 90c65b072be9..7c2e2a45f330 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -312,6 +312,14 @@ class KUnitParserTest(unittest.TestCase):
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

base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
--=20
2.38.1.584.g0f3c55d4c2-goog

