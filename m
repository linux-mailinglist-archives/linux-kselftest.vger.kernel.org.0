Return-Path: <linux-kselftest+bounces-20862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740789B3DF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1951F22DE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38C1EE02A;
	Mon, 28 Oct 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDs6MRHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628518EFEC
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155387; cv=none; b=bPpMw1U8FSXGstGns7F/LkJd3/ujb74H7FjtC/9kH4VPgLhiHRObDImlBY85DfQEKi3zBqEOvvz8dYS+8uYzT/FIkonNoOoGDk+QFdycUVfw75vIPLJU10X9+mZiFmhRXM2MUUEhiyaK6QB5vViA/VGrJ9YloNW06untgEJN2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155387; c=relaxed/simple;
	bh=GeRrlMBKs5rs9DZrm1UVlwKIO/cDalwmRbb5qwZcGxg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZgRZq03i6CF9zeWq++bHt3alCVeJ5A+DTagm2xmwQmCU5uP1hZMM01FqMm05Xo137q+xgr71oonyo3Ng7bGcZgCz//C5krvyk0ACA7/hThD7qzJWxRcknoi7suHXv5JIZlQ3DYH6nAP57Ly4LRMbOV3bEsBg2jhyW0ycJxcqvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDs6MRHy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370139342so88567047b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730155382; x=1730760182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=COwkoEftmce/Sk3aU2Jujaktad4dJCqzilFCUnk5xfs=;
        b=xDs6MRHyl4v7wc5Rk3Ei5QSAMYaoZ6F+momzA7yGfwn/aOSr44wRycadhjSh+tcEcb
         /T/yhi5GrsbdIzizsw3naObjR2chYQbQccFqqS2yWu3WzrzQpTAOD6xEtouXER5X8Z7D
         Oel/mOgeOs4VHdXG6GePmge2KNnZ1KbTarHE1cbL1xjnTPYQiMieP5q7xfQjL1qddoQw
         5SlGLolUv/gAzEPQuDwMGPqrqeXvfN0bNPZtXYuPr9aoXoDtnrgTZOcV1rM8Nv3Vnf1n
         yo+wW9e/peQcmmJ8qoLuaw6SjK9jdYmVauOSKd1f7a+oWqKnASyJY8VxyXygniU4gXus
         bTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155382; x=1730760182;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COwkoEftmce/Sk3aU2Jujaktad4dJCqzilFCUnk5xfs=;
        b=GXzJsMsXcEoXNkUy6kLnEryH27foL5fnYpScY0s8+/FADXBc5rd6//Wq7WdSi67BCH
         rO/dOxJWl+/S9Kt50SpuOa21nUzkJXbGIWPqc1hcbJK6mQqsVq+xj6CWptERA6T31ZrU
         WO+xhawNM4jNxivI+YAKML2NrElQBZYTJ8TJxxayuxYku9O80sXVrn5eQcussepz83NX
         V2SbiArq4GsbzaKXmQtGn9Oe/oAyebxeMpX/izMz4k/nF2aZDohwbkGLiLglVBEiOAtC
         HOglDxQ/11m8XDVzRsVbdj1UXtBmdD3VV9i4bp0FSiEWWygBOANfMFoyYJu1FTVhSMCN
         e8Zg==
X-Gm-Message-State: AOJu0Yz1JYaW4QUFa9aP70A9j+pDrLuxZpP16PkF0mLGbknQgxw4IYKr
	M4PsJlvau5Q4/Uq0SnxJYF9ZLbCOdYENREMFbOMZOwe16eyEOMtiJqMehEK5g/RxIbzn37VvIg=
	=
X-Google-Smtp-Source: AGHT+IGjGf2jLUndG4CJ0BHq8C0m11VvzecvpDuQcp4lj2Rb34Pluv2x7Io3FFDWv6poWKViD/w9vDytEQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:d3:4d64:ac12:6a5d])
 (user=rmoar job=sendgmr) by 2002:a05:690c:4a02:b0:6e3:b08:92c7 with SMTP id
 00721157ae682-6e9d87070a8mr6366087b3.0.1730155381665; Mon, 28 Oct 2024
 15:43:01 -0700 (PDT)
