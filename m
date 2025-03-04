Return-Path: <linux-kselftest+bounces-28156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66916A4D45C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF21172EA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF071FA14B;
	Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEdOQDka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYPO9Crf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74C1F5853;
	Tue,  4 Mar 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072276; cv=none; b=seXWIlQskwTR7xvdjC4giLf/ihT6bHTrJBEGYQhdh2coIQUnVrrq4Mu7nFWo67xRGC6y9Jtlxyrb8pta2X3PgEv+Y8n2Thj4XoaRbOiVgl4f4wUSNEoE8HJSTCIGhvSm7vzwW/IQyAmqAkrsa/+ysX9fhZb0ulKfTc9soZyLm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072276; c=relaxed/simple;
	bh=LoHEuTmyCWfppdxzkuks0aIW+fGsuAaTBTLeqSXo1HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iimq7f6NCUSHMAXjL1P1ApXJS6u6SVaFeOG9KLtwhgdsJLe932Yo/PR/q54PqQ5kqMlFoXvrtgS0Apx6Ko2/NdFvHpzB05HZ0RVpF5c1IMCs5os41MGYucH4sUYVSSxl/e9kysCp5KFOVZYIJNNEr/hKKZy7Ps4pWdDHV4dsWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEdOQDka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYPO9Crf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JoiIctFus6hhdRs7mtzErie5kNL1JBaIkwvaX5ucM=;
	b=JEdOQDka31P3RBSjD94xWJMLqIhOyUbuzcmjL2qLo3d1beF4cbW8ggc4iChzn8tW6i1v6q
	Kmxia1DhoDEGw7pEIIY0XCgXMhiv9ExGbafVmNDgMZ45ZmL2lebLlzM3Htjebg5+GmciYK
	fXqJsY1+E4oCx9OS4czDHN8LhElhUDa4dz74FFVz0pIpTWIqvUq3n0U+Y34zP9n6KFUhjZ
	sshxfv07Qtub5a7k8CivmVZSF/cbBaMTRyxC2bbU5DETKQmAjU8bsma8GWwfggg0gZjig0
	w2tSRrAaFS56mgto78sucfHej4hd8L/p/j30bNGlOrd5Kt02R8Gk6gsibosZbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JoiIctFus6hhdRs7mtzErie5kNL1JBaIkwvaX5ucM=;
	b=QYPO9CrfXNReqXBf6IPla0tRqU7EKzJxj2rYcqkdRxx7q+wGcWecHJydm1AMkDgrXA013Q
	zz0dXpaVWDnaXqCQ==
Date: Tue, 04 Mar 2025 08:10:38 +0100
Subject: [PATCH 08/32] selftests: harness: Implement test timeouts through
 pidfd
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-8-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=4078;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LoHEuTmyCWfppdxzkuks0aIW+fGsuAaTBTLeqSXo1HM=;
 b=aqVq/wFtfuw2Kgvlc9EYJp8nHDm96QSb2Ma/6rIu5p8LZdiT/9JfGAjHKaZmVKGoGY+exEvq8
 V1L3AxUmVkVC+ASD1Vim1X6ARVyaAIrCrdivFU27JEF2VaNPA0G2SKd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make the harness compatible with nolibc which does not implement signals
by replacing the signal logic with pidfds.
The code also becomes simpler.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 72 ++++++++++-------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index bf5ffc594a4a864d2e8bb6f47c29fa56d58919d9..d265b45c86d03c6f854047138ee8dc19dcc7a4d9 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -65,6 +65,8 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <linux/unistd.h>
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -918,7 +920,6 @@ struct __test_metadata {
 	int exit_code;
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
-	bool timed_out;	/* did this test timeout instead of exiting? */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
 	jmp_buf env;	/* for exiting out of test early */
@@ -968,75 +969,52 @@ static inline void __test_check_assert(struct __test_metadata *t)
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
2.48.1


