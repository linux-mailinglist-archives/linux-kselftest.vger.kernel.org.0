Return-Path: <linux-kselftest+bounces-48009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B217CE9A70
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57729302C8F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356642EBB81;
	Tue, 30 Dec 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iU1TgcRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyhCdcd3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB22EA75E;
	Tue, 30 Dec 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097607; cv=none; b=UMfv4IJxZkwqI+h7SeguNdBQdGzHrNCexwOF7KdBn8HNxtsLOw8rVz91WG1NHbVd1ns6NbYDmYhrkxaGykwZ0h86/RRPyY9I4eUhkQhsyudPeTnbzvZkfofykbkLy3sA++OS6V3xuB6S5WxtpZyM3qLPIMYcwujx/Kp+tpK1OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097607; c=relaxed/simple;
	bh=ZMbxzGWr/vrZP/8PKzVCh8okmNKn/J8jot4OuPSzvNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqHBCasPvtThwnMxb+I9BysG4LtGh2oHISJA4OlOfF/DjDtdAE9wmUAOF1fmvxmXbpRNDOICzo882q2MDK8mWPS4iZXpeBIHuwu5is8/Krf/QgO3YJYtoXAVN3xq7EkMfUPdaraGQxekjeVdIXHBvDRdz4Bb6EEpORSiMKNt2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iU1TgcRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IyhCdcd3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767097603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNZEdmarCwKajBwZbA69hu0SIivcfckoXMusV43q5YQ=;
	b=iU1TgcRmWFj8CUQr9hUse0RvaThe2nLojPvrsnYhlx+mkLTE1MVM/zW64LAA8mq6zR+dgl
	qOIked77hy4s8bmKIqEXok1jtbVSbz7USXe3Skk6SrN6qrKjudahGAcQrfqVlHtEoVM46U
	1HeAV0Jb5qRPTqYbdTWMjuJ2RRk/r6JffxVpJWAfDhyXS6Pnw8FgBdRJHgGaBf6oL59+Ot
	VnEY8w0Edpa8id91t85K0LUrmz0Z/i11+zN/dMf19dJ7/vwgfZusfuyJDp1VROHyG+8ss7
	2jTTeH8f1y9Cd7/kTCZOKNVL1/8lMx9A2Nsx2hElQMBXP+IzVnIxXXgxJ9HEug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767097603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNZEdmarCwKajBwZbA69hu0SIivcfckoXMusV43q5YQ=;
	b=IyhCdcd31tx4NwNgoHAg3ga9iR4c6W+f6pVfVJWIT4X4SLgoV/yQVbg4QMv5m/nTU+iMsJ
	LRq/01QA/XsBmQBw==
Date: Tue, 30 Dec 2025 13:26:35 +0100
Subject: [PATCH 1/2] kunit: tool: Add test for nested test result reporting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-kunit-nested-failure-v1-1-98cfbeb87823@linutronix.de>
References: <20251230-kunit-nested-failure-v1-0-98cfbeb87823@linutronix.de>
In-Reply-To: <20251230-kunit-nested-failure-v1-0-98cfbeb87823@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Rae Moar <raemoar63@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767097602; l=2152;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZMbxzGWr/vrZP/8PKzVCh8okmNKn/J8jot4OuPSzvNo=;
 b=yk6V8AcqSrranhCkRNEVpWTtvoL4Dof4ifyeau19oY0OhhRqBDGrxHJbHO/XMcYQ0OhOTBPek
 xkUNtglTmwUB6FYpOE6RpNdFL8I5KTeNWOFFj8ge4aey/fxQtoCTjUY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently there is a lack of tests validating the result reporting from
nested tests. Add one, it will also be used to validate upcoming changes
to the nested test parsing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_tool_test.py                         | 10 ++++++++++
 .../kunit/test_data/test_is_test_passed-failure-nested.log     |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eac..b74dc05fc2fe 100755
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
index 000000000000..2e528da39ab5
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
2.52.0


