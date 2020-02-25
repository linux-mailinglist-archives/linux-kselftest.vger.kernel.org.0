Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB516EFD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 21:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgBYULo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 15:11:44 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36621 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgBYULh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 15:11:37 -0500
Received: by mail-pf1-f201.google.com with SMTP id 6so220717pfv.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=olGEKVt7aKYyoJtZp+gI6XiiDQDvBesIaR/gHj/tn7A=;
        b=K2D1q8zBCgx/n+QcyDqBI731AccIzgRwSe+YEEKwk/FV872ZqCVGx6U4zHFxmG0SkW
         NaNR9gm5LJ8oER8c4STYYuXWyx5d5JS1wjYRAACo7RIlaIHMVXErIeKOxjAaJOVcoz7G
         UZKk6UY7EzHq7CbilnXZg8dLevY5A+MTg5yfn16PDuuSNUtje4Z4zI08xpggXeoUauQX
         3UVhuoeeuLD5Oq3msIRqYj5GmpGHlXUVIwaUk6TSMjWgwJNEpgDQX0vYDiPrwAhYXnHP
         K3WC+vF2FvRcoqMTXNff6NtNLztOpPaPJeeV2XwPia5DR6brBhkqAVfVRwOF17zHOhve
         39QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=olGEKVt7aKYyoJtZp+gI6XiiDQDvBesIaR/gHj/tn7A=;
        b=XYl6G5uNdCeI8cChB9LMhPjQ/aQ/bYqZcMps65+25MVCsw7+cBQBCFfTg/nnw+T0uB
         ZfLjJAKPdoLazgzawEpiVsPC2cbtmImOmsZXdvicpLZ8bSDGO5dgX1/uGjod0At5IJhX
         cCvoDuga2aDDRnoHiWR8oZegCleks56zFrVcZ9NmDpRxgydYGjwE5wt66qL82sp8i8JE
         AXsghZLS1TCAFKgi50M/KM9Ro2O6+aArWYbMLTd/bKT1sc634QQ2I+qaRsVEah1RCTO+
         7jjs+Ibqyvkg6WUnEI9Z4KIob1Y9k2MGPIy6VVNgwmo+rw3jcm3G1I9rL28nVKoHgCHi
         EEHw==
X-Gm-Message-State: APjAAAV134FrsSVN9AVAl/4uBpRp/ri/E6rHmqeGsabS780TeC+TA2aD
        XpcpMxIyBMmA+nkNCmsAJRNo2jd2l4KBsvBV
X-Google-Smtp-Source: APXvYqxIAKVdXcogeG5IP5XAtbw6nMatG+px/sTtMdYK/slOjhOuTnBjcG3wJc4IYuECo6CZa+5UTgfWnUK89kSC
X-Received: by 2002:a63:fd17:: with SMTP id d23mr219479pgh.159.1582661496360;
 Tue, 25 Feb 2020 12:11:36 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:11:29 -0800
Message-Id: <20200225201130.211124-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/2] kunit: kunit_parser: making parser more robust
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, kunit_parser did not properly handle kunit TAP output that
- had any prefixes (generated from different configs)
- had unrelated kernel output mixed in the middle of it, which has
shown up when testing with allyesconfig
To remove prefixes, the parser looks for the first line that includes
TAP output, "TAP version 14".  It then determines the length of the
string before this sequence, and strips that number of characters off
the beginning of the following lines until the last KUnit output line is
reached.
These fixes have been tested with additional tests in the
KUnitParseTest and their associated logs have also been added.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit_parser.py           | 54 +++++++--------
 tools/testing/kunit/kunit_tool_test.py        | 69 +++++++++++++++++++
 .../test_data/test_config_printk_time.log     | 31 +++++++++
 .../test_data/test_interrupted_tap_output.log | 37 ++++++++++
 .../test_data/test_kernel_panic_interrupt.log | 25 +++++++
 .../test_data/test_multiple_prefixes.log      | 31 +++++++++
 ..._output_with_prefix_isolated_correctly.log | 33 +++++++++
 .../kunit/test_data/test_pound_no_prefix.log  | 33 +++++++++
 .../kunit/test_data/test_pound_sign.log       | 33 +++++++++
 9 files changed, 319 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_config_printk_time.log
 create mode 100644 tools/testing/kunit/test_data/test_interrupted_tap_output.log
 create mode 100644 tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
 create mode 100644 tools/testing/kunit/test_data/test_multiple_prefixes.log
 create mode 100644 tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
 create mode 100644 tools/testing/kunit/test_data/test_pound_no_prefix.log
 create mode 100644 tools/testing/kunit/test_data/test_pound_sign.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4ffbae0f6732..077b21d42258 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -46,19 +46,21 @@ class TestStatus(Enum):
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
 
-kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_start_re = re.compile(r'TAP version [0-9]+$')
+kunit_end_re = re.compile('(List of all partitions:|'
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output):
 	started = False
 	for line in kernel_output:
-		if kunit_start_re.match(line):
+		if kunit_start_re.search(line):
+			prefix_len = len(line.split('TAP version')[0])
 			started = True
-			yield line
-		elif kunit_end_re.match(line):
+			yield line[prefix_len:] if prefix_len > 0 else line
+		elif kunit_end_re.search(line):
 			break
 		elif started:
-			yield line
+			yield line[prefix_len:] if prefix_len > 0 else line
 
 def raw_output(kernel_output):
 	for line in kernel_output:
@@ -91,35 +93,33 @@ def print_log(log):
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
+TAP_ENTRIES = re.compile(r'(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t# .*?:.*?).*$')
 
 def consume_non_diagnositic(lines: List[str]) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
+	while lines and not TAP_ENTRIES.search(lines[0]):
 		lines.pop(0)
 
 def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
+	while lines and not TAP_ENTRIES.search(lines[0]):
 		test_case.log.append(lines[0])
 		lines.pop(0)
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
-OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_SUBTEST = re.compile(r'\t(ok|not ok) [0-9]+ - (.*)$')
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_MODULE = re.compile(r'(ok|not ok) [0-9]+ - (.*)$')
 
-def parse_ok_not_ok_test_case(lines: List[str],
-			      test_case: TestCase,
-			      expecting_test_case: bool) -> bool:
+def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
 	if not lines:
-		if expecting_test_case:
-			test_case.status = TestStatus.TEST_CRASHED
-			return True
-		else:
-			return False
+		test_case.status = TestStatus.TEST_CRASHED
+		return True
 	line = lines[0]
 	match = OK_NOT_OK_SUBTEST.match(line)
+	while not match and lines:
+		line = lines.pop(0)
+		match = OK_NOT_OK_SUBTEST.match(line)
 	if match:
 		test_case.log.append(lines.pop(0))
 		test_case.name = match.group(2)
@@ -150,12 +150,12 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
+def parse_test_case(lines: List[str]) -> TestCase:
 	test_case = TestCase()
 	save_non_diagnositic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
 		pass
-	if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
+	if parse_ok_not_ok_test_case(lines, test_case):
 		return test_case
 	else:
 		return None
@@ -202,7 +202,7 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
 		test_suite.status = TestStatus.TEST_CRASHED
 		return False
 	line = lines[0]
-	match = OK_NOT_OK_MODULE.match(line)
+	match = OK_NOT_OK_MODULE.search(line)
 	if match:
 		lines.pop(0)
 		if match.group(1) == 'ok':
@@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 	expected_test_case_num = parse_subtest_plan(lines)
 	if not expected_test_case_num:
 		return None
-	test_case = parse_test_case(lines, expected_test_case_num > 0)
-	expected_test_case_num -= 1
-	while test_case:
+	while expected_test_case_num > 0:
+		test_case = parse_test_case(lines)
+		if not test_case:
+			break
 		test_suite.cases.append(test_case)
-		test_case = parse_test_case(lines, expected_test_case_num > 0)
 		expected_test_case_num -= 1
 	if parse_ok_not_ok_test_suite(lines, test_suite):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
