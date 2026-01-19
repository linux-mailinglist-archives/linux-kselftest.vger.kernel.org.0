Return-Path: <linux-kselftest+bounces-49332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DBCD3A021
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C7430B5541
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD23336EC1;
	Mon, 19 Jan 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoqkRW0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001E2FB622
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808070; cv=none; b=J1NQK3PzebZaDG+D6mTr5p1GF3TbUjMhOX8qzD6HfgvSKfra7TR24YDYyB898KsqC+xv/ewtBoqiIkTgnkDS9kpNDRg7cj2FHqJAYWiLREcYzTJABq5RvWEgamuA3fiqTRaWHn2sTitad4hoDxjxC1hEYrXRl1r2wfrc00urS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808070; c=relaxed/simple;
	bh=udKRukIADJ+OlxExOBoDd539goTziNEtiqDK8arDYCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RHFUxEKgkm92rdwxt4tfl24KsodxhOnneAgNcpeiDSGGRWZx834P2JcAJ3Kgwau3nUhwN47qpc2BqG+Pw7qUsweN9QAO41RIkocUrYP2vZr+TW+EcKeyX0GcSmAIvYlSwpZ3xRswLcGAC7nZgmr6ZMBZQPPuhli3OtKGTAfSe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoqkRW0P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a13be531b2so39038005ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 23:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768808068; x=1769412868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuTbrg9rNxI7eBLFcdHRWL8vG9tYu7EW+ZDjzShaDEk=;
        b=xoqkRW0P5AAf6Y3mc+AcdIaxpbejw8YQwrsA9nqDyGPdX7fJgHVmrlls8PSCXGq9lv
         WuBirIMT236qcrRcBuuCKTOt+BwQ84X8EwmFslchMax4jrj0dzBEOQN5KyhFbxQh/cta
         XBvdlcWnU/dDp6LNcBBo/y0+4TqeNllURLdRtr9ZGB6JSb3vNJbdxFXCtG54yGfLULWz
         1V+xsfGmjtRxTPpiG56lcdkarNTxrVJFJxUohlitac5OTbce+N8+S0jnXDqqRtvaJymH
         WfYRvHi9HmSvoonKSlh/jXRJV2SSX7sQQdR2e3Pp8OEBHtrmKKQjhqIp0/5vXR11TJZh
         tJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808068; x=1769412868;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuTbrg9rNxI7eBLFcdHRWL8vG9tYu7EW+ZDjzShaDEk=;
        b=M49cbqeaU/rTsHdrWsh/oweDuyjBzxFhnuQjEWjYTR4FaF2UAhNujI4iGV3wzGG6jd
         pLKfJzHZdF4bgtPODucbBUYHyjvasamlltEKxU0PndWbte3TvYYoS6SpkX+xngeBwMkp
         pnTNcYOQzOjjIT6fOZOuz7dSNkKnuw9FE8j8zY4Q3KQZG8z8j8Ox0WYAG6TVpoSn+Sdg
         bd2mPYZ4E2tRK0HWzUY9Cmr6Zp5IIuUWTUcg2Cw69SW/myT2iarF0EbfeQmdIHL+DRiU
         VqL9C6Ve6qvPb1RxuMDGAUp9K0hmX4YVibyfLPSHm9NJm+0TAnxeWZt8o6bNCUaYdpYv
         bkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPBg2YZjaZ+xRCL74LIff8dwafIrkC1SZOJhqX8fVPskCLiHZdyMad54j99B/k6z7Tump3dmzjz0EqS33LtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiY60icdHueXZTonqR0rYpU8mNdlvI0AP1X6Vvj8qK7Umd0CMS
	Rxe/I7JEVDzaasONmRRW2xFcpBTazr0xSaTXRJXkbdbC+zFbLLqZKmsAl1C/YRW6EKMuvK49A6m
	zyvWmX7xXEupo7A==
X-Received: from plwg14.prod.google.com ([2002:a17:902:f74e:b0:2a0:bb0f:ea50])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cccf:b0:298:1288:e873 with SMTP id d9443c01a7336-2a7177e7cc2mr92749315ad.56.1768808068198;
 Sun, 18 Jan 2026 23:34:28 -0800 (PST)
Date: Mon, 19 Jan 2026 15:34:24 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119073426.1952867-1-davidgow@google.com>
Subject: [PATCH] kunit: tool: Add (primitive) support for outputting JUnit XML
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	workflows@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

