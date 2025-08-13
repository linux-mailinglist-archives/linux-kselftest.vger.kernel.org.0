Return-Path: <linux-kselftest+bounces-38826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D539EB2418D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624837A7404
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6D2D1F64;
	Wed, 13 Aug 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lve0QVUU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bRlmOQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9D256C84;
	Wed, 13 Aug 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066743; cv=none; b=sFXyGB0ExigcMrCkJklIdKvwVkO5Od/EvIdKs12N89meCe6cdqNJjGSn5wTmRvuiJhO7YhfoWxik1MzF+/PA56tBh7YZpFlDjDV7ZASm7MxbP2i7y6GHea4npwcHd2hMNTf1D431pm8gRV9KJIM1NmrostagNWvmslk77fkL1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066743; c=relaxed/simple;
	bh=5qg032v9a3VDlMiDWU0b9ctfLGVw/7YohIMQc/Hgbaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uFdNexxvFlf9IQGm+kJCEI94DT9X5i+74dq8w05fKTDgcF2a+kDCdTtNGNR0RYRClvGfNrT0AtNWqMrcUtclzaeA7/IU2dIzfGLIUS3lCCaaSjDyLYKo/Zmj4GF1YeOUTYPWUJ2g7qfTwxbxJMJE9k/oJ9bBmgaxvkFv3PaEKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lve0QVUU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bRlmOQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755066739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SRqTyhe3RKI3LCkCiYUFb5eBsIQ7LFFUOTaaEf4vnww=;
	b=lve0QVUUx69R4nGes8O0ZOkEYnaE7NAhiUjDtUO86+yk69JnEq9FLwqdlPCPENJ17DSIt8
	EhC+SQjMS9aeTDNFcTf8jkgM/rPQLaIjVGHonLboMcjoxkRxX8m/0Vo+KDmjwiI5PanuGM
	+B9yqynWGSu6N1Qqov9ZyofDZUGuSUE211nZd3DFPJRlt3/x+WYK7VWxU7564BQ0Mmf9R5
	M3W66lLk27qVTR1D0c11QD1/g6dbnblael5KoRq7HsvcMi3c6nv5yPvmrk1jUimAKumj/r
	/TxywK7oMTRlMCC17TcynL6vEFob8ZWTtS6eY4fbYsfqkiXSvI6D43nJLwT2UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755066739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SRqTyhe3RKI3LCkCiYUFb5eBsIQ7LFFUOTaaEf4vnww=;
	b=0bRlmOQrarTM210wv1wND0+XTXworEuIQZTdcYChDAq++pUPjap215u2/blmqPmMatF+Ks
	31+2AOCdpxJBmxBw==
Date: Wed, 13 Aug 2025 08:32:13 +0200
Subject: [PATCH] kunit: tool: Parse skipped tests from kselftest.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-kunit-kselftesth-skip-v1-1-57ae3de4f109@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGwxnGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3ezSvMwS3ezi1Jy0ktTikgzd4uzMAt1UIwvLpNTkFEtzEzMloN6
 CotS0zAqwudGxtbUAQuGMqmcAAAA=
X-Change-ID: 20250813-kunit-kselftesth-skip-e289becd9746
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755066737; l=3393;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5qg032v9a3VDlMiDWU0b9ctfLGVw/7YohIMQc/Hgbaw=;
 b=s25+IgYMvwjdHBJLxkuySfqGzpUgC10XDKa9CGQ5d8hekmUOJFVZznQ8toi90LJQvcwNqxmGF
 5Jy2FOghyhaAtTqFJTw4AAjFiytk0Ptl5lk9KYFg8qLV1fd1fqIihiv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Skipped tests reported by kselftest.h use a different format than KTAP,
there is no explicit test name. Normally the test name is part of the
free-form string after the SKIP keyword:

	ok 3 # SKIP test: some reason

Extend the parser to handle those correctly. Use the free-form string as
test name instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
These patches where originally part of my series "kunit: Introduce UAPI
testing framework" [0], but that isn't going anywhere right now and the
patches are useful on their own.
Both series would go in through the KUnit tree in any case, so there is
no potential for conflicts.
    
[0] https://lore.kernel.org/lkml/20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de/
---
 tools/testing/kunit/kunit_parser.py                             | 8 +++++---
 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c176487356e6c94882046b19ea696d750905b8d5..333cd3a4a56b6f26c10aa1a5ecec9858bc57fbd7 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -352,9 +352,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) ?(- )?([^#]*)( # .*)?$')
 
-TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) ?(- )?(.*) # SKIP ?(.*)$')
 
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

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-kunit-kselftesth-skip-e289becd9746

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


