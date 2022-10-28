Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4F611C12
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ1VDO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ1VDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 17:03:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BCA244C7F
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 14:03:08 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h19-20020a63e153000000b00434dfee8dbaso3049635pgk.18
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SXh0okIwiV6Ma7sPYTqdOlim1w0WkxuN7ZrR2Or+Zk=;
        b=sMoW1VjscveV6hpN+gf0TGyCtjqBhB6rkQLUDWkT6TJIQDVnicRXENiLc1lewMZJar
         4GsUxtoNkn2H4lBoXwTCmtzEU04exdCF8/06lItVqpwlz752bPH55HheTJ21XOwXImpS
         T/xe6vXJy2QfEWHvCUP9lI/0D43YEST8/0U81nBabiErdYqKTiO3x74U6LMXJtwl2GU+
         sc59v2GoeaSjNA7PALOGSYFz4XB61mbu+DiQBTHtZsynxQwaJDBxR8KwZyve3O7O8D59
         jtNP11toD85lQCkSgLSMoOxP3W0zczBS+ERHlFHxyFywpwoZoWxFEH8lSfDE6wUA6wc6
         94SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SXh0okIwiV6Ma7sPYTqdOlim1w0WkxuN7ZrR2Or+Zk=;
        b=C4R7npH6xNBp6VVKphQ7sy+jp+EA5gUtzzoEmRr08vlopW1pZIURqUEJhcoZux95G5
         kJh7jQvbnshyDV7h08caPkRhofYM0VSa4R931Vz2pZpRkgDUPEbYXqxB5SooIFqSIndX
         KGCWLRyDQI+RxqGtpPuxemt0/WcuUO+AYiO/TfXRu9J6cdpRjsKoHMwptW8dSgoPToq7
         +i7Uz/fKFuUk5RD8fqlHqI0465US2ejT42XLHMg+eIziBeQYu0qAlYJifH1ou02+36WU
         VviUtYCOxGPh/EnYVajtsxXdezZ8nQozFz30YCjoxg016oIFPpyXjxWpPal+CAd7jGc1
         MTHQ==
X-Gm-Message-State: ACrzQf0MhQuPzylzG6tD7/aU5Wc1mE3ZrwmMIJS3B9icW7QEGzCzI1VA
        gR4yu4XAspNIKplS4467knVzHkGNil/LQA==
X-Google-Smtp-Source: AMsMyM6pGpoVf42I7ciQCw32xAMqGwCqEIZBD5UfOHjgapypAgH5fEd/25f4EPr3AsZmDR/4VwBnE1mn1FcQ/Q==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:1707:b0:566:15a1:8b07 with SMTP
 id h7-20020a056a00170700b0056615a18b07mr1023804pfc.34.1666990987970; Fri, 28
 Oct 2022 14:03:07 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:02:56 -0700
In-Reply-To: <20221028210256.3776835-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221028210256.3776835-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221028210256.3776835-2-dlatypov@google.com>
Subject: [PATCH 2/2] kunit: tool: print summary of failed tests if a few
 failed out of a lot
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

E.g. all the hw_breakpoint tests are failing right now.
So if I run `kunit.py run --altests --arch=x86_64`, then I see
> Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7

Seeing which 9 tests failed out of the hundreds is annoying.
If my terminal doesn't have scrollback support, I have to resort to
looking at `.kunit/test.log` for the `not ok` lines.

Teach kunit.py to print a summarized list of failures if the # of tests
reachs an arbitrary threshold (>=100 tests).

To try and keep the output from being too long/noisy, this new logic
a) just reports "parent_test failed" if every child test failed
b) won't print anything if there are >10 failures (also arbitrary).

With this patch, we get an extra line of output showing:
> Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7
> Failures: hw_breakpoint

This also works with parameterized tests, e.g. if I add a fake failure
> Failures: kcsan.test_atomic_builtins_missing_barrier.threads=6

Note: we didn't have enough tests for this to be a problem before.
But with commit 980ac3ad0512 ("kunit: tool: rename all_test_uml.config,
use it for --alltests"), --alltests works and thus running >100 tests
will probably become more common.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 47 ++++++++++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py | 22 ++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 1ae873e3e341..94dba66feec5 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -58,6 +58,10 @@ class Test:
 		self.counts.errors += 1
 		stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
+	def ok_status(self) -> bool:
+		"""Returns true if the status was ok, i.e. passed or skipped."""
+		return self.status in (TestStatus.SUCCESS, TestStatus.SKIPPED)
+
 class TestStatus(Enum):
 	"""An enumeration class to represent the status of a test."""
 	SUCCESS = auto()
@@ -565,6 +569,40 @@ def print_test_footer(test: Test) -> None:
 	stdout.print_with_timestamp(format_test_divider(message,
 		len(message) - stdout.color_len()))
 
+
+
+def _summarize_failed_tests(test: Test) -> str:
+	"""Tries to summarize all the failing subtests in `test`."""
+
+	def failed_names(test: Test, parent_name: str) -> List[str]:
+		# Note: we use 'main' internally for the top-level test.
+		if not parent_name or parent_name == 'main':
+			full_name = test.name
+		else:
+			full_name = parent_name + '.' + test.name
+
+		if not test.subtests:  # this is a leaf node
+			return [full_name]
+
+		# If all the children failed, just say this subtest failed.
+		# Don't summarize it down "the top-level test failed", though.
+		failed_subtests = [sub for sub in test.subtests if not sub.ok_status()]
+		if parent_name and len(failed_subtests) ==  len(test.subtests):
+			return [full_name]
+
+		all_failures = []  # type: List[str]
+		for t in failed_subtests:
+			all_failures.extend(failed_names(t, full_name))
+		return all_failures
+
+	failures = failed_names(test, '')
+	# If there are too many failures, printing them out will just be noisy.
+	if len(failures) > 10:  # this is an arbitrary limit
+		return ''
+
+	return 'Failures: ' + ', '.join(failures)
+
+
 def print_summary_line(test: Test) -> None:
 	"""
 	Prints summary line of test object. Color of line is dependent on
@@ -587,6 +625,15 @@ def print_summary_line(test: Test) -> None:
 		color = stdout.red
 	stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
+	# Summarize failures that might have gone off-screen since we had a lot
+	# of tests (arbitrarily defined as >=100 for now).
+	if test.ok_status() or test.counts.total() < 100:
+		return
+	summarized = _summarize_failed_tests(test)
+	if not summarized:
+		return
+	stdout.print_with_timestamp(color(summarized))
+
 # Other methods:
 
 def bubble_up_test_results(test: Test) -> None:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index a6e53945656e..7dcd67003b23 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -312,6 +312,28 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
+	def test_summarize_failures(self):
+		output = """
+		KTAP version 1
+		1..2
+			# Subtest: all_failed_suite
+			1..2
+			not ok 1 - test1
+			not ok 2 - test2
+		not ok 1 - all_failed_suite
+			# Subtest: some_failed_suite
+			1..2
+			ok 1 - test1
+			not ok 2 - test2
+		not ok 1 - some_failed_suite
+		"""
+		result = kunit_parser.parse_run_tests(output.splitlines())
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+
+		self.assertEqual(kunit_parser._summarize_failed_tests(result),
+			'Failures: all_failed_suite, some_failed_suite.test2')
+
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 
-- 
2.38.1.273.g43a17bfeac-goog