Date: Mon, 28 Oct 2024 22:42:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028224242.3304844-1-rmoar@google.com>
Subject: [PATCH 1/2] kunit: tool: Only print the summary
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, brendanhiggins@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Gow <davidgow@google.com>

Allow only printing the summary at the end of a test run, rather than all
individual test results. This summary will list a few failing tests if
there are any.

To use:

./tools/testing/kunit/kunit.py run --summary

Signed-off-by: Rae Moar <rmoar@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py           |  18 +++-
 tools/testing/kunit/kunit_parser.py    | 109 +++++++++++++------------
 tools/testing/kunit/kunit_printer.py   |   7 +-
 tools/testing/kunit/kunit_tool_test.py |  55 +++++++------
 4 files changed, 107 insertions(+), 82 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458a..27c55a7fc1a0 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -23,7 +23,7 @@ from typing import Iterable, List, Optional, Sequence, Tuple
 import kunit_json
 import kunit_kernel
 import kunit_parser
-from kunit_printer import stdout
+from kunit_printer import stdout, null_printer
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -49,6 +49,7 @@ class KunitBuildRequest(KunitConfigRequest):
 class KunitParseRequest:
 	raw_output: Optional[str]
 	json: Optional[str]
+	summary: bool
 
 @dataclass
 class KunitExecRequest(KunitParseRequest):
@@ -235,11 +236,16 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		parse_time = time.time() - parse_start
 		return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
 
+	default_printer = stdout
+	if request.summary:
+		default_printer = null_printer
 
 	# Actually parse the test results.
-	test = kunit_parser.parse_run_tests(input_data)
+	test = kunit_parser.parse_run_tests(input_data, default_printer)
 	parse_time = time.time() - parse_start
 
+	kunit_parser.print_summary_line(test, stdout)
+
 	if request.json:
 		json_str = kunit_json.get_json_result(
 					test=test,
@@ -413,6 +419,10 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 			    help='Prints parsed test results as JSON to stdout or a file if '
 			    'a filename is specified. Does nothing if --raw_output is set.',
 			    type=str, const='stdout', default=None, metavar='FILE')
+	parser.add_argument('--summary',
+			    help='Prints only the summary line for parsed test results.'
+				'Does nothing if --raw_output is set.',
+			    action='store_true')
 
 
 def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
@@ -448,6 +458,7 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					jobs=cli_args.jobs,
 					raw_output=cli_args.raw_output,
 					json=cli_args.json,
+					summary=cli_args.summary,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
 					filter=cli_args.filter,
@@ -495,6 +506,7 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 	exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
 					build_dir=cli_args.build_dir,
 					json=cli_args.json,
+					summary=cli_args.summary,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
 					filter=cli_args.filter,
@@ -520,7 +532,7 @@ def parse_handler(cli_args: argparse.Namespace) -> None:
 	# We know nothing about how the result was created!
 	metadata = kunit_json.Metadata()
 	request = KunitParseRequest(raw_output=cli_args.raw_output,
-					json=cli_args.json)
+					json=cli_args.json, summary=cli_args.summary)
 	result, _ = parse_tests(request, metadata, kunit_output)
 	if result.status != KunitStatus.SUCCESS:
 		sys.exit(1)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index ce34be15c929..732f448263de 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -17,7 +17,7 @@ import textwrap
 from enum import Enum, auto
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-from kunit_printer import stdout
+from kunit_printer import Printer, stdout
 
 class Test:
 	"""
@@ -54,10 +54,10 @@ class Test:
 		"""Returns string representation of a Test class object."""
 		return str(self)
 
-	def add_error(self, error_message: str) -> None:
+	def add_error(self, printer: Printer, error_message: str) -> None:
 		"""Records an error that occurred while parsing this test."""
 		self.counts.errors += 1
-		stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
+		printer.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
 	def ok_status(self) -> bool:
 		"""Returns true if the status was ok, i.e. passed or skipped."""
@@ -251,7 +251,7 @@ KTAP_VERSIONS = [1]
 TAP_VERSIONS = [13, 14]
 
 def check_version(version_num: int, accepted_versions: List[int],
-			version_type: str, test: Test) -> None:
+			version_type: str, test: Test, printer: Printer) -> None:
 	"""
 	Adds error to test object if version number is too high or too
 	low.
