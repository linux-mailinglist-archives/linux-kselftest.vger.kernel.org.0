Return-Path: <linux-kselftest+bounces-26768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC7A38120
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69243AAFA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2F21A42D;
	Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k0GsZCca";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1V2aLsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710D218EBA;
	Mon, 17 Feb 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790043; cv=none; b=ODxboLlDR8feEk4ZNEUfgKQ4pRC0dGJHYrNvc/Ix6sFzCJJBqw20rmfHkGvl9ZlA8d0oFO8qkIXRKJi0cx8ndnIKf2y4LehZig9uv80mtupAolihrq04N4E3yIq9I9VKBuJbSiozeNeXspHN8D9pFLJ8na5ZYRngDQHVbKIHVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790043; c=relaxed/simple;
	bh=uKV9D/kbwA/0w24XM1UIPsvE/argHIoOFRx9p2whBgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icNGTEGDp3SuEeq9jWnu2S2Fkco6JN+Y0GZikKNHxy8R+8sTz91/FrRj8voCXKJEW51Zj3B1+4/RNwaRBRDzlzPXi/KoTS+94VRWaO3AJXruWuL6B8WxyDrQDlT9W45iZ33zHbn+ik0JMgYh7SduYe/e7clwHUOgeIsg14tp7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k0GsZCca; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1V2aLsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fY3Dlya9onvQQYursAe4ang3UMW+faOqytZ9fehqmJg=;
	b=k0GsZCcaz215C+ourChEgCyjdgIKXMeo8ECynEQH6g8/NnEneTzgiRy7SghbZbJRjnryns
	SoBG2FqBVcbMkLa45cGOiwEEoEsQ/tj0Dgn+j62YRpiso4TUgQroHcmiQteJiUrDfpmU8C
	croYmBLcv/CzE2GowLkfTYim5fHIHs8dzvHEYvU2CwzR0ku3h/TFTckh6myQt4FvjWMoRh
	jGIZa/Hkdom0uAQxrLD3tfU/eiRRSm0Qa2InIiSo/nhreC/cd7A5//EddalmDMc/QPTrQW
	XVWfIdOBlIoSecRr+/5FfiqjVbg4Oab0Ukwcn4MOSPsaFh6aUCdHiyAbmlUzMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fY3Dlya9onvQQYursAe4ang3UMW+faOqytZ9fehqmJg=;
	b=c1V2aLsn3710N2XZq0Bm1ImYDJixu+em9+9qaDUd6Bda1VmD/BdDXrY2kK81QajtZxp/tt
	hdqBoTgAn42Y1UDw==
Date: Mon, 17 Feb 2025 11:59:26 +0100
Subject: [PATCH 06/12] kunit: tool: Add test for nested test result
 reporting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-6-42b4524c3b0a@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=2070;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uKV9D/kbwA/0w24XM1UIPsvE/argHIoOFRx9p2whBgg=;
 b=CqSl6E8Ye9PLDXfeE8wknykLcu+PIhCAS/QBUETQmpdCUzOb02DxXMc27kI6BxAW/GGnPX8FA
 WkhMrs80BBAAGgV147MC0lId4tqHso/iEIvijP3qivtciZ5qG82sDcA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently there is no test validating the result reporting from nested
tests. Add one, it will also be used to validate upcoming changes to the
nested test parsing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_tool_test.py                           | 9 +++++++++
 .../kunit/test_data/test_is_test_passed-failure-nested.log       | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0bcb0cc002f8a7c24b119d59b3e996efc953c626..e71ce88682e137676be49ea9854a5ddaff0dc259 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -165,6 +165,15 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
+	def test_parse_failed_nested_tests_log(self):
+		nested_log = test_data_path('test_is_test_passed-failure-nested.log')
+		with open(nested_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+		self.assertEqual(result.counts.failed, 2)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
+
 	def test_no_header(self):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
new file mode 100644
index 0000000000000000000000000000000000000000..835816e0a07715a514f5f5afab1b6250037feaf4
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
@@ -0,0 +1,7 @@
+KTAP version 1
+1..2
+not ok 1 subtest 1
+    KTAP version 1
+    1..1
+        not ok 1 test 1
+not ok 2 subtest 2

-- 
2.48.1


