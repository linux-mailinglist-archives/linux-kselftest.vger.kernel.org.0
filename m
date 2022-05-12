Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907175254F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357715AbiELSfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357723AbiELSfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:35:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5561EAE2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r14-20020a25844e000000b00648bdf7491bso5330520ybm.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2enWvaqrdYbCiB3VbP1vtMoCf+yvavsfo9hN39o4ARU=;
        b=osSgR96Irq0ZXTGAx3528oBnX2l8VQha+YDW9a1K8M6JzfuN/5Hw061dtBi9fv3LzU
         CZitgNW0WdsfFySDTvrzC44fPPgdZimFxJuIOTw29puXw16JHtIF9fZN6bc9Y03zH6SU
         mS3dUC5UwuHyVs5neSK46S+MUlFgBPzHnWPiGkyOk/L6P8gNoo+/dDYQqbRnt3NMZQQU
         K0TtfI5mwe3UwmpvJxkrGucNv3Q+z8L4rRr+JZu4CHVODYt/TVQ26cG0T2TZeUgCy02c
         AliND4yzRBKo0I2LbgBxWgnh4l0U37OoKJeBaKNm381r2a9m8htp7Sfk+t4xmieNWrVp
         Ffyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2enWvaqrdYbCiB3VbP1vtMoCf+yvavsfo9hN39o4ARU=;
        b=iQBbgWcnukN9md1m5HUuJNHZ3THO9LDhwnLu/7yfNivDoj5w5QAZQ+qKX/Oi+ZAhMY
         yoj2HC3CftF8pfXc5CRYLRbRzH/15hwQZPIKB0O8TtVz0CZgfdzhya9k2CLz5/zEOP7X
         KA8dEf8hkyvqp26ps3NsYEGc1Iv+ddQ7+lmQ0QOFCWb1WKYmvKSq2FXBm0vol4yysp1x
         aEqJ6l6Y7VmJ2KlfAyRTocFl04UeIHxttBaGe71Wt5jnfmckHnx4eQ4SC3Z67sLtvViG
         iC+TQO20qBIDsQWJ2j24WqaCM9vSf9XMLqGpQOgK5aw9s29qggOUDolGhRa+UWUk/wxs
         yKIQ==
X-Gm-Message-State: AOAM530S1T78cbf4tnbw7eFqBSNUEHe/m6YNQl64ZexO016pHYrI3HOE
        cf0AkZgqWI485lP8sR/qWZd5oamIS7S38w==
X-Google-Smtp-Source: ABdhPJwnyRj2IOHbbkYsRi3JUd6TluH/OeIflbIOyZvh62YNtEDnq+6dZINlUgXLZcd7F/0aimR3R8Yxo298rw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:648d:cdc5:d51:4873])
 (user=dlatypov job=sendgmr) by 2002:a25:48c8:0:b0:648:be07:a758 with SMTP id
 v191-20020a2548c8000000b00648be07a758mr1210783yba.346.1652380551466; Thu, 12
 May 2022 11:35:51 -0700 (PDT)
Date:   Thu, 12 May 2022 11:35:38 -0700
In-Reply-To: <20220512183538.3787321-1-dlatypov@google.com>
Message-Id: <20220512183538.3787321-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220512183538.3787321-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 3/3] kunit: tool: minor cosmetic cleanups in kunit_parser.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There should be no behavioral changes from this patch.

This patch removes redundant comment text, inlines a function used in
only one place, and other such minor tweaks.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase onto -kselftest/kunit branch, minor merge conflict
(a nearby comment got reworded)
---
 tools/testing/kunit/kunit_parser.py | 71 +++++++----------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 9f5a73f36c2d..98264177b0bd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -46,10 +46,8 @@ class Test(object):
 
 	def __str__(self) -> str:
 		"""Returns string representation of a Test class object."""
-		return ('Test(' + str(self.status) + ', ' + self.name +
-			', ' + str(self.expected_count) + ', ' +
-			str(self.subtests) + ', ' + str(self.log) + ', ' +
-			str(self.counts) + ')')
+		return (f'Test({self.status}, {self.name}, {self.expected_count}, '
+			f'{self.subtests}, {self.log}, {self.counts})')
 
 	def __repr__(self) -> str:
 		"""Returns string representation of a Test class object."""
@@ -58,7 +56,7 @@ class Test(object):
 	def add_error(self, error_message: str) -> None:
 		"""Records an error that occurred while parsing this test."""
 		self.counts.errors += 1
-		print_error('Test ' + self.name + ': ' + error_message)
+		print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
 class TestStatus(Enum):
 	"""An enumeration class to represent the status of a test."""
