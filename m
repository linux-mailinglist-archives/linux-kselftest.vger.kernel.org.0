Return-Path: <linux-kselftest+bounces-30549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C445A8574D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2970C1BC08A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3229C32C;
	Fri, 11 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nU8uQ20w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nu6Ut2M3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6029AAF0;
	Fri, 11 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362116; cv=none; b=GYi+tDfNxal1Zit9fB4nojeAbX6F9WkVd4i3dAM3rTZB6lp+ha4FV+iIqvlVedy9TFHQPrHF5tmLxg01MslrnXmBkWeS08EU/iNksfKS1oP3nV0TtfP8SZUq/7WRLL/GPjCh4WSugP2n5ZNQF8OxFplwndkK/gDkw+XDLzSn0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362116; c=relaxed/simple;
	bh=ROPqzxq1eeM/Z2SLe3nArtedAx5wJL7q5hTnAUzBZ+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ti5sVwXMwPZZr0PrnrL2cqv2xK0vPGY80GTGbF5o/KTvi40Ld7L6MBpb6ZYNgKk7vHL/MWy5vOUiKcXCy3yTkD9GsAUTENYVH1VDCONnR+lH9Xaar1uD/oGhfDqeCfLPpj/PfpctYAMTbLXTKUB6h1cdXBJKlodYxMZ982uG6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nU8uQ20w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nu6Ut2M3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw4rcpI3oL6Bs10R/XzcuUCLJVM3NVoV8YHTZBkuT2U=;
	b=nU8uQ20wiizde0TMxSgsxVec8M0UqkLdga3Uq0jl8mv/6e5fQVUxWRtRQXTPtZvloStwLi
	Od4Cj2dmyCN4W0ekWLUX5rBel6BC8zPMtCdVHE8hPfXxhpZHLlofwpAedudbmuSq+275es
	J3Y8fsdTyMdMPxjsVRwsVTdT6mQjtt5TEW9JndgKOanSpKUNz7eK61RGAoeM0RfRV+Kmrp
	Y0PcQQSTZI0tEYQ0tf7spodC/nb2ejQk2l+Xnu+Mo5ADFJgfI1fHd3eIhrvD1YIaIOYld8
	KyNYoG5p6qNjaRBlKfGoG9YLBHZlXldcqky86Cz5Yz/nAVqm+BkbhFycPdGo1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw4rcpI3oL6Bs10R/XzcuUCLJVM3NVoV8YHTZBkuT2U=;
	b=nu6Ut2M3klYqvLLd8dQfeNhJ3kX+7bVLDDUTteVHECg1DnPKBqwuCMKEIl3ohHjM5QBlZT
	DzW3YXqrl1i155Cw==
Date: Fri, 11 Apr 2025 11:00:36 +0200
Subject: [PATCH v3 12/32] selftests: harness: Stop using setjmp()/longjmp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-12-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=5100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ROPqzxq1eeM/Z2SLe3nArtedAx5wJL7q5hTnAUzBZ+0=;
 b=i5msfMsukLXfbShCvDymELpy1/tOoVE2RZSkvcdC69e9brzbt3BvbPVaDdjVCigs8C4EB7zmt
 pxDuDUehSYSDdWxbAK/ciopJZ1avokmW7NHSUBHJwmTysKVyEdvLJp7
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
index 5373b8da8886aef5df3368aeff95080636ae2343..1e584f39a42023c400988dea96f0274d4dc3645b 100644
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
-			test_name(_metadata, NULL, NULL); \
-		__test_check_assert(_metadata); \
+		test_name(_metadata, NULL, NULL); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
@@ -425,24 +422,20 @@
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
@@ -456,7 +449,6 @@
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
 		} \
-		__test_check_assert(_metadata); \
 	} \
 	static void wrapper_##fixture_name##_##test_name##_teardown( \
 		bool in_parent, struct __test_metadata *_metadata, \
@@ -757,7 +749,7 @@
  */
 #define OPTIONAL_HANDLER(_assert) \
 	for (; _metadata->trigger; _metadata->trigger = \
-			__bail(_assert, _metadata))
+			__bail(_assert, _metadata, self, variant))
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
@@ -927,7 +919,6 @@ struct __test_metadata {
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool *no_teardown; /* fixture needs teardown */
-	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
@@ -957,23 +948,18 @@ static inline void __register_xfail(struct __test_xfail *xf)
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
@@ -1206,7 +1192,6 @@ static void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	t->aborted = false;
 	t->no_teardown = NULL;
-	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",

-- 
2.49.0


