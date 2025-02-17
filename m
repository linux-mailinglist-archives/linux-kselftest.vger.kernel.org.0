Return-Path: <linux-kselftest+bounces-26770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622EA38143
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DD71895D57
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2821ADA6;
	Mon, 17 Feb 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgjg6+C6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3EThwlS5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67198218EBD;
	Mon, 17 Feb 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790044; cv=none; b=PryJ/5kv0580kFOBIUr+AvOjg9/RVWFqE6QdgLTzw+FiZNb4iX8A26dO3K+hL4X/etT+lGyE0TOT9XKsnKE1Baq85gez99R5It9SnwxBdZs/B+GE0V1Ow/sybsjvZU2XuysAeO5czG2XI6BYXP8R4ugjXIHuhlsI4cWNrKoWRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790044; c=relaxed/simple;
	bh=QSToQJrmgzvhx32HA99kjUNyTCDnqIfjc/O6b1byB3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNvqV60I5VZN8u/eSVPqvNsa/ic8jZz825wZClZ+QMUlM4dpyjeCPc/VeKJO6v5iTp44YAgVCTfYeICqjfVPrkzIJQ87s+Nm0iz3CcKQkVGEWqx0Nw2Y7b2K/dBbq3zffTqKq1xL9P4ztvFsOGXe5k0rJr0D+c7WzunRRTcW1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgjg6+C6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3EThwlS5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+mxFxM2jcpIj0KVa01PU02wcB6HkTDPMz+vQ79lotg=;
	b=mgjg6+C6CcEYmfehS7JOdY27EvkY3Ygj3nFY672voUoRCn0l1jlF23G+P06Y1EO4gVjNae
	WHI5JWC0gnG1HcWZAxp0xLOi2S0EqxOHFNiLsaG9mEH7SzUFQPuNY4i8SxrYxa3U+N+1ev
	gu2jMTA7ftPiNU/MrWzDMv4jEmxhiC7tJFFjHwoNAXGNPX4Ul9RWdVhuIWiuWjtWkefv17
	x2idUcqKhGtYl4vhZjD+HIaKtbDzz6lBJKgv2WxtlkgdSKi99vg1NYdSBm9Dg+mRY3JurP
	NuQUUKC5lcgaODPIs9DsjFrDo/PeK4zbQkWH6wPXxB53Ehe1CL55ZS/HBQ9R1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+mxFxM2jcpIj0KVa01PU02wcB6HkTDPMz+vQ79lotg=;
	b=3EThwlS5kt8uRbM9qAs4lq9EklT1ExC+BU9a6ycJR3+APB3TVhNlBQv83VtI6IErud6GWK
	V17mJ1TKAY2y/sCA==
Date: Mon, 17 Feb 2025 11:59:27 +0100
Subject: [PATCH 07/12] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-7-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=2733;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QSToQJrmgzvhx32HA99kjUNyTCDnqIfjc/O6b1byB3M=;
 b=x2bbfjpZ1pSrt8YBRroAEOw1vAHGxDyF1NaVgE3cAU3Vq3Jj/+c+NYXvHkD/Mw7P4m2wGRptu
 kvvpqVIwD/IASFctTBP/f7/N2Nhr4Hmv/P0PPwZHbeFB4JlSsy/4k48
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
index 29fc27e8949bd4732448fdd96024624e5350a728..8f597a244b9866528ffb3850e876acb487f3bbd4 100644
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
index e71ce88682e137676be49ea9854a5ddaff0dc259..aab38aa0664655c84d633ab15e4818f818b0ce47 100755
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
2.48.1