@@ -92,8 +90,7 @@ class TestCounts:
 		self.errors = 0
 
 	def __str__(self) -> str:
-		"""Returns the string representation of a TestCounts object.
-		"""
+		"""Returns the string representation of a TestCounts object."""
 		statuses = [('passed', self.passed), ('failed', self.failed),
 			('crashed', self.crashed), ('skipped', self.skipped),
 			('errors', self.errors)]
@@ -130,30 +127,19 @@ class TestCounts:
 		if self.total() == 0:
 			return TestStatus.NO_TESTS
 		elif self.crashed:
-			# If one of the subtests crash, the expected status
-			# of the Test is crashed.
+			# Crashes should take priority.
 			return TestStatus.TEST_CRASHED
 		elif self.failed:
-			# Otherwise if one of the subtests fail, the
-			# expected status of the Test is failed.
 			return TestStatus.FAILURE
 		elif self.passed:
-			# Otherwise if one of the subtests pass, the
-			# expected status of the Test is passed.
+			# No failures or crashes, looks good!
 			return TestStatus.SUCCESS
 		else:
-			# Finally, if none of the subtests have failed,
-			# crashed, or passed, the expected status of the
-			# Test is skipped.
+			# We have only skipped tests.
 			return TestStatus.SKIPPED
 
 	def add_status(self, status: TestStatus) -> None:
-		"""
-		Increments count of inputted status.
-
-		Parameters:
-		status - status to be added to the TestCounts object
-		"""
+		"""Increments the count for `status`."""
 		if status == TestStatus.SUCCESS:
 			self.passed += 1
 		elif status == TestStatus.FAILURE:
@@ -283,11 +269,9 @@ def check_version(version_num: int, accepted_versions: List[int],
 	test - Test object for current test being parsed
 	"""
 	if version_num < min(accepted_versions):
-		test.add_error(version_type +
-			' version lower than expected!')
+		test.add_error(f'{version_type} version lower than expected!')
 	elif version_num > max(accepted_versions):
-		test.add_error(
-			version_type + ' version higher than expected!')
+		test.add_error(f'{version_type} version higer than expected!')
 
 def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	"""
@@ -440,8 +424,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	# Check test num
 	num = int(match.group(2))
 	if num != expected_num:
-		test.add_error('Expected test number ' +
-			str(expected_num) + ' but found ' + str(num))
+		test.add_error(f'Expected test number {expected_num} but found {num}')
 
 	# Set status of test object
 	status = match.group(1)
@@ -529,7 +512,7 @@ def format_test_divider(message: str, len_message: int) -> str:
 		# calculate number of dashes for each side of the divider
 		len_1 = int(difference / 2)
 		len_2 = difference - len_1
-	return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
+	return ('=' * len_1) + f' {message} ' + ('=' * len_2)
 
 def print_test_header(test: Test) -> None:
 	"""
@@ -545,20 +528,13 @@ def print_test_header(test: Test) -> None:
 	message = test.name
 	if test.expected_count:
 		if test.expected_count == 1:
-			message += (' (' + str(test.expected_count) +
-				' subtest)')
+			message += ' (1 subtest)'
 		else:
-			message += (' (' + str(test.expected_count) +
-				' subtests)')
+			message += f' ({test.expected_count} subtests)'
 	print_with_timestamp(format_test_divider(message, len(message)))
 
 def print_log(log: Iterable[str]) -> None:
-	"""
-	Prints all strings in saved log for test in yellow.
-
-	Parameters:
-	log - Iterable object with all strings saved in log for test
-	"""
+	"""Prints all strings in saved log for test in yellow."""
 	for m in log:
 		print_with_timestamp(yellow(m))
 
@@ -635,20 +611,7 @@ def print_summary_line(test: Test) -> None:
 		color = yellow
 	else:
 		color = red
-	counts = test.counts
-	print_with_timestamp(color('Testing complete. ' + str(counts)))
-
-def print_error(error_message: str) -> None:
-	"""
-	Prints error message with error format.
-
-	Example:
-	"[ERROR] Test example: missing test plan!"
-
-	Parameters:
-	error_message - message describing error
-	"""
-	print_with_timestamp(red('[ERROR] ') + error_message)
+	print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
 # Other methods:
 
@@ -794,7 +757,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
-	results and print condensed test results and summary line .
+	results and print condensed test results and summary line.
 
 	Parameters:
 	kernel_output - Iterable object contains lines of kernel output
-- 
2.36.0.550.gb090851708-goog

