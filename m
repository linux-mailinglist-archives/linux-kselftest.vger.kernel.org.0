Return-Path: <linux-kselftest+bounces-28161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B794CA4D468
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66CD174504
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A31FC0EF;
	Tue,  4 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eW7ksq3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gloEuXll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97991FAC38;
	Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072279; cv=none; b=a80zZ8HRkCjRJdKaljtV5DhqbeqVYd6lpJqZxtyCIQOprp2d49263CkABqPckpFvPWlkt+gY0UBQaVVdgm5zWcCnrRFazO87hR3gLNY2HKA7hCMOWJjZmFoTrUnTm9OqmxzyYhGzTNWOsh2bTHYSknkrCxcYPDNG5wEm/TGC07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072279; c=relaxed/simple;
	bh=M1vd8Z9iYa877FOzbc1SvHGKXTYeUeiOx5fq6u0VCh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fhhx690+m2bpBOLbWR4J3SRYIIGZjSteuK+vHHIf4WPOQCqOeHZJD/LuS/uDZb5lVyW5AEEergt1X/mvPYqPruyuh1VVZ+Qk+wN7bNvOu+hxzhS+9iyVgfAP8fVxgaFClNyEb1jVSk8tnki1SW+Ir/VdmoPKDl4wQ+IR4OjHsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eW7ksq3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gloEuXll; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfPXv/LXz8n1+ZUFV+l2WWTtIn2W+XR413g/QfPa9lU=;
	b=4eW7ksq3R3vHxKCYSNGZybQTTiYpakb716N0ANgGs3/tk3Nu4iszX5jq9TzSgJ8ip4mHh7
	kyQ+fNZOpy651MIvHhVvy446fYro7GKicFrISaU0NvoyF9yXcCYBW7AeP0QAQQmjkiQY4s
	wYPut4pHhUxpu1cIZoonysaXY8XJCgViaRn/9hBFgl+tiQxDpf1Gw6U1ObeJnaGQuiiIKI
	auBnGFXviHXshdBeyJrK4LZTjmRmNoe5qV+a0fI/L0LnP6dSbZxQ1yi9ZEHvcfVgmphLA8
	QPwG8vhvV9WTQNRhAsBPvZpuklD36PeZdzu4I8MeocqftW/qtdNtsJnmmEjkhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfPXv/LXz8n1+ZUFV+l2WWTtIn2W+XR413g/QfPa9lU=;
	b=gloEuXllwIHeUJkDMCbyJ8kIa2CNGUt2ZeMutcr/uR6bO2YJVmiQiuPc63NXkVzLyRuSng
	1yv3CMvXuDQshgCw==
Date: Tue, 04 Mar 2025 08:10:43 +0100
Subject: [PATCH 13/32] selftests: harness: Stop using setjmp()/longjmp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-13-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=5108;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M1vd8Z9iYa877FOzbc1SvHGKXTYeUeiOx5fq6u0VCh8=;
 b=edHn/YmGaQAh2EiAaKEG9Cgjg2T8YzYmUEjXA04lvcy3faT4QxEF1+tQmyP2AXdHIFoA8v1kB
 kv26q43Rx1DC4tPITW9IqXAy3K1R6mr05qYli8SMHIPWdjXInOVOwr8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Usage of longjmp() was added to ensure that teardown is always run in
commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN for ASSERT failures")
However instead of calling longjmp() to the teardown handler it is easier to
just call the teardown handler directly from __bail().
Any potential duplicate teardown invocations are harmless as the actual
handler will only ever be executed once since
commit fff37bd32c76 ("selftests/harness: Fix fixture teardown").

Additionally this removes a incompatibility with nolibc,
which does not support setjmp()/longjmp().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 49 ++++++++++-------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index efc855b93315892a822c9eefc8d7a3784793c754..b7842dd5302375b75416830c22fac0775e0d12d1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -70,7 +70,6 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <setjmp.h>
 #endif
 
 #include "kselftest.h"
@@ -182,9 +181,7 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		if (setjmp(_metadata->env) == 0) \
-			test_name(_metadata, NULL, NULL); \
-		__test_check_assert(_metadata); \
+		test_name(_metadata, NULL, NULL); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
@@ -429,24 +426,20 @@
 				self = &self_private; \
 			} \
 		} \
-		if (setjmp(_metadata->env) == 0) { \
-			/* _metadata and potentially self are shared with all forks. */ \
-			child = fork(); \
-			if (child == 0) { \
-				fixture_name##_setup(_metadata, self, variant->data); \
-				/* Let setup failure terminate early. */ \
-				if (_metadata->exit_code) \
-					_exit(0); \
-				*_metadata->no_teardown = false; \
-				fixture_name##_##test_name(_metadata, self, variant->data); \
-			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
-				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
-				_metadata->exit_code = KSFT_FAIL; \
-			} \
-		} \
+		/* _metadata and potentially self are shared with all forks. */ \
+		child = fork(); \
 		if (child == 0) { \
+			fixture_name##_setup(_metadata, self, variant->data); \
+			/* Let setup failure terminate early. */ \
+			if (_metadata->exit_code) \
+				_exit(0); \
+			*_metadata->no_teardown = false; \
+			fixture_name##_##test_name(_metadata, self, variant->data); \
 			_metadata->teardown_fn(false, _metadata, self, variant->data); \
 			_exit(0); \
+		} else if (child < 0 || child != waitpid(child, &status, 0)) { \
+			ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
+			_metadata->exit_code = KSFT_FAIL; \
 		} \
 		_metadata->teardown_fn(true, _metadata, self, variant->data); \
 		munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
@@ -460,7 +453,6 @@
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
 		} \
-		__test_check_assert(_metadata); \
 	} \
 	static void wrapper_##fixture_name##_##test_name##_teardown( \
 		bool in_parent, struct __test_metadata *_metadata, \
@@ -761,7 +753,7 @@
  */
 #define OPTIONAL_HANDLER(_assert) \
 	for (; _metadata->trigger; _metadata->trigger = \
-			__bail(_assert, _metadata))
+			__bail(_assert, _metadata, self, variant))
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
@@ -931,7 +923,6 @@ struct __test_metadata {
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool *no_teardown; /* fixture needs teardown */
-	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
@@ -961,23 +952,18 @@ static inline void __register_xfail(struct __test_xfail *xf)
 	__LIST_APPEND(xf->variant->xfails, xf);
 }
 
-static inline int __bail(int for_realz, struct __test_metadata *t)
+static inline int __bail(int for_realz, struct __test_metadata *t, void *self, const void *variant)
 {
 	/* if this is ASSERT, return immediately. */
 	if (for_realz) {
-		t->aborted = true;
-		longjmp(t->env, 1);
+		if (t->teardown_fn)
+			t->teardown_fn(false, t, self, variant);
+		abort();
 	}
 	/* otherwise, end the for loop and continue. */
 	return 0;
 }
 
-static inline void __test_check_assert(struct __test_metadata *t)
-{
-	if (t->aborted)
-		abort();
-}
-
 static void __wait_for_test(struct __test_metadata *t)
 {
 	/*
@@ -1210,7 +1196,6 @@ static void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	t->aborted = false;
 	t->no_teardown = NULL;
-	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",

-- 
2.48.1