@@ -263,13 +263,14 @@ def check_version(version_num: int, accepted_versions: List[int],
 	version_type - 'KTAP' or 'TAP' depending on the type of
 		version line.
 	test - Test object for current test being parsed
+	printer - Printer object to output error
 	"""
 	if version_num < min(accepted_versions):
-		test.add_error(f'{version_type} version lower than expected!')
+		test.add_error(printer, f'{version_type} version lower than expected!')
 	elif version_num > max(accepted_versions):
-		test.add_error(f'{version_type} version higer than expected!')
+		test.add_error(printer, f'{version_type} version higer than expected!')
 
-def parse_ktap_header(lines: LineStream, test: Test) -> bool:
+def parse_ktap_header(lines: LineStream, test: Test, printer: Printer) -> bool:
 	"""
 	Parses KTAP/TAP header line and checks version number.
 	Returns False if fails to parse KTAP/TAP header line.
@@ -281,6 +282,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	Parameters:
 	lines - LineStream of KTAP output to parse
 	test - Test object for current test being parsed
+	printer - Printer object to output results
 
 	Return:
 	True if successfully parsed KTAP/TAP header line
@@ -289,10 +291,10 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	tap_match = TAP_START.match(lines.peek())
 	if ktap_match:
 		version_num = int(ktap_match.group(1))
-		check_version(version_num, KTAP_VERSIONS, 'KTAP', test)
+		check_version(version_num, KTAP_VERSIONS, 'KTAP', test, printer)
 	elif tap_match:
 		version_num = int(tap_match.group(1))
-		check_version(version_num, TAP_VERSIONS, 'TAP', test)
+		check_version(version_num, TAP_VERSIONS, 'TAP', test, printer)
 	else:
 		return False
 	lines.pop()
@@ -380,7 +382,7 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	return name == test.name
 
 def parse_test_result(lines: LineStream, test: Test,
-			expected_num: int) -> bool:
+			expected_num: int, printer: Printer) -> bool:
 	"""
 	Parses test result line and stores the status and name in the test
 	object. Reports an error if the test number does not match expected
@@ -398,6 +400,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	lines - LineStream of KTAP output to parse
 	test - Test object for current test being parsed
 	expected_num - expected test number for current test
+	printer - Printer object to output results
 
 	Return:
 	True if successfully parsed a test result line.
@@ -420,7 +423,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	# Check test num
 	num = int(match.group(2))
 	if num != expected_num:
-		test.add_error(f'Expected test number {expected_num} but found {num}')
+		test.add_error(printer, f'Expected test number {expected_num} but found {num}')
 
 	# Set status of test object
 	status = match.group(1)
@@ -486,7 +489,7 @@ def format_test_divider(message: str, len_message: int) -> str:
 		len_2 = difference - len_1
 	return ('=' * len_1) + f' {message} ' + ('=' * len_2)
 
-def print_test_header(test: Test) -> None:
+def print_test_header(test: Test, printer: Printer) -> None:
 	"""
 	Prints test header with test name and optionally the expected number
 	of subtests.
@@ -496,6 +499,7 @@ def print_test_header(test: Test) -> None:
 
 	Parameters:
 	test - Test object representing current test being printed
+	printer - Printer object to output results
 	"""
 	message = test.name
 	if message != "":
@@ -507,15 +511,15 @@ def print_test_header(test: Test) -> None:
 			message += '(1 subtest)'
 		else:
 			message += f'({test.expected_count} subtests)'
-	stdout.print_with_timestamp(format_test_divider(message, len(message)))
+	printer.print_with_timestamp(format_test_divider(message, len(message)))
 
-def print_log(log: Iterable[str]) -> None:
+def print_log(log: Iterable[str], printer: Printer) -> None:
 	"""Prints all strings in saved log for test in yellow."""
 	formatted = textwrap.dedent('\n'.join(log))
 	for line in formatted.splitlines():
-		stdout.print_with_timestamp(stdout.yellow(line))
+		printer.print_with_timestamp(printer.yellow(line))
 
-def format_test_result(test: Test) -> str:
+def format_test_result(test: Test, printer: Printer) -> str:
 	"""
 	Returns string with formatted test result with colored status and test
 	name.
@@ -525,23 +529,24 @@ def format_test_result(test: Test) -> str:
 
 	Parameters:
 	test - Test object representing current test being printed
