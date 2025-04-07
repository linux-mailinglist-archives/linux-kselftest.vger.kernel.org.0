Return-Path: <linux-kselftest+bounces-30227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780EA7D68D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78132188A098
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD9229B2C;
	Mon,  7 Apr 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSYBkLrD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZOQ0mlm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50810FD;
	Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011784; cv=none; b=c7MYMUJW+lhVaL9DAnulh03kfj+Y7jbjR5lk483l9nT78w/VOQZVnzNHz4CvJ35IMfxP8h7TZtzWlgeAoBy1FJ2JXveIvWGuXKux2oYylD8i9Q6KPE9Rt4Y9NLxVYOcvPRkSR2g4JBdiezyURodRGI7oyAAfm/OY13fQB6pJbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011784; c=relaxed/simple;
	bh=pF2fDE3eDjUHyRwGflmFqBi7GrGzIztIWG8dRzLuGZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCqJ713dTIWynzIEucBM+Pj4NftwBbaNgZxf+JWi8qbuOJnBOKjVn00UNtXCEC6/zpoxfPRV6ZhfsnjCdlKUTjVspQYm4slOheXQPR3qCDcev5Xzz1ZJ3g2u4vZad+ADcwazFBv5WNmUEAKp3g3wIOPnw+GtNalwnODTgdTu7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSYBkLrD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZOQ0mlm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY6zZZGHsbSSDkMNrLVAeMvYjekKEzJp+iUZSDSo7UU=;
	b=zSYBkLrDhpLu6S1Yu/Lk7b0eLUlw0UYedHqwyrk4IBGBO7Sf+dkvwj91TyKmN4udtvV/K0
	7kCvXWGd1PIYCsL08cFFtX08FV0sUoxEQLgsTV2KiitG5Bk1XVx3vNEul3rjXaZfn8sYc+
	VGOYwDR/Y9xhxYvSUB87xGiT2+nNBMqFkJC6S7ghBvAIkRWh+BhaMaelQ0/WXxsCX7z+b8
	IV0WHs+mgN4mjR7L1N2eAVoOudx2djv9/20WbdZL27Hf3Py9ByD+X+qJvnW/mE+fIYGOer
	HL6gjLkRJNikfmMynk7txY9S6sg876X88OMhx835XByf1MOgQqLV973ZlpoeFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY6zZZGHsbSSDkMNrLVAeMvYjekKEzJp+iUZSDSo7UU=;
	b=WZOQ0mlmDB1FTVBOZK+LUUvT1r9k/uIkPKVAKtAxIoaK/8G41eyGJZpa/U3pnreF4bGvkp
	/wX+0F3FzaHieiDg==
Date: Mon, 07 Apr 2025 09:42:42 +0200
Subject: [PATCH v2 05/11] kunit: tool: Add test for nested test result
 reporting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-5-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
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
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=2070;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pF2fDE3eDjUHyRwGflmFqBi7GrGzIztIWG8dRzLuGZg=;
 b=8mMXqdsPB4G8FLjMfuB3yG4/1+sTGCM4KvV7meAHqGYhGaK38Y2QZzC7F8cmsgGfGNo6qganY
 mE7KAefMyf/BGYFAccL4ETd8apFSp1evlnjKBw5opzltxXQ7lTCfvk1
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
index 5ff4f6ffd8736de3fca17dd9fcceabd7a68f9f98..755dc24350a76306a5b76998646e56fb3e386232 100755
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


