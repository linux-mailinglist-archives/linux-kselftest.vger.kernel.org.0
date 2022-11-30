Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF963E030
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiK3Syf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 13:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiK3Syc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 13:54:32 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEC863D74
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 10:54:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so12545344pgs.7
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kT7qAueBeGRnOJjj9r+kURoSnmaGiK5XiYcd6AOaEjs=;
        b=KBjf0M5mFzj8Y8FdDNyMasuByqyi/Ln81ZfaaVTpRJq/hZs/smb8OyyKtMCLJL0OwX
         QgXO+vSHteLh44HdAGy/i8wLHg/HRv4y2qoiHTYyOcjNr1EWKAw5Owvbx/5bHNUo9zTy
         JtGMBflHJwIcXi8DBAJA0E93yEw9GlcUC0rymXaPPJ4NyaFOvepzaDwCzySIngnZCgRO
         CpD+41c5Zbj053rMiRV7gpj/XYK6XEVps/+LFqpFQx+/KXcXWgkUuw45RBru0eZP2DYS
         zPkKYOSLVcqjT+oBa879XNwgfc/kvDsBu7qyH4MQmUMmWIquX7bBLYLZ4eA8H17U0i86
         14dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kT7qAueBeGRnOJjj9r+kURoSnmaGiK5XiYcd6AOaEjs=;
        b=U4IkMDErKHLE8yg3tSm3gDnlJja0VL5mcGSMVqQpsV5t32wX2VLczAhYBBzipaBbg4
         Be3CdPbVN7zOyGuuNt7D5oYAlR+Y2EAVbomS1xSD6ME2NNq/IVy2G8K85SbjU9GMZpVh
         HsZYADVpLGIULC8BRyD8jDaHfhIgMOCBF+9C4d+Wk6KElgX/pmO5+T/ijiu5tJrvCyYG
         l6Yaum3vAZ87QyTNUyOO69yElZ8r4R1cilHoiU11L5uT2AkL/4SAcheLm+oxquAKYvGi
         gdXGkpVW7SkXW4iVo+oC8Kfrb2O4nXLmwyeG6bMtqkTOR6fmAkayX+i6Nd4/pb7Juys6
         WSDg==
X-Gm-Message-State: ANoB5pn1j1GDJ0Tfuo7K++uX/lSwqwhd3vHx/eIYdceAO46MrmGvRowf
        22CDKnN+ADSrx5+LlK9NKQSaDlytUXQ9Hw==
X-Google-Smtp-Source: AA0mqf50N2ZHnlyNInYxdEtvcPvTFPBU6JBGmcFP8plOK9ArHUIGpYashXWgYG8PnoEilV1v+VFLWksRuxHpAw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP
 id r33-20020a17090a43a400b002191d0a34a6mr2435533pjg.1.1669834463839; Wed, 30
 Nov 2022 10:54:23 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:54:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130185419.2552673-1-dlatypov@google.com>
Subject: [PATCH] kunit: tool: make parser preserve whitespace when printing
 test log
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, kunit_parser.py is stripping all leading whitespace to make
parsing easier. But this means we can't accurately show kernel output
for failing tests or when the kernel crashes.

Embarassingly, this affects even KUnit's own output, e.g.
[13:40:46] Expected 2 + 1 == 2, but
[13:40:46] 2 + 1 == 3 (0x3)
[13:40:46] not ok 1 example_simple_test
[13:40:46] [FAILED] example_simple_test

After this change, here's what the output in context would look like
[13:40:46] =================== example (4 subtests) ===================
[13:40:46] # example_simple_test: initializing
[13:40:46] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[13:40:46] Expected 2 + 1 == 2, but
[13:40:46]     2 + 1 == 3 (0x3)
[13:40:46] [FAILED] example_simple_test
[13:40:46] [SKIPPED] example_skip_test
[13:40:46] [SKIPPED] example_mark_skipped_test
[13:40:46] [PASSED] example_all_expect_macros_test
[13:40:46]     # example: initializing suite
[13:40:46] # example: pass:1 fail:1 skip:2 total:4
[13:40:46] # Totals: pass:1 fail:1 skip:2 total:4
[13:40:46] ===================== [FAILED] example =====================

