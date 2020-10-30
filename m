Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C62A10F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 23:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgJ3WjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ3WjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 18:39:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B664C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 15:39:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id m11so4707833qvt.11
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rsquC6V2aWWJbPPQRsoIKbC4L7TvYUAe7PufDzFe/I0=;
        b=Y9L8bmXrBwKfHVaIUGLy2AFEtprKExDiuwMa/z77ZIDPZ+UhH4RkNi5sgoS/RZUf4J
         7wR+VwWblnxThaJgvO1Pd10ptu0tmLAIhApbMOeH/9K1FakPDvbILdEx8QEdUyc37Njx
         hgtzJyk2G5u1a2wmuY665GovfQLJxqr49AACIDsLrKSDTXC/SVlzKMIpT70xgrr+OjNY
         RWVVEDm8ZEca04Y3JiRI4QdzOKMqyQYBfQcqHHNSXG0MwPjJRuAq2DaE31nsMTfPZks7
         rTbvWzVvtsY8zMYhWOxiXsod7r7RlKnDvH5dKKL/hhW69O6DtJKE5RUOKTdFUtbcpUC8
         tKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rsquC6V2aWWJbPPQRsoIKbC4L7TvYUAe7PufDzFe/I0=;
        b=LEPd4lhjZYuEppyfl462tKJMdo3t3Sp4s7/VAu05xgv4E3vkQbCWMx9uUYLPiKixCq
         rOAFO7bBuXNvMw/Kn/pb/FeNp24R+95ZCvwgFMmGgFdVigGPQHyGkM6ngiqAqi/bdTMY
         98tm6irTRyHJm92SZ4ZPNSgObWEqEcNGKM9Vk5PihZ9VBCipsBxQQTqcdsAxJQsSzX9Z
         Lx+rcmfL3UvOJVrtsExB/MDhnhM9snuwpMaj6d12TwYiN7ouh8j5mN3CC3eozzBsxQAJ
         rKeAydELMb1cMpfaKS6QaRU2wqgPaWB7m2/nYBjwbwRtW1ueBXCBQ3qSFNz02N8Bjv+8
         vZbQ==
X-Gm-Message-State: AOAM530Rb/cSgVkk52DyWGHPtxoxGQQLHFIRVzU51MUInCKyHyGiB1W2
        gbDdDERQyRMdT+mRwbK/n0kr7R45rOT2kg==
X-Google-Smtp-Source: ABdhPJx/AtcKQbo/+CPtxla/lfu0s6wDA0FRbmhX7JlluhVtoziQ4wAeYVZVSACtAE42kTOZooKC9xB0PX9dIQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:9a7:: with SMTP id
 du7mr11120338qvb.21.1604097544579; Fri, 30 Oct 2020 15:39:04 -0700 (PDT)
Date:   Fri, 30 Oct 2020 15:38:53 -0700
Message-Id: <20201030223853.554597-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] kunit: tool: fix extra trailing \n in raw + parsed test output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For simplcity, strip all trailing whitespace from parsed output.
I imagine no one is printing out meaningful trailing whitespace via
KUNIT_FAIL() or similar, and that if they are, they really shouldn't.

`isolate_kunit_output()` yielded liens with trailing \n, which results
in artifacty output like this:

$ ./tools/testing/kunit/kunit.py run
[16:16:46] [FAILED] example_simple_test
[16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29

[16:16:46]     Expected 1 + 1 == 3, but

[16:16:46]         1 + 1 == 2

[16:16:46]         3 == 3

[16:16:46]     not ok 1 - example_simple_test

[16:16:46]

After this change:
[16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[16:16:46]     Expected 1 + 1 == 3, but
[16:16:46]         1 + 1 == 2
[16:16:46]         3 == 3
[16:16:46]     not ok 1 - example_simple_test
[16:16:46]

We should *not* be expecting lines to end with \n in kunit_tool_test.py
for this reason.

Do the same for `raw_output()` as well which suffers from the same
issue.

This is a followup to [1], but rebased onto kunit-fixes to pick up the
other raw_output() fix and fixes for kunit_tool_test.py.

[1] https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 3 ++-
 tools/testing/kunit/kunit_tool_test.py | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 84a1af2581f5..edd6fbd1cf18 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -54,6 +54,7 @@ kunit_end_re = re.compile('(List of all partitions:|'
 def isolate_kunit_output(kernel_output):
 	started = False
 	for line in kernel_output:
+		line = line.rstrip()  # line always has a trailing \n
 		if kunit_start_re.search(line):
 			prefix_len = len(line.split('TAP version')[0])
 			started = True
@@ -65,7 +66,7 @@ def isolate_kunit_output(kernel_output):
 
 def raw_output(kernel_output):
 	for line in kernel_output:
-		print(line)
+		print(line.rstrip())
 
 DIVIDER = '=' * 60
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0b60855fb819..497ab51bc170 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -102,7 +102,7 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_output_isolated_correctly.log')
 		file = open(log_path)
 		result = kunit_parser.isolate_kunit_output(file.readlines())
-		self.assertContains('TAP version 14\n', result)
+		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
 		self.assertContains('	ok 1 - example_simple_test', result)
@@ -115,7 +115,7 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_pound_sign.log')
 		with open(log_path) as file:
 			result = kunit_parser.isolate_kunit_output(file.readlines())
-		self.assertContains('TAP version 14\n', result)
+		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: kunit-resource-test', result)
 		self.assertContains('	1..5', result)
 		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)

base-commit: cab67acc8a18d7c6f1850313e3da1a030abe8fc4
-- 
2.29.1.341.ge80a0c044ae-goog

