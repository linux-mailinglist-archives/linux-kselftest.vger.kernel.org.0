Return-Path: <linux-kselftest+bounces-30190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D762EA7D490
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22643AF5D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3C225A22;
	Mon,  7 Apr 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBIcstF8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJlkKgrP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A32248A4;
	Mon,  7 Apr 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008784; cv=none; b=Cd6GFHyhYylY2uCCzoMk7w8UQbcFFhE7AZX3bLPKrxc4uy6yKuufFoiZ7Re7MGSz+/HaOOoS5dP9kXYguVri5L5dx4w+eXdPOS4xkhnH/ftTVuUXNiJ5EfXMDnd+ASvqGxptitpLrxXw7G/PXnkpdMyOYiOQj8gtYefacao38ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008784; c=relaxed/simple;
	bh=7893zOP3ErdGxPwks26zDP9HHy3HGwCgpTrK5rmbvbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ML2CkBbtnqDzMVdBF2XQm6egvFeF4tzqbPRxSgI9tUySxjTMAFl4pubdbths+syBmf8VcWsb7zCg6qlgWpVAYl1jAciCU4fLAkQXfJEoJIuHhherdKHcjTYTN0MGIQWcO9KZ1dish3WNzkvIHeHVUAzulTEowZlEevbUKAuOzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBIcstF8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJlkKgrP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz0u8GJ5dhijczEOeytq6qafYlrK5qIQk1St+S1OOGs=;
	b=UBIcstF84RxUF/8Oj2Zjthj5aIUzaoeRDX8ies+KzDDJQvAMK3W4q1mQJNdw/j9R8tytNw
	W7Ra1CWJhfRchqmKvuqctyonlg8/ibhqPJHF6TehZcL3oNiVT9fVSyfIHGG2DGmKXw5+wq
	0DAQVSLSujwIYhwPFqH12ojFAKYVe5xV4eanlOHnoM2usotLuj6CjmLj9hmXU867qGVc6/
	+AC0MrqL7l+r8tkP/uY9rp/mxHQVxHJdX0Rp2oRwDzaVSFeG8ye4V7kgd6sQHo8gIfSCzp
	3xt2htemjfUoVHleOteDr8/mXtwokFAnFyBA5LmrKnL5MgG5mViXoby/1N/kYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz0u8GJ5dhijczEOeytq6qafYlrK5qIQk1St+S1OOGs=;
	b=MJlkKgrPigPUHnGOTupfCnd4xiQG1UQ3T7ubz7cwP6yMYulLj1LnYP5/zS1aJPad6/Q6+F
	/lookqiBrT14O3Dw==
Date: Mon, 07 Apr 2025 08:52:27 +0200
Subject: [PATCH v2 04/32] selftests: harness: Mark functions without
 prototypes static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-4-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2245;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7893zOP3ErdGxPwks26zDP9HHy3HGwCgpTrK5rmbvbc=;
 b=NMWEA3A5sGkwwVwSAad8ApervGWtmoiPgGq7uRH5Rwr1BHlX1sqvdiwl78HgCxNr4asichvrM
 ucLugT+SYlICO7jAtRfYC8zg3W19uTBVMSLA5U2em5AnxzPLAeP2McC
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