This example shows one minor cosmetic defect this approach has.
The test counts lines prevent us from dedenting the suite-level output.
But at the same time, any form of non-KUnit output would do the same
unless it happened to be indented as well.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           |  2 +-
 tools/testing/kunit/kunit_parser.py    | 27 +++++++++++++-------------
 tools/testing/kunit/kunit_tool_test.py |  2 ++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e7b6549712d6..43fbe96318fe 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -202,7 +202,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		if request.raw_output == 'all':
 			pass
 		elif request.raw_output == 'kunit':
-			output = kunit_parser.extract_tap_lines(output, lstrip=False)
+			output = kunit_parser.extract_tap_lines(output)
 		for line in output:
 			print(line.rstrip())
 		parse_time = time.time() - parse_start
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 99b8f058db40..a225799f6b1b 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -13,6 +13,7 @@ from __future__ import annotations
 from dataclasses import dataclass
 import re
 import sys
+import textwrap
 
 from enum import Enum, auto
 from typing import Iterable, Iterator, List, Optional, Tuple
@@ -208,12 +209,12 @@ class LineStream:
 
 # Parsing helper methods:
 
-KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
-TAP_START = re.compile(r'TAP version ([0-9]+)$')
-KTAP_END = re.compile('(List of all partitions:|'
+KTAP_START = re.compile(r'\s*KTAP version ([0-9]+)$')
+TAP_START = re.compile(r'\s*TAP version ([0-9]+)$')
+KTAP_END = re.compile(r'\s*(List of all partitions:|'
 	'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
-def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
+def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 	"""Extracts KTAP lines from the kernel output."""
 	def isolate_ktap_output(kernel_output: Iterable[str]) \
 			-> Iterator[Tuple[int, str]]:
@@ -239,11 +240,8 @@ def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
 				# stop extracting KTAP lines
 				break
 			elif started:
-				# remove the prefix and optionally any leading
-				# whitespace. Our parsing logic relies on this.
+				# remove the prefix, if any.
 				line = line[prefix_len:]
-				if lstrip:
-					line = line.lstrip()
 				yield line_num, line
 	return LineStream(lines=isolate_ktap_output(kernel_output))
 
@@ -298,7 +296,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
+TEST_HEADER = re.compile(r'^\s*# Subtest: (.*)$')
 
 def parse_test_header(lines: LineStream, test: Test) -> bool:
 	"""
@@ -322,7 +320,7 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
+TEST_PLAN = re.compile(r'^\s*1\.\.([0-9]+)')
 
 def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	"""
@@ -350,9 +348,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
 
-TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
 
 def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	"""
@@ -511,8 +509,9 @@ def print_test_header(test: Test) -> None:
 
 def print_log(log: Iterable[str]) -> None:
 	"""Prints all strings in saved log for test in yellow."""
-	for m in log:
-		stdout.print_with_timestamp(stdout.yellow(m))
+	formatted = textwrap.dedent('\n'.join(log))
+	for line in formatted.splitlines():
+		stdout.print_with_timestamp(stdout.yellow(line))
 
 def format_test_result(test: Test) -> str:
 	"""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1ef921ac4331..0c2190514103 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -336,12 +336,14 @@ class KUnitParserTest(unittest.TestCase):
 		KTAP version 1
 		1..1
 		  Test output.
+		    Indented more.
 		not ok 1 test1
 		"""
 		result = kunit_parser.parse_run_tests(output.splitlines())
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 
 		self.print_mock.assert_any_call(StrContains('Test output.'))
+		self.print_mock.assert_any_call(StrContains('  Indented more.'))
 		self.noPrintCallContains('not ok 1 test1')
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:

base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
-- 
2.38.1.584.g0f3c55d4c2-goog

