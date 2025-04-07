Return-Path: <linux-kselftest+bounces-30226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A86A7D668
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BC07A7823
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C5228C9D;
	Mon,  7 Apr 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAw70X/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ts6H7wde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BA226D16;
	Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011784; cv=none; b=YxIN+5m03+eKcLWXoCnv75fOO8dC5ecMXPBTf8dpUYZbx1GYSj15gvl3HG/UmsiFDPkWDU0I1HD2kn/9q7RqCO07HX1/+/QUhsgfZP3jWvxUOgvAncPmfztvovv0QRCl717Nct5EhBr45xitSwE7KXPk4y3TEiSkO1cm8lva7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011784; c=relaxed/simple;
	bh=3IB7VI+L3TgsvP1jwdWMbiCaiRt4l4gNK7FQAsl37ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIocDjoXYl0un4QWsddowceecdT1FUspONlpYhYLPph8ZzKaa2VVHm1ebvFZRvtq4AIy5kw05yPFQa3AsE5PCaXOg1JSXHfXfyRL1NhRVt2gpYQHvM32hhQ4tdPCau1XzMFTjwNnu7FXKjqtUMAsr6kalp0uwBrfkTDIEcogqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAw70X/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ts6H7wde; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=al7zHswypumXIW9i3yKUwj+oxduEQ9DVcaHemgzr5gY=;
	b=lAw70X/q7ujZz/WDtwJTfmmmxibi7z2bpRmganrjZ6IQabUgJlw+6Vl4G1kI5won4HJXgs
	sNWDcY6qDA+ak0o5oMxaknW/qh2kMlVltwLYoeJPheDIyQgw9eXDhK52LbNiE7r4rwdiag
	W/o5Y08MCCnilgXn+A/3ZSuhrFFzwfoO/Uo58BG+3SsAvzYEgpSZGh0mNkBXd9C2mEZv6c
	hBZE5Uj5dRdyERZIs/pzSnDBqmORPqVw2f5a/1GfVQORKuyH6FkW02W0tFl/myNcwj5iYT
	PaJMw6hRI85V3h3aJJWVzwy1MhOhUyIIlNqf0k19FMJJ0TGIS3TTx8M9SqzBmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=al7zHswypumXIW9i3yKUwj+oxduEQ9DVcaHemgzr5gY=;
	b=Ts6H7wdej6bfnCZeF3OLCeG5AACfWppqTlMwW84lKXSoAn2BYa6k6I0ce8xzkF0iH6Lqu+
	KVIyDExQXeLCAUAQ==
Date: Mon, 07 Apr 2025 09:42:43 +0200
Subject: [PATCH v2 06/11] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-6-454114e287fd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=2733;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3IB7VI+L3TgsvP1jwdWMbiCaiRt4l4gNK7FQAsl37ak=;
 b=iVXjhmHBMWkFjHbit/Hw9b4XCX48EMklfbgbfc5sofkXa7jjiRZPFa/KOSHJwV3sGdbb+/4vF
 eXam23foLunAwIQ5hCviSrYNBdaUInktQjt21VcmULRBIk9hYpzne88
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
index da53a709773a23252703b74109142294899b1bbb..b4a695ed7d2c88120b35b617f0ff2f1cb2be60fb 100644
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
index 755dc24350a76306a5b76998646e56fb3e386232..946a68eca16467d9a4bae50f5d50985d9765ed54 100755
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