This is used by things like Jenkins and other CI systems, which can
pretty-print the test output and potentially provide test-level comparisons
between runs.

The implementation here is pretty basic: it only provides the raw results,
split into tests and test suites, and doesn't provide any overall metadata.
However, CI systems like Jenkins can injest it and it is already useful.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst |  3 ++
 tools/testing/kunit/kunit.py                  | 25 +++++++++++-
 tools/testing/kunit/kunit_junit.py            | 36 +++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py        | 40 +++++++++++++++++--
 4 files changed, 100 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/kunit/kunit_junit.py

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 6697c71ee8ca..e5c318162581 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -324,6 +324,9 @@ command line arguments:
 - ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
   saves to a file if a filename is specified.
 
+- ``--junit``: If set, stores the test results in JUnit XML format and prints to `stdout` or
+  saves to a file if a filename is specified.
+
 - ``--filter``: Specifies filters on test attributes, for example, ``speed!=slow``.
   Multiple filters can be used by wrapping input in quotes and separating filters
   by commas. Example: ``--filter "speed>slow, module=example"``.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e3d82a038f93..0698d27c3629 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -21,6 +21,7 @@ from enum import Enum, auto
 from typing import Iterable, List, Optional, Sequence, Tuple
 
 import kunit_json
+import kunit_junit
 import kunit_kernel
 import kunit_parser
 from kunit_printer import stdout, null_printer
@@ -49,6 +50,7 @@ class KunitBuildRequest(KunitConfigRequest):
 class KunitParseRequest:
 	raw_output: Optional[str]
 	json: Optional[str]
+	junit: Optional[str]
 	summary: bool
 	failed: bool
 
@@ -261,6 +263,17 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 			stdout.print_with_timestamp("Test results stored in %s" %
 				os.path.abspath(request.json))
 
+	if request.junit:
+		junit_str = kunit_junit.get_junit_result(
+					test=test)
+		if request.junit == 'stdout':
+			print(junit_str)
+		else:
+			with open(request.junit, 'w') as f:
+				f.write(junit_str)
+			stdout.print_with_timestamp("Test results stored in %s" %
+				os.path.abspath(request.junit))
+
 	if test.status != kunit_parser.TestStatus.SUCCESS:
 		return KunitResult(KunitStatus.TEST_FAILURE, parse_time), test
 
@@ -302,6 +315,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 # So we hackily automatically rewrite --json => --json=stdout
 pseudo_bool_flag_defaults = {
 		'--json': 'stdout',
+		'--junit': 'stdout',
 		'--raw_output': 'kunit',
 }
 def massage_argv(argv: Sequence[str]) -> Sequence[str]:
@@ -436,6 +450,11 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 			    help='Prints parsed test results as JSON to stdout or a file if '
 			    'a filename is specified. Does nothing if --raw_output is set.',
 			    type=str, const='stdout', default=None, metavar='FILE')
