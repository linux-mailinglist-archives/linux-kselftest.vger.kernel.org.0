Return-Path: <linux-kselftest+bounces-32379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2044AA9735
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741EB18890C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A8426772A;
	Mon,  5 May 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGVAGUz3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niXve+jX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A5264F87;
	Mon,  5 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458182; cv=none; b=JnHZjM1gAOcN1Ywppy4yjFOFesgQ30Ad9OPMhqKixTUkUvdADnXvYnmG8FCvfhB2mhNCuVYxD/LvL9yfEbJdjUWd8VhryY2/Y0bn9FjK5Tx80dysh5AuQuo5wIJ6TncMM6DEjN7PLTcBEKnoyKFg20isab3Xko4R2Wwyh1hyG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458182; c=relaxed/simple;
	bh=6PXX0RPavfD0BJDHtEI33ME+xSL0lQUIgGhs4+WRGfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTDBOGanAjOu/2Tg183fpn7u9uQRbvFO+x/LgebDYLZdRsp7awRN54LIWKwYaKxTFKMVRFQu57TwFJudvb54loEj4HL6CXVHtItp/xqJFbwNqvPrJOVO6B7bCpZAXf1tKhh2VsAJYYbMObVhSlUeHaY+MWp30ESjIiKN1O+8vXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGVAGUz3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niXve+jX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpw6KDVkngaoQltUTXFxgfCAMehnBq4/rT28mSBJ5PI=;
	b=zGVAGUz37bQzKsVlQaI3iwQDr5mMJeVgDfUNBFWRvPN6SINStYiEnbtRUziOVPDBqCgZNm
	Y5I3A1C9K6yEQMFX6lm6QFY15ZwORbVfDcEP0WkuDx+162IYTGdoaGshnZcr7AAHU6cg+6
	WZ7D+EQW/Ugqq744pTiwf703boeHMWIMpMUqIe4Kp31dByF7T1BmN6o8njBW6AprOVD+px
	48Jgio2eIO5+pFC94BgxRLWTuI04cJwezz1YyYuP+guWesed9qIkNCZVE71EQQnCofjIlr
	RanoCUKWb8ulEBRQ2lPs/0xYE//mkspS70+H480L1dagXc2N+2h0sQZMw1ZUXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpw6KDVkngaoQltUTXFxgfCAMehnBq4/rT28mSBJ5PI=;
	b=niXve+jXGCFUvlAEuzcqpweAyytW3MG3m9B1FL+P+ZwoSYeTtUeYBnSZ4yB+X+aWRtyj95
	NTsP6W8gletH8UDQ==
Date: Mon, 05 May 2025 17:15:30 +0200
Subject: [PATCH v4 12/14] selftests: harness: Stop using setjmp()/longjmp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-12-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=4602;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6PXX0RPavfD0BJDHtEI33ME+xSL0lQUIgGhs4+WRGfM=;
 b=bcb6sDDsuok2fryt9+FDUQ8Kd00SmLVRLwK81fL5PE+J86edkboaoxl+YNKKvna9oXatMsLkv
 XjewX119zqgBfepOIFC631ZloGnIhp+WALWh61ZHF8Ep9KbIbrIl1Hb
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
 tools/testing/selftests/kselftest_harness.h | 45 ++++++++++-------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 088c875df91a58f8760749b6047b246fb2a7891f..2925e47db995d7197ed1f55bd9cc657669df9bd3 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -67,7 +67,6 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
-#include <setjmp.h>
 
 #include "kselftest.h"
 
@@ -178,9 +177,7 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		if (setjmp(_metadata->env) == 0) \
-			test_name(_metadata); \
-		__test_check_assert(_metadata); \
+		test_name(_metadata); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
@@ -425,24 +422,20 @@
 		} \
 		_metadata->variant = variant->data; \
 		_metadata->self = self; \
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
@@ -456,7 +449,6 @@
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
 		} \
-		__test_check_assert(_metadata); \
 	} \
 	static void wrapper_##fixture_name##_##test_name##_teardown( \
 		bool in_parent, struct __test_metadata *_metadata, \
@@ -927,7 +919,6 @@ struct __test_metadata {
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool *no_teardown; /* fixture needs teardown */
-	jmp_buf env;	/* for exiting out of test early */
 	void *self;
 	const void *variant;
 	struct __test_results *results;
@@ -963,19 +954,14 @@ static inline int __bail(int for_realz, struct __test_metadata *t)
 {
 	/* if this is ASSERT, return immediately. */
 	if (for_realz) {
-		t->aborted = true;
-		longjmp(t->env, 1);
+		if (t->teardown_fn)
+			t->teardown_fn(false, t, t->self, t->variant);
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
@@ -1208,7 +1194,6 @@ static void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	t->aborted = false;
 	t->no_teardown = NULL;
-	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",

-- 
2.49.0


