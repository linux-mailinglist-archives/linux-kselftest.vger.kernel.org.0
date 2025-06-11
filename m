Return-Path: <linux-kselftest+bounces-34653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CBAD4D33
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DB23A8464
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFF241136;
	Wed, 11 Jun 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzlZDAnd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LiWGfLR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE2367B3;
	Wed, 11 Jun 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627519; cv=none; b=FV1NJo4MGkN6OGgGm0PAjqggERYvO/R/K58Tdn3erd2BKE06pikDIwKQNKTmR3Sz06Ldf8pgQe9BwSdXezx8coqOZqAvgm5ReNkhC03aA33p7hPwZQdEKIN9wa8nQNTEgRQLSgbCkHuRxATBvCtGHS+RZfmLEtt9AB9f4227fNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627519; c=relaxed/simple;
	bh=FZfj35XystYEPz6f/lxQAJk1DAHaROG5oImBgsaZQ2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6KYxVmw1718KxEvfbT8yEnBVhVuIx4zwted49s1QD0VxTN6hVJkZBVvti6nUCNwjBy8HHWJ4h7wtKyz1BjnAjF42M1V0+q97eSIq7iTISJyA8zir7w0wd14wcZPeXTSfXfSKP8zZMQh/90qe5m2ylT/5rGYagrHt4n+bt6XJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzlZDAnd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LiWGfLR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASaFKtTomPi+O0p6+4d6hkjh0TrYrUSZldDYJPbgnvI=;
	b=zzlZDAndtBm8zhTNt7cGQbdwfhW2KoUwXGuCO25lMgB7zxRoPlqMT3C58WvTfEfHi3XUbS
	NU8I44a7cs7ct83ZIFE7zhJktuDhOYINj8ov5WSstoE5U5GGFMfece2QpMclyrNiP3L199
	IHMNMlhHgsM2CLVM0VxEhNpv77cEjdSD02v9maMhoz+bdlI/nBI6Fe9HRbW/UpKOi2uYol
	kJRAagAGZ5Tt6HS/t79ozirsRUavM36M41gInToTvMn6ihHdlelnI7Roiv+lo3AeJrxuC9
	ymdaKxzbHcbBGFgY/X0WZZXNAbaKLWLLYSbF8l8+gLjPnVHeyOfpQBUIMN0iog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASaFKtTomPi+O0p6+4d6hkjh0TrYrUSZldDYJPbgnvI=;
	b=6LiWGfLR9zUtuqZZovALvZ0fcMP/X0JLFGGbVyv3HogGVzipEIDnXMws5pw8BBpDzWZSXs
	MDzbTF4lNHPTaxDg==
Date: Wed, 11 Jun 2025 09:38:15 +0200
Subject: [PATCH v3 09/16] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-9-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=2733;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FZfj35XystYEPz6f/lxQAJk1DAHaROG5oImBgsaZQ2g=;
 b=rbSRPrWrHfCqEogOmtiX3FUvOIW2ud6MKv1OAWG0SHmG4ZYHwNjEZpRqQ1xF+wwZ8wCGy8L14
 pq+FrfzahUXAvlcC1y0/RcdSnpkkxKb23cZS8Ody+e6CmwWvGO+K4ld
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If a subtest itself reports success, but the outer testcase fails,
the whole testcase should be reported as a failure.
However the status is recalculated based on the test counts,
overwriting the outer test result.
Synthesize a failed test in this case to make sure the failure is not
swallowed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_parser.py                                  | 5 +++++
 tools/testing/kunit/kunit_tool_test.py                               | 2 +-
 tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

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
index 691cde9b030f7729128490c1bdb42ccee1967ad6..c25f52650837e83325b06bddd2aa665fd29f91d9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -170,7 +170,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(nested_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
-		self.assertEqual(result.counts.failed, 2)
+		self.assertEqual(result.counts.failed, 3)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
index 835816e0a07715a514f5f5afab1b6250037feaf4..cd9033c464792e6294905a5676346684182874ad 100644
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
2.49.0