+	printer - Printer object to output results
 
 	Return:
 	String containing formatted test result
 	"""
 	if test.status == TestStatus.SUCCESS:
-		return stdout.green('[PASSED] ') + test.name
+		return printer.green('[PASSED] ') + test.name
 	if test.status == TestStatus.SKIPPED:
-		return stdout.yellow('[SKIPPED] ') + test.name
+		return printer.yellow('[SKIPPED] ') + test.name
 	if test.status == TestStatus.NO_TESTS:
-		return stdout.yellow('[NO TESTS RUN] ') + test.name
+		return printer.yellow('[NO TESTS RUN] ') + test.name
 	if test.status == TestStatus.TEST_CRASHED:
-		print_log(test.log)
+		print_log(test.log, printer)
 		return stdout.red('[CRASHED] ') + test.name
-	print_log(test.log)
-	return stdout.red('[FAILED] ') + test.name
+	print_log(test.log, printer)
+	return printer.red('[FAILED] ') + test.name
 
-def print_test_result(test: Test) -> None:
+def print_test_result(test: Test, printer: Printer) -> None:
 	"""
 	Prints result line with status of test.
 
@@ -550,10 +555,11 @@ def print_test_result(test: Test) -> None:
 
 	Parameters:
 	test - Test object representing current test being printed
+	printer - Printer object
 	"""
-	stdout.print_with_timestamp(format_test_result(test))
+	printer.print_with_timestamp(format_test_result(test, printer))
 
-def print_test_footer(test: Test) -> None:
+def print_test_footer(test: Test, printer: Printer) -> None:
 	"""
 	Prints test footer with status of test.
 
@@ -562,10 +568,11 @@ def print_test_footer(test: Test) -> None:
 
 	Parameters:
 	test - Test object representing current test being printed
+	printer - Printer object to output results
 	"""
-	message = format_test_result(test)
-	stdout.print_with_timestamp(format_test_divider(message,
-		len(message) - stdout.color_len()))
+	message = format_test_result(test, printer)
+	printer.print_with_timestamp(format_test_divider(message,
+		len(message) - printer.color_len()))
 
 
 
@@ -601,7 +608,7 @@ def _summarize_failed_tests(test: Test) -> str:
 	return 'Failures: ' + ', '.join(failures)
 
 
-def print_summary_line(test: Test) -> None:
+def print_summary_line(test: Test, printer: Printer) -> None:
 	"""
 	Prints summary line of test object. Color of line is dependent on
 	status of test. Color is green if test passes, yellow if test is
@@ -614,6 +621,7 @@ def print_summary_line(test: Test) -> None:
 	Errors: 0"
 
 	test - Test object representing current test being printed
+	printer - Printer object to output results
 	"""
 	if test.status == TestStatus.SUCCESS:
 		color = stdout.green
@@ -621,7 +629,7 @@ def print_summary_line(test: Test) -> None:
 		color = stdout.yellow
 	else:
 		color = stdout.red
-	stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
+	printer.print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
 	# Summarize failures that might have gone off-screen since we had a lot
 	# of tests (arbitrarily defined as >=100 for now).
@@ -630,7 +638,7 @@ def print_summary_line(test: Test) -> None:
 	summarized = _summarize_failed_tests(test)
 	if not summarized:
 		return
-	stdout.print_with_timestamp(color(summarized))
+	printer.print_with_timestamp(color(summarized))
 
 # Other methods:
 
@@ -654,7 +662,7 @@ def bubble_up_test_results(test: Test) -> None:
 	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
 		test.status = TestStatus.TEST_CRASHED
 
-def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool) -> Test:
+def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
 	"""
 	Finds next test to parse in LineStream, creates new Test object,
 	parses any subtests of the test, populates Test object with all
@@ -710,6 +718,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 	log - list of strings containing any preceding diagnostic lines
 		corresponding to the current test
 	is_subtest - boolean indicating whether test is a subtest
+	printer - Printer object to output results
 
 	Return:
 	Test object populated with characteristics and any subtests
@@ -725,14 +734,14 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
 		test.name = "main"
-		ktap_line = parse_ktap_header(lines, test)
+		ktap_line = parse_ktap_header(lines, test, printer)
 		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
 		# If not the main test, attempt to parse a test header containing
 		# the KTAP version line and/or subtest header line
