Return-Path: <linux-kselftest+bounces-30197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BF6A7D4A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1F616E4B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9C229B1F;
	Mon,  7 Apr 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K6hc7nj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApfBqGjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD49227E95;
	Mon,  7 Apr 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008789; cv=none; b=AVbzKXN5YRm7pZ8QKc+5HJQOMsi4fmEiGWuAiV6rw0dE5PWkWcjs1yNMIyvPhO8FwtGq+a382G8U3NaYYhNeQn2cpLLsj/VKpmhpOyzsLyxV5rKk3tLD7rxsybB9q/RnHkxXhm7wR0+P/RaVVtkksVC8XbSWXm+EbLtWGPtKNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008789; c=relaxed/simple;
	bh=ROPqzxq1eeM/Z2SLe3nArtedAx5wJL7q5hTnAUzBZ+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5hG5m9C4Q1KwUfeL2xTysjSN5/0dwctjLoTC9YihQG99alNfj7AKAgRCqqDd/LiEZfcb0iLjym18A5Id0L8HWwD/012yy/6nBTUfM46GhOfZWm+VcWfa9kKhEW5iNHN4iTcCSBdhQNxSOoCIA0agM/+D/N1/zO6js4oLVwhxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K6hc7nj2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ApfBqGjH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw4rcpI3oL6Bs10R/XzcuUCLJVM3NVoV8YHTZBkuT2U=;
	b=K6hc7nj2afGxdw776RAnsZMGAEjfPJyGkEhwGn+Tst0N8sWmyuIMpg81dOR8Kdpqv+Eo3d
	p+gDCqJ5jfVkzp1zZK8zE/WcK9cNrAB1OcO1lLkBKnFNwXt7nHCIERj37D8Klmx2ihaPT6
	xOROqpE1HH4GOTCxvPfF020LevTc4QtJ9fDFqtakji8YlGmBbt1WTJiOqwVeu6bRqHbsVz
	Kibg0COaWK91c6cmHdV1NmM4im210YLebj/ZkT0QMTCG79TmgdhWejSKjqpjRfrkw3N7eT
	c2FI1W7Fsf9gKvQLfVtOTegXdB8lMVlIfZOongQYKPYz+fAMYjSpaoG6wcYKzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw4rcpI3oL6Bs10R/XzcuUCLJVM3NVoV8YHTZBkuT2U=;
	b=ApfBqGjH9Fl9PDHr8BBbu4fLy/lg42A+0sZeyK1Ld6JXv7luXsDW63HdBNrqeEhWAOTMZ2
	b88MPWJQPXRU2aCQ==
Date: Mon, 07 Apr 2025 08:52:35 +0200
Subject: [PATCH v2 12/32] selftests: harness: Stop using setjmp()/longjmp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-12-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=5100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ROPqzxq1eeM/Z2SLe3nArtedAx5wJL7q5hTnAUzBZ+0=;
 b=PeBac82BLrexwbS8lMclgonDU1WIe5nKjGu5Ozpu3cRrJ7ueTcZTlRUpcxrnbSDY3gEil2gzh
 iY9VwYgwSQUDJ/epuvKAx8phB0eMMwrvt0tzg4DnDbI1n88TwhKI13w
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