@@ -250,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 		print('failed to parse end of suite' + lines[0])
 		return None
 
-TAP_HEADER = re.compile(r'^TAP version 14$')
+TAP_HEADER = re.compile(r'TAP version 14$')
 
 def parse_tap_header(lines: List[str]) -> bool:
 	consume_non_diagnositic(lines)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index cba97756ac4a..0efae697f396 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -108,6 +108,36 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
 		file.close()
 
+	def test_output_with_prefix_isolated_correctly(self):
+		log_path = get_absolute_path(
+			'test_data/test_pound_sign.log')
+		with open(log_path) as file:
+			result = kunit_parser.isolate_kunit_output(file.readlines())
+		self.assertContains('TAP version 14\n', result)
+		self.assertContains('	# Subtest: kunit-resource-test', result)
+		self.assertContains('	1..5', result)
+		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)
+		self.assertContains('	ok 2 - kunit_resource_test_alloc_resource', result)
+		self.assertContains('	ok 3 - kunit_resource_test_destroy_resource', result)
+		self.assertContains(' foo bar 	#', result)
+		self.assertContains('	ok 4 - kunit_resource_test_cleanup_resources', result)
+		self.assertContains('	ok 5 - kunit_resource_test_proper_free_ordering', result)
+		self.assertContains('ok 1 - kunit-resource-test', result)
+		self.assertContains(' foo bar 	# non-kunit output', result)
+		self.assertContains('	# Subtest: kunit-try-catch-test', result)
+		self.assertContains('	1..2', result)
+		self.assertContains('	ok 1 - kunit_test_try_catch_successful_try_no_catch',
+				    result)
+		self.assertContains('	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
+				    result)
+		self.assertContains('ok 2 - kunit-try-catch-test', result)
+		self.assertContains('	# Subtest: string-stream-test', result)
+		self.assertContains('	1..3', result)
+		self.assertContains('	ok 1 - string_stream_test_empty_on_creation', result)
+		self.assertContains('	ok 2 - string_stream_test_not_empty_after_add', result)
+		self.assertContains('	ok 3 - string_stream_test_get_string', result)
+		self.assertContains('ok 3 - string-stream-test', result)
+
 	def test_parse_successful_test_log(self):
 		all_passed_log = get_absolute_path(
 			'test_data/test_is_test_passed-all_passed.log')
