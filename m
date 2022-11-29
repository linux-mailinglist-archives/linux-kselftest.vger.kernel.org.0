Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC563B66B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 01:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiK2ANE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 19:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiK2AMm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 19:12:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554E658D
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:12:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w2-20020a17090a8a0200b002119ea856edso13074558pjn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X881tlPDVXUlMgACZfZTZeyY92tnJLZ+/B1dNTIs8Gc=;
        b=Oi0ZjD5sM55sEXkn34mnC5VjQu6xKzBRPB+GDVOF2EnL4UyIrAVAj+ELyBOEjwwDGW
         s52xHTMYBS43CadhoSIW0qCfFLr9/dNXGbYqxREAcpO5ADcuQcbGGoVLhGcyFqOifAYz
         ojnWNbwTYlIyOmygoDbJnXy2VtgXqs/+yjKkqA2rMMM90MtJyW8+/OEsUGu7j28fquOe
         yOvSTpwtVyfqFbCa/Z053nvtEqBPgJ3feWv7yramCZQ80+/cUgNFfd/Hu0S7PmVXRryp
         Q/eyB0R27WV76y4VZNh25H39JHBqzfwP/Gr7dqgkyyzpXjcPx4HmPcDa9Lj/VZGtOJAy
         T8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X881tlPDVXUlMgACZfZTZeyY92tnJLZ+/B1dNTIs8Gc=;
        b=omXAedR5EDEipD+8X3e8V9Iar5/gVVEFkCsas1LKAL/8IcFsY2hZo7fx/YfMBJbRlH
         Nk8aoVxJt6NBxSAVXv8JkaVAZLYkf78pFBUTdAHuJDeBdfL2t2p+URci3aqR+RcZvSCa
         Ytq/kZQZnYflzJZwjTzbhgoolm8MizTmboxW5D9bT6wS2I3NwgZjyUZHHxzbrm6IxcYs
         XV8ogasU9wLPS5OgXhhL1qwJsYEFf0eIcefEd9+I2daQVAfXuZSQ+B6awC1WGOMeag62
         jxm+AHPWhGxvPKKEzLL9r9az+dTE2jYktDqygrGCagcNdW2EHVqSSW8JkWqGrqIsjdse
         ahRA==
X-Gm-Message-State: ANoB5pmlA9DZKFjpuCLjrb9sMrnr0qxCncyIn+TCPRmD3Z40AIgqjzXR
        j/8d+A63EE7Fy4vHZ13qViXivK1NuRVt9w==
X-Google-Smtp-Source: AA0mqf7PIX8W1qzdvgiGt+aiUTDXV/YuuvuJ0Eo/G0bko1Yy573w+vZmfwFWp89lUQwQZ4vFaPcQTbgi/vUM/w==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:408b:b0:56b:ca57:ba8c with SMTP
 id bw11-20020a056a00408b00b0056bca57ba8cmr35465110pfb.43.1669680759811; Mon,
 28 Nov 2022 16:12:39 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:12:34 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129001234.606653-1-dlatypov@google.com>
Subject: [PATCH] kunit: tool: don't include KTAP headers and the like in the
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

We print the "test log" on failure.
This is meant to be all the kernel output that happened during the test.

But we also include the special KTAP lines in it, which are often
redundant.

E.g. we include the "not ok" line in the log, right before we print
that the test case failed...
[13:51:48] Expected 2 + 1 == 2, but
[13:51:48] 2 + 1 == 3 (0x3)
[13:51:48] not ok 1 example_simple_test
[13:51:48] [FAILED] example_simple_test

More full example after this patch:
[13:51:48] =================== example (4 subtests) ===================
[13:51:48] # example_simple_test: initializing
[13:51:48] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[13:51:48] Expected 2 + 1 == 2, but
[13:51:48] 2 + 1 == 3 (0x3)
[13:51:48] [FAILED] example_simple_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    |  8 ++++----
 tools/testing/kunit/kunit_tool_test.py | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4cc2f8b7ecd0..99b8f058db40 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -295,7 +295,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 		check_version(version_num, TAP_VERSIONS, 'TAP', test)
 	else:
 		return False
-	test.log.append(lines.pop())
+	lines.pop()
 	return True
 
 TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
@@ -318,8 +318,8 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
 	match = TEST_HEADER.match(lines.peek())
 	if not match:
 		return False
-	test.log.append(lines.pop())
 	test.name = match.group(1)
+	lines.pop()
 	return True
 
 TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
@@ -345,9 +345,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	if not match:
 		test.expected_count = None
 		return False
-	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
 	test.expected_count = expected_count
+	lines.pop()
 	return True
 
 TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
@@ -409,7 +409,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	# Check if line matches test result line format
 	if not match:
 		return False
-	test.log.append(lines.pop())
+	lines.pop()
 
 	# Set name of test object
 	if skip_match:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index d7f669cbf2a8..1ef921ac4331 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -84,6 +84,10 @@ class KUnitParserTest(unittest.TestCase):
 		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
 		self.addCleanup(mock.patch.stopall)
 
+	def noPrintCallContains(self, substr: str):
+		for call in self.print_mock.mock_calls:
+			self.assertNotIn(substr, call.args[0])
+
 	def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
 		# Clone the iterator so we can print the contents on failure.
 		copy, backup = itertools.tee(haystack)
@@ -327,6 +331,19 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
+	def test_show_test_output_on_failure(self):
+		output = """
+		KTAP version 1
+		1..1
+		  Test output.
+		not ok 1 test1
+		"""
+		result = kunit_parser.parse_run_tests(output.splitlines())
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+
+		self.print_mock.assert_any_call(StrContains('Test output.'))
+		self.noPrintCallContains('not ok 1 test1')
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 

base-commit: 11300092f6f4dc4103ac4bd950d62f94effc736a
-- 
2.38.1.584.g0f3c55d4c2-goog

