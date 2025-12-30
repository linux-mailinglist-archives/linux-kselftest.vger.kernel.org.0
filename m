Return-Path: <linux-kselftest+bounces-48010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231DCE9A76
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DC2304248B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3199A2EFDAD;
	Tue, 30 Dec 2025 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0ml8lfH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYwy9JQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7152EBDC0;
	Tue, 30 Dec 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097609; cv=none; b=rjyFQREDfnF0UPo5okiL25oIqZcYaVC3PbdqkorDAG8dA2IbKPBqPe4llYMaC60oB8n439rrft+XJ1zJbAR4Kk5zAZe8JgaaUAThSCdZkVGaqsQUMSBZb2ej3UpokLQYLeFzOePvVcOsfP77TkFn4wkD+cUJFgqpQ8r9wsJ2Drw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097609; c=relaxed/simple;
	bh=L2zjGW5l7ZMPlC5yZ8Bim6bC0+WpdGuMq6bHHK7bPcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BD2MXbbvL8VBCCiuCjsGNg8w21y3QShd7zhNxpGzdwQm31GfnOUESCtiyDjc04p5jrHx7z1lo1ytSQeG4rdvi/Q80ot5qsGgYZSH7DSKGZoO3+evY3159Zv2aoW2fPiK4tpwM2H88YmhtG1l2t00tZIafDUXg4WkfINthrBOUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0ml8lfH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYwy9JQw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUER9XFccQJK1WQYTH3/B0/Lr1N/zdpvMEIN1uy6dQE=;
	b=g0ml8lfHcRdFcuujyE9717UZyVg4//9o4533oUlCXKu1PPV3y1ghQala2qmFAy0VpcGoJM
	FwPLQoSdUvX1Uj5sF497jBQlVC8DYuI7/Ggea3/BmI30wUQMMSU4sIq2m2XRthtgvVd/4O
	G+qLtxi7csHCHrMYWHA7dbQqOT9ZGnPjwJV0AV0k8wBfayL8JRwHw2U4fGTyfV08HHvKVF
	7izqHccra8ENUADQOCNBkmFgluK43eBOqm6aeSVaGRCxrrG5sAxBQuTA/rUEJ5nK8j6gvo
	9CmSGFtv/2BHZD4knbm1Hrg3yIn4i8cSaHUK9WPsxVVIEnBsBcziv8rygT5Lig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUER9XFccQJK1WQYTH3/B0/Lr1N/zdpvMEIN1uy6dQE=;
	b=yYwy9JQwdDlsWc3nKssK7Y1tUrPPnwmqdJov4thnwV5Isfqntsy/IJWGbRWgE/v9/7s3BE
	6VKV7CVG2OlrBjAw==
Date: Tue, 30 Dec 2025 13:26:36 +0100
Subject: [PATCH 2/2] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-kunit-nested-failure-v1-2-98cfbeb87823@linutronix.de>
References: <20251230-kunit-nested-failure-v1-0-98cfbeb87823@linutronix.de>
In-Reply-To: <20251230-kunit-nested-failure-v1-0-98cfbeb87823@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767097602; l=2661;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L2zjGW5l7ZMPlC5yZ8Bim6bC0+WpdGuMq6bHHK7bPcU=;
 b=PxVnXMVfjO/budpsu/UuSbKZi2VD6fmlgBp3mLHT7t5ll4uSlBLLSqJw1LkK0tRjWzLB1JQCM
 E6iRuGaqjF4DNxLLmaY+Tt5thbzW6V3ksU2HtJdOsGqdgdXLDiUfR0J
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If a subtest itself reports success, but the outer testcase fails,
the whole testcase should be reported as a failure. However the status
is recalculated based on the test counts, overwriting the outer test
result. Synthesize a failed test in this case to make sure the failure
is not swallowed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py                                  | 3 +++
 tools/testing/kunit/kunit_tool_test.py                               | 1 +
 tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 333cd3a4a56b..5338489dcbe4 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -689,6 +689,9 @@ def bubble_up_test_results(test: Test) -> None:
 	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
 		test.status = TestStatus.TEST_CRASHED
 
+	if status == TestStatus.FAILURE and test.counts.get_status() == TestStatus.SUCCESS:
+		counts.add_status(status)
+
 def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
 	"""
 	Finds next test to parse in LineStream, creates new Test object,
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b74dc05fc2fe..d5bbcb95ab6a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -172,6 +172,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.failed, 2)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.subtests[0].subtests[0].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
index 2e528da39ab5..5498dfd0b0db 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
@@ -1,5 +1,8 @@
 KTAP version 1
 1..2
+    KTAP version 1
+    1..1
+        ok 1 test 1
 not ok 1 subtest 1
     KTAP version 1
     1..1

-- 
2.52.0


