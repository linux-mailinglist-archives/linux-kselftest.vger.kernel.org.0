Return-Path: <linux-kselftest+bounces-35824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F5AE95D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AADA1C402CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283125D543;
	Thu, 26 Jun 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMjS1CG/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxu+ql+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602624DCEB;
	Thu, 26 Jun 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918226; cv=none; b=gDSlAsIkFWBQUpTZeKDJugLyn1FCfxvnFKZC3RFj0GInTOLtWpK8Vvj87GIE3Fq7beMYb25hEA3OyJjDqgcee9BzWOa8vOSlFVfMghLEV/rOyVoASnFd+d2/wbU5BQQRl+nD8ZjmOsdcQU7RXUcfDP2Gse2KccJPX/fzhz57958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918226; c=relaxed/simple;
	bh=BgHglaR4DzzW2IPxgThAlx+/qqcc0TXML7OsBM4NoBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEeS9Ot1mfV/VPKIlzuF5P3JWwQHYgXf2S8M1BDYatDbGe5/YMM79ZRLKHJmbj8+8fS1MFMj3NfYKR3zgO4fu1rsRnB8Isc5me3B6LmBIbBYQYkyyCfwJvztHW9xa6y9O244GqQPFLjrODk37XSWBRGPrbK4ueGGXWhljTmdJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMjS1CG/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sxu+ql+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKirMxHE1YxM9ynO9swFUkpubSglCQdgwJmIoDy+YxU=;
	b=nMjS1CG/yxTUVbWKorw/3bOw365XOLYS0ASXjiL6d4n+MPkGmJWi/xsW7AxXB52lfl0teo
	1PTskggqq3jfSVE0SwLS7UtoeFmRPKA04+WaL12t/ixW/f3vJuGR6Hlj/6N/pnqshmfoXm
	B+RtxE7cY5rCK455Zf1t/5VzFlAeFp8BXet061DAYKJjXjfKyGpTX7GLsZsu99S5ORps6T
	1dl0iD6MBwj6lEik8hlYXu/wDp8vogij6NffOuCHizJpvY8pU8PVQJ/FkGavE52lseYDfs
	79/e84NCkURPDoNjZ8fPLPqHRNu2JjG//fhrvAATGG8cXLKwLKLtvvdszlJdYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKirMxHE1YxM9ynO9swFUkpubSglCQdgwJmIoDy+YxU=;
	b=sxu+ql+RMtIFHfreNZ6cS4cM4zTqlNz2TZb9DgZOr8uXj9jIbnqc1k/ZmrZWk5BprTOvEL
	ekRjqfZkjP2IiQCQ==
Date: Thu, 26 Jun 2025 08:10:17 +0200
Subject: [PATCH v4 09/15] kunit: tool: Parse skipped tests from kselftest.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-9-48760534fef5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=2831;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BgHglaR4DzzW2IPxgThAlx+/qqcc0TXML7OsBM4NoBo=;
 b=oXs6ENKi5E7FMsucpJTgQ1z8dJdZNVeEliXEubYDgG+sDqIhXI7MdrecBaS2cUZBpr2L3KozY
 br+7LQg1UPcA8mX4rIyqgmXWpLSiUSd55E77S2Xd0zCCplacX/WFi0k
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
 tools/testing/kunit/kunit_parser.py                             | 8 +++++---
 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 2478beb28fc3db825855ad46200340e884da7df1..4599d23c79b79f0e219d655c7053c8c3b34f8152 100644
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
2.50.0