-		ktap_line = parse_ktap_header(lines, test)
+		ktap_line = parse_ktap_header(lines, test, printer)
 		subtest_line = parse_test_header(lines, test)
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
@@ -740,7 +749,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 			# to parse test plan and print test header
 			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
-			print_test_header(test)
+			print_test_header(test, printer)
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
@@ -758,16 +767,16 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 				# If parser reaches end of test before
 				# parsing expected number of subtests, print
 				# crashed subtest and record error
-				test.add_error('missing expected subtest!')
+				test.add_error(printer, 'missing expected subtest!')
 				sub_test.log.extend(sub_log)
 				test.counts.add_status(
 					TestStatus.TEST_CRASHED)
-				print_test_result(sub_test)
+				print_test_result(sub_test, printer)
 			else:
 				test.log.extend(sub_log)
 				break
 		else:
-			sub_test = parse_test(lines, test_num, sub_log, True)
+			sub_test = parse_test(lines, test_num, sub_log, True, printer)
 		subtests.append(sub_test)
 		test_num += 1
 	test.subtests = subtests
@@ -775,51 +784,51 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# If not main test, look for test result line
 		test.log.extend(parse_diagnostic(lines))
 		if test.name != "" and not peek_test_name_match(lines, test):
-			test.add_error('missing subtest result line!')
+			test.add_error(printer, 'missing subtest result line!')
 		else:
-			parse_test_result(lines, test, expected_num)
+			parse_test_result(lines, test, expected_num, printer)
 
 	# Check for there being no subtests within parent test
 	if parent_test and len(subtests) == 0:
 		# Don't override a bad status if this test had one reported.
 		# Assumption: no subtests means CRASHED is from Test.__init__()
 		if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
-			print_log(test.log)
+			print_log(test.log, printer)
 			test.status = TestStatus.NO_TESTS
-			test.add_error('0 tests run!')
+			test.add_error(printer, '0 tests run!')
 
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
 	if parent_test and is_subtest:
 		# If test has subtests and is not the main test object, print
 		# footer.
-		print_test_footer(test)
+		print_test_footer(test, printer)
 	elif is_subtest:
-		print_test_result(test)
+		print_test_result(test, printer)
 	return test
 
-def parse_run_tests(kernel_output: Iterable[str]) -> Test:
+def parse_run_tests(kernel_output: Iterable[str], printer: Printer) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
 	results and print condensed test results and summary line.
 
 	Parameters:
 	kernel_output - Iterable object contains lines of kernel output
