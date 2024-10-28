Return-Path: <linux-kselftest+bounces-20863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078599B3DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8CD282C3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188291F12F0;
	Mon, 28 Oct 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXknwB5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E581D6DA9
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155389; cv=none; b=V2we7b5BJ9GDpipEhMzwIcxJUq3CaNjUj8oEsX0Y+vtw8YpEEcRDxTZ7MATFk5K1pBZgmMy8nwmtxp1nLPTym+bxyxo2exIJ8M68w5tz+ETABt7TbrB69qF3V7obIGgad90OhiM1JnpDCBX+yVpfqnFNs5rQ4VMwSA30XkwR/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155389; c=relaxed/simple;
	bh=8UYfq6xwx6PNtegsJSe3u2bb0htlA3pYvuHVzb2aZQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IhCloWD0ztlbD3T8l22JOuipa7VRrrIJglGtuxiGf1gb1zMkdSxW2UzGik3WAoptsCknJ5pOmpn61uVMxFgmLwXzr7rk4KMArYyoKK3n+/3tQ7AF+Y2rZ8JTYAPWmRsh19FDZE73ZRnrT0gH//A8biBwTf7MZB9mcZf/MXyvQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXknwB5V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so1169680276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730155385; x=1730760185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbBJoA36Gli9bgRVl0932SSYsBNkIONPnI8+Rr/oPns=;
        b=DXknwB5V3P+WJ8Y9GA4B1yWZsi/sxWGqJ8uAeCqHlYgQ8anOasJQR5WnWI/6/Vfpox
         zXhp4UgeW19jeK+ZcJ7BdcDMeR0j3HzsvkFZZWjiJsUqVDWejlCLB1m4Sz7cqD1LiDUn
         yQhKKjAsVgQs7qLgE+vX377GYMGOBTOF0gDd+XG6KhuQEtVjF73DfQjZPv3g6oytKT97
         LkagbQAZf6QgOb2YMTr7cRRs8QhKMvvuPYNritGesZrc/2GIrUeZnYfBVRNSz2oIOsei
         UP1+ZKVdjrN4NfnT2q9NLUScAW/XqXHYW1Re3+XmKvaOZ8Gt47SgVosWCNsafpaXB7dC
         Hz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155385; x=1730760185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbBJoA36Gli9bgRVl0932SSYsBNkIONPnI8+Rr/oPns=;
        b=L8xGMkLgKn2F+yiP9w3btCYjdXyJ0E76g5AJ7JD3chTTP6sow94b8HKXK9yU6g2AXx
         YxJ32NuOexFrHtuYwg80TdHEFF5ecv0Q1XlapgnT5Uas/2a+iepTZg5A3fSjzDqKC5JY
         hsvbSYngciIbErgTg8a83Qj4PeFE8A3mGDaD4E0nAOITeBG29w+b7uBx735krIQrzWCM
         V+NTCESISZhWzu6Ui5Gzq/bBqWn22nd36pBqRl+ep4RESSHYgJ8KnBxbFl5odNM3EXOZ
         1wB18m1CjCfl5nY/VN6Lv9bNVrhZnfvLo0gAgwd54sGDYE5pUKFZIN8iBA3eerRoB/+7
         CxOg==
X-Gm-Message-State: AOJu0Yyuk9HdtT5cgrhwaACoi+3HZ/ca+92txrwxiJHAUyrWsyQpdS1t
	5h3KTBYvBU2IOIji5177adWJn1JXkfWgEwhrnC0PvSr4vG5h+VMR6kVoj+GexFt+UOyS+IgDLA=
	=
X-Google-Smtp-Source: AGHT+IFvatkdCtoyho0ieIBR6oSRfF86vOVmn/8Pd66qP1jxuO1WDjoku1lx3X6/JeabxEIVtMLEurx4nQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:d3:4d64:ac12:6a5d])
 (user=rmoar job=sendgmr) by 2002:a05:6902:686:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e3087b82cecmr6608276.5.1730155385386; Mon, 28 Oct 2024 15:43:05
 -0700 (PDT)
Date: Mon, 28 Oct 2024 22:42:42 +0000
In-Reply-To: <20241028224242.3304844-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028224242.3304844-1-rmoar@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028224242.3304844-2-rmoar@google.com>
Subject: [PATCH 2/2] kunit: tool: print failed tests only
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, brendanhiggins@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add flag --failed to kunit.py to print only failed tests. This printing
is done after running is over.

