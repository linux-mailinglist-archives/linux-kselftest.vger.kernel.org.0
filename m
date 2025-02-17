Return-Path: <linux-kselftest+bounces-26767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC2A3813E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4AD18984D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229521A42C;
	Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3RZBLM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/VFtOcz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AD218EB8;
	Mon, 17 Feb 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790043; cv=none; b=su6f1eyLY62lasvYYZ3IuLliqSGl5JvPB6DCYrosbmqMHRtsA9O7YSakDEIqF7CGVtY38VPHIfPQZTqa/1UJQntipeL5+/PtTVRlLpJg7MYuK6pI4CK3QMFrWohntkhH43lX/byKe0i3dH2mr5K8IJe4z/p7oswwuM/dUvHeI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790043; c=relaxed/simple;
	bh=VVpiYq/6Re3t0jtT2paYBPSgIav0OJgY8gB31IQtpw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebpy4pt3pY0Xxv2Qf+sRZGZ/IESoH1cuqkj3X8T5uP13SIZE0dNRkCwSsGUweQmNT9/Ym+EEIrdz546N2MvrSOvgjMoquhZ1rt6OBRWbc6w9hkakRjBLTiclnRXe5qqDSVi1t6FOu6TOTBC+3cKTYmjr1HSO/95aYkSY935pj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3RZBLM+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/VFtOcz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygzfGpvhv4BgMLDJbt1hgtavbyQVdT4YW4iOp7XXpFY=;
	b=m3RZBLM+Eb0RO452llz8lNmp+YV6t0XGK1bzIaBwIxai6p13zYChGtxvr2hPo36uqOuT3M
	colKZMK81mqJAPKSYQlXMl5WLCD/t0QqsWeLLy84X0EnLyCAmyZ7P8S7XR/l4y988DZVfo
	BUlrOY3V1FRdeBjClZiPk2h95k/HfExC2NtQ8XSAUzx+eI7cv0KbhNInaJgC/nkKHOhAdR
	OkxhbK7OSQyJ4MFljmMU1lWYgJauRiFWhZ8fSTin47s/VK97xg4q5qPyQMvenk2pxyXqgG
	DakgVuQS6DvHmOPeSqSGmDJtAbn321rxvBuC3yu+xcr6ThR1RR1JsNatIkM8Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygzfGpvhv4BgMLDJbt1hgtavbyQVdT4YW4iOp7XXpFY=;
	b=+/VFtOczDVdwAk2Qmo3w7ND+/GRqIA737gtzhPJz4cy2L9ceRF84uRebjrArdZjZrXxPDE
	KI86QOt9gQYMVZAw==
Date: Mon, 17 Feb 2025 11:59:28 +0100
Subject: [PATCH 08/12] kunit: tool: Parse skipped tests from kselftest.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-8-42b4524c3b0a@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=2785;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VVpiYq/6Re3t0jtT2paYBPSgIav0OJgY8gB31IQtpw0=;
 b=FAKOhCJCxzDlg60wPSZ9kkfW8+a9pSzLAltwlYM5PmXn79g9RILSVYT5WBXzzxLjBLN8RJ/l3
 oGBRUXTGPyGCAoLXd5nsTu2ksf7Nm1G6KEqgAC/I59JDvbB+mZYFVXl
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
index 8f597a244b9866528ffb3850e876acb487f3bbd4..096fe0c9740dd8ec528cbc3dabefcd5bc9b40e50 100644
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
2.48.1


