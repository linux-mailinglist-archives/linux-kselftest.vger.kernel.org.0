Return-Path: <linux-kselftest+bounces-34650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42171AD4D24
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E252417B5D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E923AB98;
	Wed, 11 Jun 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvYyg6Qv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNdYa4BG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899642367A1;
	Wed, 11 Jun 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627518; cv=none; b=egLPCmfev76YtHWXVymkaLDN33kE1wDlaawmJdFL49BLO3oSY0MfnO8G4vbCO/LYYx1WIJo3L/lpSRJcTxscPpnBwr+s93Kkfoesyt+Nf+pdJ+F+h+z4tM18I5XSg57yfCytrGd8iWvp3COrEYWbCL3pcMdFPWMLWQptfEEXf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627518; c=relaxed/simple;
	bh=lI/60pEr6pY3/pLg+6Hxz2diPV2LL+wQWsSjlOiVzgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJeVSPUZ8vbeQ/yJTv3rhXLkVOgxpgO4DCEFbMr0kqKmxA0v1/ccUrRyjarVIg14X3xM0jiZRd/XmIZMzWOrpLmPmD0POx0aXROH6iLhaUH3OODgIQwfVdpdaTurabz25TQdi92wEimg9eRxQEsEV/tPGvy/bT50HA8UsiRKsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvYyg6Qv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNdYa4BG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYgtidffxNZR2vi7Ilvk4ikd2wExNwWXZn779oXpOZw=;
	b=DvYyg6QvrAo5e+rlyt/4KLUOfbkR1iPns2d35AFrnM0IieJ3DplwfsMtI6Xne+BZslL3BN
	/Gb1bwfvg97Vn1v3WOxkwnSmldUde2QM5k6twv3hg6l4GwndFFSuA29I+Sj+fXHkT5vI3z
	VzYXudrr3iM+krKkavjQ/2clQ9ddURFv9+xNs9U76m0bQuURPESAqroseTaKg3XPvkpMn3
	9dy0zuRxUGOEHsU/RcQBCZzrXpPqBGl/lYVdhCtKnqMHnYfkODKzMcNaH00B+rKmFL6di8
	ae47FP0aw0RuczB1ZAMsOg1w0gcRTNqUmPeEAbpZabS7nRy+LZWAizlM8+LiGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYgtidffxNZR2vi7Ilvk4ikd2wExNwWXZn779oXpOZw=;
	b=iNdYa4BGqT8T0LBKV8V4HUwFq81N8ZO5b2HUwUfdOfNoS62BHJdUQRxRci9ajmsS4kAcHd
	9Mwt3V27vHBKwCBQ==
Date: Wed, 11 Jun 2025 09:38:14 +0200
Subject: [PATCH v3 08/16] kunit: tool: Add test for nested test result
 reporting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-8-55e3d148cbc6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=2070;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lI/60pEr6pY3/pLg+6Hxz2diPV2LL+wQWsSjlOiVzgY=;
 b=sHO8F73U/BrcQR+S5CdVr2kAfBk6sOvpmwGLe0GkHA6MtLjeLt3qQ2pEdENOYL4cGlV2NaBsp
 I53K+L8LC7pDqkqfZsB1bte48hcxCzXlCnvHHw8owd8DlTq+B8X/8Wx
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
index bbba921e0eacb18663abfcabb2bccf330d8666f5..691cde9b030f7729128490c1bdb42ccee1967ad6 100755
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
2.49.0