This patch also adds the method print_test() that will also print your
Test object. Before, all printing of tests occurred during parsing. This
method could be useful in the future when converting to/from KTAP to this
pretty-print output.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit.py           | 14 ++++++++++++--
 tools/testing/kunit/kunit_parser.py    | 25 +++++++++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py |  6 +++---
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 27c55a7fc1a0..676fa99a8b19 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -50,6 +50,7 @@ class KunitParseRequest:
 	raw_output: Optional[str]
 	json: Optional[str]
 	summary: bool
+	failed: bool
 
 @dataclass
 class KunitExecRequest(KunitParseRequest):
@@ -237,13 +238,15 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
 
 	default_printer = stdout
-	if request.summary:
+	if request.summary or request.failed:
 		default_printer = null_printer
 
 	# Actually parse the test results.
 	test = kunit_parser.parse_run_tests(input_data, default_printer)
 	parse_time = time.time() - parse_start
 
+	if request.failed:
+		kunit_parser.print_test(test, request.failed, stdout)
 	kunit_parser.print_summary_line(test, stdout)
 
 	if request.json:
@@ -423,6 +426,10 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 			    help='Prints only the summary line for parsed test results.'
 				'Does nothing if --raw_output is set.',
 			    action='store_true')
+	parser.add_argument('--failed',
+			    help='Prints only the failed parsed test results and summary line.'
+				'Does nothing if --raw_output is set.',
+			    action='store_true')
 
 
 def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
@@ -459,6 +466,7 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					raw_output=cli_args.raw_output,
 					json=cli_args.json,
 					summary=cli_args.summary,
+					failed=cli_args.failed,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
 					filter=cli_args.filter,
@@ -507,6 +515,7 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 					build_dir=cli_args.build_dir,
 					json=cli_args.json,
 					summary=cli_args.summary,
+					failed=cli_args.failed,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
 					filter=cli_args.filter,
@@ -532,7 +541,8 @@ def parse_handler(cli_args: argparse.Namespace) -> None:
 	# We know nothing about how the result was created!
 	metadata = kunit_json.Metadata()
 	request = KunitParseRequest(raw_output=cli_args.raw_output,
-					json=cli_args.json, summary=cli_args.summary)
+					json=cli_args.json, summary=cli_args.summary,
+					failed=cli_args.failed)
 	result, _ = parse_tests(request, metadata, kunit_output)
 	if result.status != KunitStatus.SUCCESS:
 		sys.exit(1)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 732f448263de..29fc27e8949b 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -574,7 +574,32 @@ def print_test_footer(test: Test, printer: Printer) -> None:
 	printer.print_with_timestamp(format_test_divider(message,
 		len(message) - printer.color_len()))
 
+def print_test(test: Test, failed_only: bool, printer: Printer) -> None:
+	"""
+	Prints Test object to given printer. For a child test, the result line is
+	printed. For a parent test, the test header, all child test results, and
+	the test footer are all printed. If failed_only is true, only failed/crashed
+	tests will be printed.
 
+	Parameters:
+	test - Test object to print
+	failed_only - True if only failed/crashed tests should be printed.
+	printer - Printer object to output results
+	"""
+	if test.name == "main":
+		printer.print_with_timestamp(DIVIDER)
+		for subtest in test.subtests:
+			print_test(subtest, failed_only, printer)
+		printer.print_with_timestamp(DIVIDER)
+	elif test.subtests != []:
+		if not failed_only or not test.ok_status():
+			print_test_header(test, printer)
+			for subtest in test.subtests:
+				print_test(subtest, failed_only, printer)
+			print_test_footer(test, printer)
+	else:
+		if not failed_only or not test.ok_status():
+			print_test_result(test, printer)
 
 def _summarize_failed_tests(test: Test) -> str:
 	"""Tries to summarize all the failing subtests in `test`."""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 02aa296d8850..0bcb0cc002f8 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -811,7 +811,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -824,7 +824,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
+				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', filter_action=None, timeout=300),
@@ -837,7 +837,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
+				     kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', filter_action=None, timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', filter_action=None, timeout=300),
-- 
2.47.0.163.g1226f6d8fa-goog


