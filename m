Return-Path: <linux-kselftest+bounces-28158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C570CA4D467
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A7E3A9DA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51A1FBC99;
	Tue,  4 Mar 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqs0eO7x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lr8+zCAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D41F9A9C;
	Tue,  4 Mar 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072277; cv=none; b=hQu6O2QJTSOqeb4LMgqZcE+Z2j3FRhTO4A2bH7wTq2QBC2gJZsLRsUAIFrxUpelDDHJkMEi8E0MBDj7QNF+01EYT2/jHxVwnGoq6+1LQlchtNaNIJUQP6RjuM3akC7vr/TewNlxpGhWw42rCoPSZnByQlKFXE+PnJO7+a9z4DaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072277; c=relaxed/simple;
	bh=GkPLD3AoeXEEDQ877/auMW7WFaiUlLaToVcqvfG/InA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqFfbgEC620kEyFQLWwb5DqMCoH6rVFUfLKIJJRKEUUY8lqo3w5TBM2TzlSdAghuX0RwnFWse5FuQYieKU4JyEWp6rv0hYmGYo5GZFo1WdPFGg9D9kWlcB9tqH4trgff8B3KkRaRS37f3WLsv3Kw06uYCvkLOM1afFr32ACMlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqs0eO7x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lr8+zCAA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O+35zP+pAsAAP39kZSZHnq5eI8eEjgxMA8F0r7XiJo=;
	b=sqs0eO7xmxM7mDnPVLvtwrD7yvzj5CZh2Z3KfRmwc/A1uXXmZJDqYgezrsm2oaV1jaTTQG
	VrBIZCrLj11VhXwZh33WrDWl1fulmgykm5F/3PslHkeFOdKEuSxO+55pWGFTM9m30zoeWD
	Vq9b8UGm+mNTFjpghiITtrpHSGamLeeRgVQOD5S2Psnm5zRoc9KyNOBDayhTtVtU5PRY2r
	aRls5do+WRy/CT80WUPTxe9ZuAyfpXJe5CqX5mewl9qreevCDAIQ7fYXM6InVZyCEQXVqf
	G6cE3lU7xZWufWE7rdtdXyygR5UAHK1JwV/SvFZoq97kVLiW20XaPRwTzfLkjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O+35zP+pAsAAP39kZSZHnq5eI8eEjgxMA8F0r7XiJo=;
	b=Lr8+zCAAbr/QTW/W0oRj2Ye8ZyGRVFTcgDHx0YgYbwmwRnnM48kGZO4F2ukzWxTOUmrFH1
	WLQXU08PQEIEeBBQ==
Date: Tue, 04 Mar 2025 08:10:41 +0100
Subject: [PATCH 11/32] selftests: harness: Move teardown conditional into
 test metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-11-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=3443;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GkPLD3AoeXEEDQ877/auMW7WFaiUlLaToVcqvfG/InA=;
 b=ym68N7xv0dRCnQswxqJ012iHfoRxQemiZqps+hsiSsli7RY4xZ0s8g3PkzBgoo3AyQ2Jdjmel
 rhpTEzQbOHvD+IxQNIfP6ZxHXeJI+J0Q8Iw4/LOOZuEVZNqIfdbSx/D
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). To access the atomic teardown conditional from there,
move it into the test metadata.
This also allows the removal of "setup_completed".

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 0ea3778a3a85fda6bc363d2b2e1038679920d22b..2f067c0f47729d10f205774e58dfd85866bd4c96 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -417,9 +417,9 @@
 		pid_t child = 1; \
 		int status = 0; \
 		/* Makes sure there is only one teardown, even when child forks again. */ \
-		bool *teardown = mmap(NULL, sizeof(*teardown), \
+		_metadata->no_teardown = mmap(NULL, sizeof(*_metadata->no_teardown), \
 			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
-		*teardown = false; \
+		*_metadata->no_teardown = true; \
 		if (sizeof(*self) > 0) { \
 			if (fixture_name##_teardown_parent) { \
 				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
@@ -437,7 +437,7 @@
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
 					_exit(0); \
-				_metadata->setup_completed = true; \
+				*_metadata->no_teardown = false; \
 				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
@@ -445,15 +445,16 @@
 			} \
 		} \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
-					!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
+			if (!fixture_name##_teardown_parent && \
+					!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
 				fixture_name##_teardown(_metadata, self, variant->data); \
 			_exit(0); \
 		} \
-		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
-				!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
+		if (fixture_name##_teardown_parent && \
+				!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
 			fixture_name##_teardown(_metadata, self, variant->data); \
-		munmap(teardown, sizeof(*teardown)); \
+		munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
+		_metadata->no_teardown = NULL; \
 		if (self && fixture_name##_teardown_parent) \
 			munmap(self, sizeof(*self)); \
 		if (WIFEXITED(status)) { \
@@ -922,7 +923,7 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
-	bool setup_completed; /* did setup finish? */
+	bool *no_teardown; /* fixture needs teardown */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
@@ -1201,7 +1202,7 @@ static void __run_test(struct __fixture_metadata *f,
 	t->exit_code = KSFT_PASS;
 	t->trigger = 0;
 	t->aborted = false;
-	t->setup_completed = false;
+	t->no_teardown = NULL;
 	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 

-- 
2.48.1


