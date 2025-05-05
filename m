Return-Path: <linux-kselftest+bounces-32375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248BAA9727
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9683F7A8B8C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2D263F2C;
	Mon,  5 May 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZ8ftztd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qp7rGAAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B325E457;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458179; cv=none; b=S9ooJ0AKZkK907YZYB0n7OSgfhz3c0pmZXger8LvXeVIslXG07qsAwVrlbMeDzz045mcvzBbZGQzeNsKgl5W4R8TNnojSF70+mJo0zCoRXsma3tyT8rDRYKSAXYhDb56/aIZFigNdUcqAYyEe8aRejhZYpA6iBJe+I/ZtmOambM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458179; c=relaxed/simple;
	bh=Hzo5unfwpqoBkyl8kQlCKOzue+BWkvkpq74iyeq2U3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+OU6fikaH4lYC5k0O4R0P9wb0AXvmzLJAqze02FKz7rB9RcY2XFNpWAiKN1fRgn7lXZK3ccnJ0ckH0J6o3hJkrlGv6yy80ttp2E0EXBDHyIE67sp0UmJNVIzBd2NNxzINpIFBnKAwz/I/f8BnbZ+PqT6zIbZjxidHOAjphduRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZ8ftztd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qp7rGAAi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3U47u23p2Sw0B63287BdveipGhvw9w+TsOh+jWbam4=;
	b=CZ8ftztdVCxSewDt7MJpQKvYimjKFL5Lt8hoYkFM2/fs3wUZRT7yBVMT7LSD8mob2ISYY6
	YGPvXe0RncC2RuKBkYbLGbjVg3UwiYdkt6xXoUlt0CVuT2k5r3cDhYqaKtbGd6n3DQTPnj
	rszB1NklNp0haq6Bwb5umdjOR5gqZoMGY06sgk13g4nlFT1ttjNRdRpHiL5EkQlLbCqOqm
	CQJfDpQql9yaeAnjCJjtf3b7vhbAP2KPngIDDEZ4CP+485RXtqxLtZ6FI0yG7kjOkvxjPe
	TqrbvQZODQDpGeuZjGu54FKZJHr+HY4Nc6/cU9MdYhTSFf+GnPx756gvSyAYUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3U47u23p2Sw0B63287BdveipGhvw9w+TsOh+jWbam4=;
	b=qp7rGAAiktlPE+sb5tZCwCR4UmudtyopDm3yfprfgSn0u28SUqPSJpy962DqXWJpqKdng7
	cVqZXAC4SpuRx0Dw==
Date: Mon, 05 May 2025 17:15:25 +0200
Subject: [PATCH v4 07/14] selftests: harness: Implement test timeouts
 through pidfd
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-7-ee4dd5257135@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=4131;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Hzo5unfwpqoBkyl8kQlCKOzue+BWkvkpq74iyeq2U3U=;
 b=kr60gWheJCInFJTh5O3krcBVoCxd7MTi81fZuBrApXanFqGLmXsMfhNRIcgx4itqejg87CWiR
 jwU80qHAn0gCvMIy4i03z6aTLCttgIdXwmFYmApaGKYno639EKl+OJD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make the kselftest harness compatible with nolibc which does not implement
signals by replacing the signal logic with pidfds.
The code also becomes simpler.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 72 ++++++++++-------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 7ec4f66d0e3d7f129f6c2a45ff58310dabe5d03f..1e459619fe8657d7d213a7b16d7bcbc58e76e892 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,8 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <linux/unistd.h>
+#include <poll.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -914,7 +916,6 @@ struct __test_metadata {
 	int exit_code;
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
-	bool timed_out;	/* did this test timeout instead of exiting? */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
 	jmp_buf env;	/* for exiting out of test early */
@@ -964,75 +965,52 @@ static inline void __test_check_assert(struct __test_metadata *t)
 		abort();
 }
 
-struct __test_metadata *__active_test;
-static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
-{
-	struct __test_metadata *t = __active_test;
-
-	/* Sanity check handler execution environment. */
-	if (!t) {
-		fprintf(TH_LOG_STREAM,
-			"# no active test in SIGALRM handler!?\n");
-		abort();
-	}
-	if (sig != SIGALRM || sig != info->si_signo) {
-		fprintf(TH_LOG_STREAM,
-			"# %s: SIGALRM handler caught signal %d!?\n",
-			t->name, sig != SIGALRM ? sig : info->si_signo);
-		abort();
-	}
-
-	t->timed_out = true;
-	/* signal process group */
-	kill(-(t->pid), SIGKILL);
-}
-
 static void __wait_for_test(struct __test_metadata *t)
 {
-	struct sigaction action = {
-		.sa_sigaction = __timeout_handler,
-		.sa_flags = SA_SIGINFO,
-	};
-	struct sigaction saved_action;
 	/*
 	 * Sets status so that WIFEXITED(status) returns true and
 	 * WEXITSTATUS(status) returns KSFT_FAIL.  This safe default value
 	 * should never be evaluated because of the waitpid(2) check and
-	 * SIGALRM handling.
+	 * timeout handling.
 	 */
 	int status = KSFT_FAIL << 8;
-	int child;
+	struct pollfd poll_child;
+	int ret, child, childfd;
+	bool timed_out = false;
 
-	if (sigaction(SIGALRM, &action, &saved_action)) {
+	childfd = syscall(__NR_pidfd_open, t->pid, 0);
+	if (childfd == -1) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
-			"# %s: unable to install SIGALRM handler\n",
+			"# %s: unable to open pidfd\n",
 			t->name);
 		return;
 	}
-	__active_test = t;
-	t->timed_out = false;
-	alarm(t->timeout);
-	child = waitpid(t->pid, &status, 0);
-	if (child == -1 && errno != EINTR) {
+
+	poll_child.fd = childfd;
+	poll_child.events = POLLIN;
+	ret = poll(&poll_child, 1, t->timeout * 1000);
+	if (ret == -1) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
-			"# %s: Failed to wait for PID %d (errno: %d)\n",
-			t->name, t->pid, errno);
+			"# %s: unable to wait on child pidfd\n",
+			t->name);
 		return;
+	} else if (ret == 0) {
+		timed_out = true;
+		/* signal process group */
+		kill(-(t->pid), SIGKILL);
 	}
-
-	alarm(0);
-	if (sigaction(SIGALRM, &saved_action, NULL)) {
+	child = waitpid(t->pid, &status, WNOHANG);
+	if (child == -1 && errno != EINTR) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
-			"# %s: unable to uninstall SIGALRM handler\n",
-			t->name);
+			"# %s: Failed to wait for PID %d (errno: %d)\n",
+			t->name, t->pid, errno);
 		return;
 	}
-	__active_test = NULL;
 
-	if (t->timed_out) {
+	if (timed_out) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);

-- 
2.49.0


