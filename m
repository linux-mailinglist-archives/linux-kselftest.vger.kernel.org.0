Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25AA51057E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbiDZRhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349116AbiDZRhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 13:37:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F6939B3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 10:33:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e642be1a51so159637507b3.21
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=or5Qq2p7tQiEUi1yK0d0OBa9R3d0Zk6QJTQ8FgXJE+o=;
        b=ZkCcDwTB2+WctizJTQngKWojlMstlRfAqBs/079sDbtyHpseXXnpVsAD6yBLnCHPfy
         P7OhCQkVW8Eu3aMBKfWLi84413eq2P7Ue5EUwbHZ3WzNfo0jg1wPvODme2yAjManRV38
         7/KnD9g/WsklSuj/G6yfpmqzabo12NyMF7u+aCx3HhVp9i6q0E+75A0H4PNNCYzFFFbI
         8w+2GiBKm5ZtDmUYpehkNekuROPBpMMyVfJdshXK1nTvwiGZPrYYAXmNWTqeSfuRTd//
         2Pe5FdXFc7iD8Glnm5263Rd5ZNKLHDyvtunVom6AakO5jf0I4Xa76D+AK7qJNFXOIoKM
         XQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=or5Qq2p7tQiEUi1yK0d0OBa9R3d0Zk6QJTQ8FgXJE+o=;
        b=qmKDGSFfw3uOndAo5+bafn56WD59PpJB+Mc3CBIZmhgvtEwZa588OUbdnUsxGv+hHW
         fbSCANqawj0j9gswwZfGPnzL54RtLt3U/mW0+tZ20lrCzUw9uu4FrI3F59ghAUCLAYAB
         24T+8q1URW2v4mgjzpIK3kSLY/aT6yKi7xId9odJiQQLfCOEz20mzHeAFfLXRynWNV18
         X6Em75wAbsaHFr4KqOcmc3SZed/96pq7+0/kCG5tCm7JVfdquUF0m4AHnvaJXoivnbRM
         H9TkW9FCUAx9S3sl+ZBtthqtPEL7r99W9GZtSKc2fhLO0qBrH98D2UogAnOJjtZ6Fa0Y
         jldA==
X-Gm-Message-State: AOAM530KkwXthYFcMA7RZpzqvUQthAMlzOCveY+Ztx4A/9T2Bak3iYbV
        0oWOMsX+7R0GdptxPhO18CIMeBG7XNgFGw==
X-Google-Smtp-Source: ABdhPJxEvaR87Y9Lzq895uL6N9ZtjnhtFg7c1C1H7vi5TuU1KLfdafjIeFdqEW8+OmAs/2Z5prQQC06LIwAjFQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b03d:8d64:4a06:2c5f])
 (user=dlatypov job=sendgmr) by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr13859274ybf.137.1650994433438; Tue, 26
 Apr 2022 10:33:53 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:33:34 -0700
In-Reply-To: <20220426173334.3871399-1-dlatypov@google.com>
Message-Id: <20220426173334.3871399-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 3/3] kunit: tool: minor cosmetic cleanups in kunit_parser.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There should be no behavioral changes from this patch.

This patch removes redundant comment text, inlines a function used in
only one place, and other such minor tweaks.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 71 +++++++----------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 45c2c5837281..d56d530fab24 100644
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
 		return ('Passed: ' + str(self.passed) +
 			', Failed: ' + str(self.failed) +
 			', Crashed: ' + str(self.crashed) +
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
2.36.0.rc2.479.g8af0fa9b8e-goog

