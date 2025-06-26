Return-Path: <linux-kselftest+bounces-35823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09798AE95D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EEE4A65FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFF25C6FA;
	Thu, 26 Jun 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJX2G6n7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ym+Y9yT1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2A22F76B;
	Thu, 26 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918225; cv=none; b=IFHu2byrznNrXLY7zRa5SdoZppbtF4nN7cQmtX5X5s+W+vg2WwgYbnLqZQyakdjK9ITV3IvJF4h0mzpMQWpknffvFM7Y2TizmbDQAarHCu0fK2blcNI2zi0HUmzc+aHEbEE9v0fKLO4vgDHq0NdXIMCzmyt3ARkWAGdyoOP8n1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918225; c=relaxed/simple;
	bh=3t3Pl5fkB5thDAh5xZvG+YfScEInDEQ30x9tWWJX29Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfT1EbPpkK6UpRtRwfkyAbmnZOvnw4V9wthFD/npMpDr4ega7xEx+NnCcJltWwcp5KHZO5Am2SHDQhP1VXRSy1X3Kk/NA++Th4LPLnnQzJF4TVbtn9S0YlAJdTSidqTLdSgbXlNRx+rxYpbqKWUNf7cxB5WGjLGjjJdcsAFMrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJX2G6n7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ym+Y9yT1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cuf7YUDid13D8VbaJI7N9jiwmxX9iHNgguMQzOAlx2M=;
	b=eJX2G6n7eeC9OKtPRc45ieNwZQh8Wx5t8lovecgsPYl+3WbTUZytrKWz9jqvPaok5k76C5
	lN7kEx7N34smHTZlHZvMYpUztLGzYMfQfFq0ODAPMPNdHsy1vv0yi1SqVi7mUasi/phwIA
	h6bdBQ4630o7dYNqnuynA+FecAOgSyqqth9vBssCfabyG6Oop9TPRtGOl0pT0Zfne2PHpv
	1FTPdAqAz1QpFnZ0WvFe8CsVQ+t40c6bdPxOCXhXuxgmbSe6BU26hvCwUcTdqlLaWdnBJ1
	OoDJ08s/n70tpc8uTqFt+QWPT36PqrTNuYvEiafflbq7j6Lm372jWPnj2PJ6jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cuf7YUDid13D8VbaJI7N9jiwmxX9iHNgguMQzOAlx2M=;
	b=Ym+Y9yT1zOvX6xWbDDFNN2oMyk88S+BX7PTskdm/mus9tlK/52fJsn5wGqp8NsL3V7nHM3
	cjPkmxt/vd/4QTBA==
Date: Thu, 26 Jun 2025 08:10:16 +0200
Subject: [PATCH v4 08/15] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-8-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=2967;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3t3Pl5fkB5thDAh5xZvG+YfScEInDEQ30x9tWWJX29Y=;
 b=AvEfUSGHiilGFdZnCu5LHNrjgKchinPsKqlFGPeYLusicAg95dIGWTD6OtUekwAXApKiJs3hW
 4iY7/aNOxQMAEVJ4u1Z+05ssCDC4urXBb234SUelMppjBe8W4aqGF9Y
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If a subtest itself reports success, but the outer testcase fails,
the whole testcase should be reported as a failure.
However the status is recalculated based on the test counts,
overwriting the outer test result.
Synthesize a failed test in this case to make sure the failure is not
swallowed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py                                  | 5 +++++
 tools/testing/kunit/kunit_tool_test.py                               | 3 ++-
 tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c176487356e6c94882046b19ea696d750905b8d5..2478beb28fc3db825855ad46200340e884da7df1 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -686,6 +686,11 @@ def bubble_up_test_results(test: Test) -> None:
 		counts.add_status(status)
 	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
 		test.status = TestStatus.TEST_CRASHED
+	if not test.ok_status():
+		for t in subtests:
+			if not t.ok_status():
+				counts.add_status(t.status)
+				break
 
 def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
 	"""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3..48a0dd0f9c87caf9f018aade161db90a613fc407 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -170,8 +170,9 @@ class KUnitParserTest(unittest.TestCase):
 		with open(nested_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
-		self.assertEqual(result.counts.failed, 2)
+		self.assertEqual(result.counts.failed, 3)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.subtests[0].subtests[0].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
index 2e528da39ab5b2be0fca6cf9160c10929fba3c9e..5498dfd0b0db24663e1a1e9bf78c587de6746522 100644
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
2.50.0


