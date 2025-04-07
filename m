Return-Path: <linux-kselftest+bounces-30228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6285A7D69F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B36F3BCC54
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F922A4DB;
	Mon,  7 Apr 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUQjQmZ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPfo6cdf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D8227E96;
	Mon,  7 Apr 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011785; cv=none; b=RmLR9NhK64MT2uJJkzCWsBXFD3Qf6EtxX6eRkv8SJUUPaJ6edUPAU5d0efGdKcF0W/Y77YTady+kZ01O0ungIUzzuL9YI3oXzvjRjr95Z4lLMVtSDzbuFDu/5z4nA3E1zt0Ic8fmebgS2ilpe6a0o1NLTIoKa7FhqP0syF3OMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011785; c=relaxed/simple;
	bh=5+9YHZKmXU6mu3ieCn3ti44g1IrXSfzapL+qAM5m2Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRut2c28f3meBzgApwSoC8zhbfLF3UmWyNe/H08f+4lxhbLOZc22L0qRxP781omP+G6FzIG2v7GDK4gRwSzInGJw3ysFWElAG1PNyrTWEVE/JQkfDAdV90MOeXtvlDZxSfbwcoWLQ84r1bf0JTftkGidpXafLJElttswNtlOM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUQjQmZ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPfo6cdf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6kgYTTgkOaGrAjyvy1nAqnbCYfemdPya6M/+xOGiEc=;
	b=iUQjQmZ4WLhv8Bj5/LsbYSllLNNiC0ByhwrAdFwfc39flMyavPPOUM6dQuI7mi4KnF6s4o
	neo5r27sEKMqJifGGFiPyP01Fi9q6VMDhf4s865/COiDHsN8j1e9Xq669GTtN8X/wVwk+t
	YSMDk1L6is7VccCSrkRCAPsouTHtZN+eU+sb3WP5eV0ZM3MmLy2RJTqbPoLOEzGwIPVOYN
	pjiSMF9VBmawWqMU58NYUfE2IJFUC5QF/0UDiHaXjgqzWygWKcmdB5cJ1Mr6gagh2sTkFb
	z85rpFK0Mbu85SXLloKObIZXS/eWWFGcrt4SNfbg+YbLez+UACMzonmXOh9MXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6kgYTTgkOaGrAjyvy1nAqnbCYfemdPya6M/+xOGiEc=;
	b=nPfo6cdfGcoXjaSzliF6IZJmggvMNlZYQMb27T7+3WWDH99HiM2zIHKtCOPq0+WPRcGm1E
	Wqo1L+wiPA4EDpBA==
Date: Mon, 07 Apr 2025 09:42:44 +0200
Subject: [PATCH v2 07/11] kunit: tool: Parse skipped tests from kselftest.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-7-454114e287fd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=2785;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5+9YHZKmXU6mu3ieCn3ti44g1IrXSfzapL+qAM5m2Io=;
 b=29XvoBTMRB00a/65QHfQvVAsIXIBH7G5KKROFGXUVpbDYaKm9czWb2Mqti8KnPTC6ddNLcCrB
 P/fHFMKUu6QDO8VyonYFUsn6Cp9qm4RYAs5YP3YfKCafgYJ+RTmSNaK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Skipped tests reported by kselftest.h use a different format than KTAP,
there is no explicit test name. Normally the test name is part of the
free-form string after the SKIP keyword:

	ok 3 # SKIP test: some reason

Extend the parser to handle those correctly. Use the free-form string as
test name instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_parser.py                             | 8 +++++---
 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index b4a695ed7d2c88120b35b617f0ff2f1cb2be60fb..41aaa85d249b592efe6227a4c2d9517a5c13dbef 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -352,9 +352,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?([^#]*)( # .*)?$')
 
-TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?(.*) # SKIP ?(.*)$')
 
 def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	"""
@@ -379,6 +379,8 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	if not match:
 		return False
 	name = match.group(4)
+	if not name:
+		return False
 	return name == test.name
 
 def parse_test_result(lines: LineStream, test: Test,
@@ -416,7 +418,7 @@ def parse_test_result(lines: LineStream, test: Test,
 
 	# Set name of test object
 	if skip_match:
-		test.name = skip_match.group(4)
+		test.name = skip_match.group(4) or skip_match.group(5)
 	else:
 		test.name = match.group(4)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
index 65d3f27feaf22a3f47ed831c4c24f6f11c625a92..30d9ef18bcec177067288d5242771236f29b7d56 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
@@ -1,5 +1,5 @@
 TAP version 13
-1..2
+1..3
 # selftests: membarrier: membarrier_test_single_thread
 # TAP version 13
 # 1..2
@@ -12,3 +12,4 @@ ok 1 selftests: membarrier: membarrier_test_single_thread
 # ok 1 sys_membarrier available
 # ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
 ok 2 selftests: membarrier: membarrier_test_multi_thread
+ok 3 # SKIP selftests: membarrier: membarrier_test_multi_thread

-- 
2.49.0