@@ -150,6 +180,45 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_ignores_prefix_printk_time(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_config_printk_time.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_ignores_multiple_prefixes(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_multiple_prefixes.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_mixed_kernel_output(self):
+		mixed_prefix_log = get_absolute_path(
+			'test_data/test_interrupted_tap_output.log')
+		with open(mixed_prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_poundsign(self):
+		pound_log = get_absolute_path('test_data/test_pound_sign.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_kernel_panic_end(self):
+		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
+		with open(panic_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_pound_no_prefix(self):
+		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other
diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
new file mode 100644
index 000000000000..c02ca773946d
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_config_printk_time.log
@@ -0,0 +1,31 @@
+[    0.060000] printk: console [mc-1] enabled
+[    0.060000] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000] TAP version 14
+[    0.060000] 	# Subtest: kunit-resource-test
+[    0.060000] 	1..5
+[    0.060000] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000] ok 1 - kunit-resource-test
+[    0.060000] 	# Subtest: kunit-try-catch-test
+[    0.060000] 	1..2
+[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000] ok 2 - kunit-try-catch-test
+[    0.060000] 	# Subtest: string-stream-test
+[    0.060000] 	1..3
+[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000] 	ok 2 - string_stream_test_not_empty_after_add
+[    0.060000] 	ok 3 - string_stream_test_get_string
+[    0.060000] ok 3 - string-stream-test
+[    0.060000] List of all partitions:
+[    0.060000] No filesystem could mount root, tried:
+[    0.060000]
+[    0.060000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000] Stack:
+[    0.060000]  602086f8 601bc260 705c0000 705c0000
+[    0.060000]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
new file mode 100644
index 000000000000..5c73fb3a1c6f
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
@@ -0,0 +1,37 @@
+[    0.060000] printk: console [mc-1] enabled
+[    0.060000] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000] TAP version 14
+[    0.060000] 	# Subtest: kunit-resource-test
+[    0.060000] 	1..5
+[    0.060000] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000] kAFS: Red Hat AFS client v0.1 registering.
+[    0.060000] FS-Cache: Netfs 'afs' registered for caching
+[    0.060000] *** VALIDATE kAFS ***
+[    0.060000] Btrfs loaded, crc32c=crc32c-generic, debug=on, assert=on, integrity-checker=on, ref-verify=on
+[    0.060000] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
+[    0.060000] BTRFS: selftest: running btrfs free space cache tests
+[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000] ok 1 - kunit-resource-test
+[    0.060000] 	# Subtest: kunit-try-catch-test
+[    0.060000] 	1..2
+[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000] ok 2 - kunit-try-catch-test
+[    0.060000] 	# Subtest: string-stream-test
+[    0.060000] 	1..3
+[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000] 	ok 2 - string_stream_test_not_empty_after_add
+[    0.060000] 	ok 3 - string_stream_test_get_string
+[    0.060000] ok 3 - string-stream-test
+[    0.060000] List of all partitions:
+[    0.060000] No filesystem could mount root, tried:
+[    0.060000]
+[    0.060000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000] Stack:
+[    0.060000]  602086f8 601bc260 705c0000 705c0000
+[    0.060000]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
new file mode 100644
index 000000000000..c045eee75f27
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
@@ -0,0 +1,25 @@
+[    0.060000] printk: console [mc-1] enabled
+[    0.060000] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000] TAP version 14
+[    0.060000] 	# Subtest: kunit-resource-test
+[    0.060000] 	1..5
+[    0.060000] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000] ok 1 - kunit-resource-test
+[    0.060000] 	# Subtest: kunit-try-catch-test
+[    0.060000] 	1..2
+[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000] ok 2 - kunit-try-catch-test
+[    0.060000] 	# Subtest: string-stream-test
+[    0.060000] 	1..3
+[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000] 	Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000] Stack:
+[    0.060000]  602086f8 601bc260 705c0000 705c0000
+[    0.060000]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
new file mode 100644
index 000000000000..bc48407dcc36
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_multiple_prefixes.log
@@ -0,0 +1,31 @@
+[    0.060000][    T1] printk: console [mc-1] enabled
+[    0.060000][    T1] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000][    T1] TAP version 14
+[    0.060000][    T1] 	# Subtest: kunit-resource-test
+[    0.060000][    T1] 	1..5
+[    0.060000][    T1] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000][    T1] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000][    T1] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000][    T1] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000][    T1] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000][    T1] ok 1 - kunit-resource-test
+[    0.060000][    T1] 	# Subtest: kunit-try-catch-test
+[    0.060000][    T1] 	1..2
+[    0.060000][    T1] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000][    T1] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000][    T1] ok 2 - kunit-try-catch-test
+[    0.060000][    T1] 	# Subtest: string-stream-test
+[    0.060000][    T1] 	1..3
+[    0.060000][    T1] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000][    T1] 	ok 2 - string_stream_test_not_empty_after_add
+[    0.060000][    T1] 	ok 3 - string_stream_test_get_string
+[    0.060000][    T1] ok 3 - string-stream-test
+[    0.060000][    T1] List of all partitions:
+[    0.060000][    T1] No filesystem could mount root, tried:
+[    0.060000][    T1]
+[    0.060000][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000][    T1] Stack:
+[    0.060000][    T1]  602086f8 601bc260 705c0000 705c0000
+[    0.060000][    T1]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000][    T1]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log b/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
new file mode 100644
index 000000000000..0f87cdabebb0
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
@@ -0,0 +1,33 @@
+[    0.060000] printk: console [mc-1] enabled
+[    0.060000] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000] TAP version 14
+[    0.060000] 	# Subtest: kunit-resource-test
+[    0.060000] 	1..5
+[    0.060000] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000]  foo bar 	#
+[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000] ok 1 - kunit-resource-test
+[    0.060000]  foo bar 	# non-kunit output
+[    0.060000] 	# Subtest: kunit-try-catch-test
+[    0.060000] 	1..2
+[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000] ok 2 - kunit-try-catch-test
+[    0.060000] 	# Subtest: string-stream-test
+[    0.060000] 	1..3
+[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000] 	ok 2 - string_stream_test_not_empty_after_add
+[    0.060000] 	ok 3 - string_stream_test_get_string
+[    0.060000] ok 3 - string-stream-test
+[    0.060000] List of all partitions:
+[    0.060000] No filesystem could mount root, tried:
+[    0.060000]
+[    0.060000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000] Stack:
+[    0.060000]  602086f8 601bc260 705c0000 705c0000
+[    0.060000]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
new file mode 100644
index 000000000000..2ceb360be7d5
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_pound_no_prefix.log
@@ -0,0 +1,33 @@
+ printk: console [mc-1] enabled
+ random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+ TAP version 14
+ 	# Subtest: kunit-resource-test
+ 	1..5
+ 	ok 1 - kunit_resource_test_init_resources
+ 	ok 2 - kunit_resource_test_alloc_resource
+ 	ok 3 - kunit_resource_test_destroy_resource
+  foo bar 	#
+ 	ok 4 - kunit_resource_test_cleanup_resources
+ 	ok 5 - kunit_resource_test_proper_free_ordering
+ ok 1 - kunit-resource-test
+  foo bar 	# non-kunit output
+ 	# Subtest: kunit-try-catch-test
+ 	1..2
+ 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+ 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+ ok 2 - kunit-try-catch-test
+ 	# Subtest: string-stream-test
+ 	1..3
+ 	ok 1 - string_stream_test_empty_on_creation
+ 	ok 2 - string_stream_test_not_empty_after_add
+ 	ok 3 - string_stream_test_get_string
+ ok 3 - string-stream-test
+ List of all partitions:
+ No filesystem could mount root, tried:
+
+ Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+ CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+ Stack:
+  602086f8 601bc260 705c0000 705c0000
+  602086f8 6005fcec 705c0000 6002c6ab
+  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
new file mode 100644
index 000000000000..0f87cdabebb0
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_pound_sign.log
@@ -0,0 +1,33 @@
+[    0.060000] printk: console [mc-1] enabled
+[    0.060000] random: get_random_bytes called from init_oops_id+0x35/0x40 with crng_init=0
+[    0.060000] TAP version 14
+[    0.060000] 	# Subtest: kunit-resource-test
+[    0.060000] 	1..5
+[    0.060000] 	ok 1 - kunit_resource_test_init_resources
+[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
+[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
+[    0.060000]  foo bar 	#
+[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
+[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
+[    0.060000] ok 1 - kunit-resource-test
+[    0.060000]  foo bar 	# non-kunit output
+[    0.060000] 	# Subtest: kunit-try-catch-test
+[    0.060000] 	1..2
+[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
+[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
+[    0.060000] ok 2 - kunit-try-catch-test
+[    0.060000] 	# Subtest: string-stream-test
+[    0.060000] 	1..3
+[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
+[    0.060000] 	ok 2 - string_stream_test_not_empty_after_add
+[    0.060000] 	ok 3 - string_stream_test_get_string
+[    0.060000] ok 3 - string-stream-test
+[    0.060000] List of all partitions:
+[    0.060000] No filesystem could mount root, tried:
+[    0.060000]
+[    0.060000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
+[    0.060000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-gea2dd7c0875e-dirty #2
+[    0.060000] Stack:
+[    0.060000]  602086f8 601bc260 705c0000 705c0000
+[    0.060000]  602086f8 6005fcec 705c0000 6002c6ab
+[    0.060000]  6005fcec 601bc260 705c0000 3000000010
\ No newline at end of file
-- 
2.25.0.265.gbab2e86ba0-goog

