Return-Path: <linux-kselftest+bounces-35822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09619AE95D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88324A65FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4E25B2ED;
	Thu, 26 Jun 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC/+91rk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6vH5Aol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DB23ABAD;
	Thu, 26 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918225; cv=none; b=aUaVtj1jJlLloSb4M7i78vYJa0+SIs2+2sfI1eS7LDzSJqIMbA2LoNQhkLyUNjcDMc4uildwDzDTUrJieLdNqNUG/aujM88CxK76HtFKAvhjrMEyCTtAv2vB4iBFVSbIu78jJW0Eg5dtc5QcKvU3dOsxitGvlGpkJYH3Of9joO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918225; c=relaxed/simple;
	bh=2KF4ki0EfgQ+uZ9vsc2VGfGL3iFmSYhOLH35Bex68pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPitscsW+oNNyM7Vzqsfo6mvWqRpw6VbZBeUQqKukwTBacqZCOU4JoUskSk0sBMSpqh7jlYMGh7dyWjQIUvpx7SYMJ1/Pg4a4K+Qgc2r1tLDaq+1R8TC5fHqcQWinIDPSxnvLaEerxhFiWERKIXqvB4AJPJhGm4futlaQcOH3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC/+91rk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6vH5Aol; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ky4pl9zyr5S0rAJVm9feSkr8uxE1/z4/7grpknYGBQ=;
	b=wC/+91rkBgxesWjzSUFrn1aaHrE5XlH3Js+rClZCE1ZGnLWooFFEKbUlYKETTB7a+7d0u6
	Vta22cR6rmyxiTluRlSFOJ/vDw+8O+xvpHMP/3KD90QCAkt0EB7CQWLaSNMk2tNL+iHXym
	Lkgva7xz/YfbCEfYBBqgdnkHw8MojZFe8Py6hphXadmFNJ89FOOXtHyzZgjWq3Gu0E6I4w
	SunArvd1uYYGKUh93G2LdQ0vPgW+FTFijiMOj2mpYIFXnm5lq2E42i4MwbfeBmTvlbXXDs
	w471WqX0Ky0qmz70GRZdG9BUkRFlWeP7VWi+9xwtsFq7uovartr6K1WqklpYHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ky4pl9zyr5S0rAJVm9feSkr8uxE1/z4/7grpknYGBQ=;
	b=p6vH5AolL4dgHysWePGcjdNFUhvaIRtWfNGavbj+nbGTm28Mb+fKOz7HKocCaZ6MBRqoVh
	2kUoiQ6bPkE5uyCA==
Date: Thu, 26 Jun 2025 08:10:15 +0200
Subject: [PATCH v4 07/15] kunit: tool: Add test for nested test result
 reporting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-7-48760534fef5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=2214;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2KF4ki0EfgQ+uZ9vsc2VGfGL3iFmSYhOLH35Bex68pw=;
 b=95Sids2Fk1QJA76lqNzLJEg412tXs/th72tnsd/qvhZ488+ELoUdj/hSVtxGXdRZSjfHG0N5F
 KQ4EJaMGUplB8aMrI+ibw3NkyijpWLDgpfwD0LHnsOHxOITO3pfXT/u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently there is no test validating the result reporting from nested
tests. Add one, it will also be used to validate upcoming changes to the
nested test parsing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_tool_test.py                         | 10 ++++++++++
 .../kunit/test_data/test_is_test_passed-failure-nested.log     |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eacb18663abfcabb2bccf330d8666f5..b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -165,6 +165,16 @@ class KUnitParserTest(unittest.TestCase):
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
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
+
 	def test_no_header(self):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
new file mode 100644
index 0000000000000000000000000000000000000000..2e528da39ab5b2be0fca6cf9160c10929fba3c9e
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
@@ -0,0 +1,7 @@
+KTAP version 1
+1..2
+not ok 1 subtest 1
+    KTAP version 1
+    1..1
+        not ok 1 subsubtest 1
+not ok 2 subtest 2

-- 
2.50.0


