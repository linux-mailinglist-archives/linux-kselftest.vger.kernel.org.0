Return-Path: <linux-kselftest+bounces-30540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81003A85739
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763884A1106
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44E2989B1;
	Fri, 11 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAO7VPLq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2EDTjpo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE512980A7;
	Fri, 11 Apr 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362111; cv=none; b=IMihDIidJULoBcxAwfBzA8jC12BDtyNoHv7JUyrnYTdlNmu0I8cExAi1IttUrecMGtHVMQtUJcZex3D0eAVQL9shnm+qVQ/HzXSlM52JXe0XfuVk8HM8fY4s2E+Uw2hhA8v/gpzqtXbOT9FZY0G/r4YUJ7/uyl/USqHorrBrsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362111; c=relaxed/simple;
	bh=7893zOP3ErdGxPwks26zDP9HHy3HGwCgpTrK5rmbvbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpmBMt2Bd7NjX+qTgfm8Cgv3eBgNI0Dq6bT62MPwpmOGcoLkDts6EEk778isxca4u2NAwkrvC2a/Ge133qMdtOb13hFqECWcGxQG7Pju58XcvuAifxCc76XTrLKWQJdOqfACFN2QcMMVMh1ix0G0W+n55wxvkzwBMfE+wwf8CcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAO7VPLq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2EDTjpo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz0u8GJ5dhijczEOeytq6qafYlrK5qIQk1St+S1OOGs=;
	b=cAO7VPLqVOUtAzzhZct7m6AJdanZpJAhz73SUmqeuJkT3UiQj+fnJ8vaPG256MG2eHEGnP
	Yx/lI4nKwu5Bo5NBZHIBldl2UE3uLra5kBnvvbyxtqe2YD1d0piqHfHB+MyFgSksVgUEF0
	w8+jwqlt5Y+uqkzJpOBFvrNfBex0/2vCsVO/6ZbvtHYisjBSDHDj/ONdxq6MPVeSriEeuB
	6hPNyO/AZQ0a/QjJ5vg3QZ6ZdCI+8v0HldNTJZC0ayNry61m0q7+AhLq4bsh13zGk8gfnB
	K+5UBXLaNXNST1D6uZnZC64fdCaNWDTZFwKCtvlDYY6GE1StzpPfUtIap/thNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz0u8GJ5dhijczEOeytq6qafYlrK5qIQk1St+S1OOGs=;
	b=R2EDTjpoYByqeaoQkC+cVRaM3IyXf2XlXZyjjwUaG2maUzNA8zHr+z0kOjD6V+ctGwhsag
	6ti6lYHAeeXQ95CA==
Date: Fri, 11 Apr 2025 11:00:28 +0200
Subject: [PATCH v3 04/32] selftests: harness: Mark functions without
 prototypes static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-4-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2245;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7893zOP3ErdGxPwks26zDP9HHy3HGwCgpTrK5rmbvbc=;
 b=kwuHGbOCvhwkjq6R92NXRbTu5KQYILLerD3h2waEjKBfh7d8rLMtW0GPW+bpTE8VnwE8aN1HD
 w9OPNtz8lkGCwWgjsj7mKH4SMcOGOOt3oWn5xCWBfXaPrp0UqaTnczz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With -Wmissing-prototypes the compiler will warn about non-static
functions which don't have a prototype defined.
As they are not used from a different compilation unit they don't need to
be defined globally.

Avoid the issue by marking the functions static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2b350ed60b2bf1cbede8e3a9b4ac5fe716900144..5822bc0b86a3c623fd34830fb8b541b27672a00b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -258,7 +258,7 @@
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_SETUP(fixture_name) \
-	void fixture_name##_setup( \
+	static void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -307,7 +307,7 @@
 	__FIXTURE_TEARDOWN(fixture_name)
 
 #define __FIXTURE_TEARDOWN(fixture_name) \
-	void fixture_name##_teardown( \
+	static void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -987,7 +987,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	kill(-(t->pid), SIGKILL);
 }
 
-void __wait_for_test(struct __test_metadata *t)
+static void __wait_for_test(struct __test_metadata *t)
 {
 	struct sigaction action = {
 		.sa_sigaction = __timeout_handler,
@@ -1205,9 +1205,9 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
 
-void __run_test(struct __fixture_metadata *f,
-		struct __fixture_variant_metadata *variant,
-		struct __test_metadata *t)
+static void __run_test(struct __fixture_metadata *f,
+		       struct __fixture_variant_metadata *variant,
+		       struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
 	char test_name[1024];

-- 
2.49.0


