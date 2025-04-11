Return-Path: <linux-kselftest+bounces-30547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA571A85744
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43154A199E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D529B20D;
	Fri, 11 Apr 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y7jwhrgb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hOREmIdm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991A298CC9;
	Fri, 11 Apr 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362114; cv=none; b=C169FWhR4dAt+1R7GCIwC4blqPuMhhEI1/kVnHdh5gaQtwVl+YJ1CSiufgrT9z4JVvEeUL/ssqYWzkUiQvTaIN4xfk3hT2UxfyWurk3vQGvCMvQ7nfCYJnymXrvkSM9yJJ+1Jc/cUTVITIbavz+fjik1azItEAiGH3dOy7ZDuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362114; c=relaxed/simple;
	bh=xsOgqpVF3xELBsCaLrwDdUg/BIkBndVgq3S6YVEJtrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwxNrFauv8kzur9qTJdwxsGmM0Ri3Zbt5pKvBlOmX8ZZGkOFKU26oM2nwYZNFwlHRYErChV0irOG3geBS03EC1e/QjvNaF2pP20JEAE5MepsgSCMXboZ7oejQqcmVQ9LrROw8rtd86NqwQc/4iYvrEFAZRRazHw7YVGtJ3GyJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y7jwhrgb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hOREmIdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2m1ytKmJLv4W19Ree/8QxaUIOzVWzU9VNFHgbO9ms8=;
	b=y7jwhrgbMelEC9ZAWQSRGCxc6Aye+zeJMDTmyshDbVvVvOyzhAMeKghhhDGplO0Zzmn9u6
	DFulllaJpDPfXRiwlaxnRoldZgHczddx8o6K3bUHBl+6gZQ20/1DQf7Jno2D0Zwk8k016Q
	uvJDdcrx76Vmk2gY6gvXiDj+ecAtIkRe493/+7mHkveT9FUiTKt3ug5VHlS0qEuuK0nyhl
	Uot5MwKk1SBdt/0zK9fyUhQoi3OR/8PmtSRQu7ZbfuezlKxiZjFh0r5sv8T8y5XN5dMjIr
	UD4iul7Yq2J1y5ZrcCfM4WT6xpfeqxnfh/3SFC8UQkaNEajZiB0jsI06aOmhnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2m1ytKmJLv4W19Ree/8QxaUIOzVWzU9VNFHgbO9ms8=;
	b=hOREmIdmqzYtIE7QfqDK064qmxLhY2XAI5w32R2m/14/DOUdJi9vpQFog3nz/3jpzbIWPG
	PzXwUS/RWr78dACQ==
Date: Fri, 11 Apr 2025 11:00:34 +0200
Subject: [PATCH v3 10/32] selftests: harness: Move teardown conditional
 into test metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-10-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=3443;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xsOgqpVF3xELBsCaLrwDdUg/BIkBndVgq3S6YVEJtrg=;
 b=RCV1A/6H22+aWPhnRQS0yuQAG3k/krkwY0b7LizfUqsOQnnqX21OReqJP50Dff7c5lnxW9xw+
 LQMTODnQzmmCR4+N56ilySXWe2kxmuaC2w0dUOi4OjsD6ZAZGde290k
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
index 4038ceeb42a870a2b77c6888df8a7bb4c4a258ba..790445c541aa3875d8d42822ab979295cc869d39 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -413,9 +413,9 @@
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
@@ -433,7 +433,7 @@
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
 					_exit(0); \
-				_metadata->setup_completed = true; \
+				*_metadata->no_teardown = false; \
 				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
@@ -441,15 +441,16 @@
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
@@ -918,7 +919,7 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
-	bool setup_completed; /* did setup finish? */
+	bool *no_teardown; /* fixture needs teardown */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
@@ -1197,7 +1198,7 @@ static void __run_test(struct __fixture_metadata *f,
 	t->exit_code = KSFT_PASS;
 	t->trigger = 0;
 	t->aborted = false;
-	t->setup_completed = false;
+	t->no_teardown = NULL;
 	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 

-- 
2.49.0