+	parser.add_argument('--junit',
+			    nargs='?',
+			    help='Prints parsed test results as JUnit XML to stdout or a file if '
+			    'a filename is specified. Does nothing if --raw_output is set.',
+			    type=str, const='stdout', default=None, metavar='FILE')
 	parser.add_argument('--summary',
 			    help='Prints only the summary line for parsed test results.'
 				'Does nothing if --raw_output is set.',
@@ -479,6 +498,7 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					jobs=cli_args.jobs,
 					raw_output=cli_args.raw_output,
 					json=cli_args.json,
+					junit=cli_args.junit,
 					summary=cli_args.summary,
 					failed=cli_args.failed,
 					timeout=cli_args.timeout,
@@ -528,6 +548,7 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 	exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
 					build_dir=cli_args.build_dir,
 					json=cli_args.json,
+					junit=cli_args.junit,
 					summary=cli_args.summary,
 					failed=cli_args.failed,
 					timeout=cli_args.timeout,
@@ -555,7 +576,9 @@ def parse_handler(cli_args: argparse.Namespace) -> None:
 	# We know nothing about how the result was created!
 	metadata = kunit_json.Metadata()
 	request = KunitParseRequest(raw_output=cli_args.raw_output,
-					json=cli_args.json, summary=cli_args.summary,
+					json=cli_args.json,
+					junit=cli_args.junit,
+					summary=cli_args.summary,
 					failed=cli_args.failed)
 	result, _ = parse_tests(request, metadata, kunit_output)
 	if result.status != KunitStatus.SUCCESS:
diff --git a/tools/testing/kunit/kunit_junit.py b/tools/testing/kunit/kunit_junit.py
new file mode 100644
index 000000000000..58d482e0c793
--- /dev/null
+++ b/tools/testing/kunit/kunit_junit.py
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generates JSON from KUnit results according to
+# KernelCI spec: https://github.com/kernelci/kernelci-doc/wiki/Test-API
+#
+# Copyright (C) 2025, Google LLC.
+# Author: David Gow <davidgow@google.com>
+
+
+from kunit_parser import Test, TestStatus
+
+def escape_xml_string(string : str) -> str:
+	return string.replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&apos;").replace("<", "&lt;").replace(">", "&gt;")
+
+def get_test_suite(test: Test) -> str:
+	xml_output = '<testsuite name="' + escape_xml_string(test.name) + '" tests="' + str(test.counts.total()) + '" failures="' + str(test.counts.failed) + '" skipped="' +str(test.counts.skipped) + '">\n'
+
+	for subtest in test.subtests:
+		if subtest.subtests:
+			xml_output += get_test_suite(subtest)
+			continue
+		xml_output += '<testcase name="' + escape_xml_string(subtest.name) + '" >\n'
+		if subtest.status == TestStatus.FAILURE:
+			xml_output += '<failure>Test Failed</failure>\n'
+		xml_output += '<system-out><![CDATA[' + "\n".join(subtest.log) + ']]></system-out>\n'
+		xml_output += '</testcase>\n'
+
+	xml_output += '</testsuite>\n\n'
+
+	return xml_output
+
+def get_junit_result(test: Test) -> str:
+	xml_output = '<?xml version="1.0" encoding="UTF-8" ?>\n\n'
+
+	xml_output += get_test_suite(test)
+	return xml_output
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 238a31a5cc29..e29ef4162f9e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -22,6 +22,7 @@ import kunit_config
 import kunit_parser
 import kunit_kernel
 import kunit_json
+import kunit_junit
 import kunit
 from kunit_printer import stdout
 
@@ -606,6 +607,39 @@ class StrContains(str):
 	def __eq__(self, other):
 		return self in other
 
+class KUnitJUnitTest(unittest.TestCase):
+	def setUp(self):
+		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
+		self.addCleanup(mock.patch.stopall)
+
+	def _junit_string(self, log_file):
+		with open(_test_data_path(log_file)) as file:
+			test_result = kunit_parser.parse_run_tests(file, stdout)
+			junit_string = kunit_junit.get_junit_result(
+					test=test_result)
+		return junit_string
+
+	def test_xml_escape(self):
+		self.assertEqual(kunit_junit.escape_xml_string("qwertyuiop"), "qwertyuiop")
+		self.assertEqual(kunit_junit.escape_xml_string("\"quoted\""), "&quot;quoted&quot;")
+		self.assertEqual(kunit_junit.escape_xml_string("'quoted'"), "&apos;quoted&apos;")
+		self.assertEqual(kunit_junit.escape_xml_string("<tag>"), "&lt;tag&gt;")
+		self.assertEqual(kunit_junit.escape_xml_string("&amp;"), "&amp;amp;")
+
+	def test_failed_test_junit(self):
+		result = self._junit_string('test_is_test_passed-failure.log')
+		self.assertTrue("<failure>" in result)
+
+	def test_skipped_test_junit(self):
+		result = self._junit_string('test_skip_tests.log')
+		self.assertTrue("skipped=\"1\"" in result)
+
+	def test_no_tests_junit(self):
+		result = self._junit_string('test_is_test_passed-no_tests_run_with_header.log')
+		self.assertTrue("tests=\"0\"" in result)
+		self.assertFalse("testcase" in result)
+
+
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
 		path = _test_data_path('test_is_test_passed-all_passed.log')
@@ -853,7 +887,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -866,7 +900,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, None, False, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', filter_action=None, timeout=300),
@@ -879,7 +913,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
+				     kunit.KunitExecRequest(None, None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', filter_action=None, timeout=300),
-- 
2.52.0.457.g6b5491de43-goog