+	printer - Printer object to output results
 
 	Return:
 	Test - the main test object with all subtests.
 	"""
-	stdout.print_with_timestamp(DIVIDER)
+	printer.print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
 	test = Test()
 	if not lines:
 		test.name = '<missing>'
-		test.add_error('Could not find any KTAP output. Did any KUnit tests run?')
+		test.add_error(printer, 'Could not find any KTAP output. Did any KUnit tests run?')
 		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		test = parse_test(lines, 0, [], False)
+		test = parse_test(lines, 0, [], False, printer)
 		if test.status != TestStatus.NO_TESTS:
 			test.status = test.counts.get_status()
-	stdout.print_with_timestamp(DIVIDER)
-	print_summary_line(test)
+	printer.print_with_timestamp(DIVIDER)
 	return test
diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
index 015adf87dc2c..2c55b4b67bfc 100644
--- a/tools/testing/kunit/kunit_printer.py
+++ b/tools/testing/kunit/kunit_printer.py
@@ -17,10 +17,12 @@ class Printer:
 
 	def __init__(self, output: typing.IO[str]):
 		self._output = output
-		self._use_color = output.isatty()
+		if output is not None:
+			self._use_color = output.isatty()
 
 	def print(self, message: str) -> None:
-		print(message, file=self._output)
+		if self._output is not None:
+			print(message, file=self._output)
 
 	def print_with_timestamp(self, message: str) -> None:
 		ts = datetime.datetime.now().strftime('%H:%M:%S')
@@ -46,3 +48,4 @@ class Printer:
 
 # Provides a default instance that prints to stdout
 stdout = Printer(sys.stdout)
+null_printer = Printer(None)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 2beb7327e53f..02aa296d8850 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -23,6 +23,7 @@ import kunit_parser
 import kunit_kernel
 import kunit_json
 import kunit
+from kunit_printer import stdout
 
 test_tmpdir = ''
 abs_test_data_dir = ''
@@ -139,28 +140,28 @@ class KUnitParserTest(unittest.TestCase):
 	def test_parse_successful_test_log(self):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_successful_nested_tests_log(self):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
 		with open(all_passed_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_kselftest_nested(self):
 		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
 		with open(kselftest_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_failed_test_log(self):
 		failed_log = test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
@@ -168,7 +169,7 @@ class KUnitParserTest(unittest.TestCase):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()), stdout)
 		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS, result.status)
 		self.assertEqual(result.counts.errors, 1)
@@ -179,7 +180,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(missing_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
-				file.readlines()))
+				file.readlines()), stdout)
 		# A missing test plan is not an error.
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -188,7 +189,7 @@ class KUnitParserTest(unittest.TestCase):
 		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
 		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()), stdout)
 		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(kunit_parser.TestStatus.NO_TESTS, result.status)
 		self.assertEqual(result.counts.errors, 1)
@@ -197,7 +198,7 @@ class KUnitParserTest(unittest.TestCase):
 		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
 		with open(no_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()), stdout)
 		self.assertEqual(0, len(result.subtests[0].subtests[0].subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
@@ -210,7 +211,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()), stdout)
 		print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
@@ -219,7 +220,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -228,7 +229,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_skipped_all_tests(self):
 		skipped_log = test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
 		self.assertEqual(kunit_parser.TestStatus.SKIPPED, result.status)
 		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
@@ -236,7 +237,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_ignores_hyphen(self):
 		hyphen_log = test_data_path('test_strip_hyphen.log')
 		with open(hyphen_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -250,7 +251,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertEqual(result.counts.errors, 0)
@@ -258,7 +259,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertEqual(result.counts.errors, 0)
@@ -266,7 +267,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertEqual(result.counts.errors, 0)
@@ -274,7 +275,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertEqual(result.counts.errors, 0)
@@ -282,7 +283,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertGreaterEqual(result.counts.errors, 1)
@@ -290,7 +291,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual('kunit-resource-test', result.subtests[0].name)
 		self.assertEqual(result.counts.errors, 0)
@@ -310,7 +311,7 @@ class KUnitParserTest(unittest.TestCase):
 			not ok 2 - test2
 		not ok 1 - some_failed_suite
 		"""
-		result = kunit_parser.parse_run_tests(output.splitlines())
+		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 
 		self.assertEqual(kunit_parser._summarize_failed_tests(result),
@@ -319,7 +320,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_ktap_format(self):
 		ktap_log = test_data_path('test_parse_ktap_output.log')
 		with open(ktap_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
 		self.assertEqual('suite', result.subtests[0].name)
 		self.assertEqual('case_1', result.subtests[0].subtests[0].name)
@@ -328,13 +329,13 @@ class KUnitParserTest(unittest.TestCase):
 	def test_parse_subtest_header(self):
 		ktap_log = test_data_path('test_parse_subtest_header.log')
 		with open(ktap_log) as file:
-			kunit_parser.parse_run_tests(file.readlines())
+			kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
 	def test_parse_attributes(self):
 		ktap_log = test_data_path('test_parse_attributes.log')
 		with open(ktap_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
 		# Test should pass with no errors
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
@@ -355,7 +356,7 @@ class KUnitParserTest(unittest.TestCase):
 		    Indented more.
 		not ok 1 test1
 		"""
-		result = kunit_parser.parse_run_tests(output.splitlines())
+		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 
 		self.print_mock.assert_any_call(StrContains('Test output.'))
@@ -544,7 +545,7 @@ class KUnitJsonTest(unittest.TestCase):
 
 	def _json_for(self, log_file):
 		with open(test_data_path(log_file)) as file:
-			test_result = kunit_parser.parse_run_tests(file)
+			test_result = kunit_parser.parse_run_tests(file, stdout)
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
 				metadata=kunit_json.Metadata())
@@ -810,7 +811,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -823,7 +824,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', filter_action=None, timeout=300),
@@ -836,7 +837,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
+				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', filter_action=None, timeout=300),

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.47.0.163.g1226f6d8fa-goog


