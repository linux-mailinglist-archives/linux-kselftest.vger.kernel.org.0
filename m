Return-Path: <linux-kselftest+bounces-13877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD708934C9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF501C21DB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5AD139D07;
	Thu, 18 Jul 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RSRn4G8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7C78C92;
	Thu, 18 Jul 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302369; cv=none; b=CHzXEOR22PZ2+T/g8DE2HeHMd8dmXdpN5h+yJPW5d62z+TQq6JbOjTmVD3TGZdXWhuRGgvRJX6jyV5/4B0qkNUVXElOiEcw8MpdDSAaz+G8GZsQIsi+tIDOYc+Tqm+zbF4xlDQ0uBYI/MrwbcDFElKq7vxOro4vYpHw0kGdCyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302369; c=relaxed/simple;
	bh=ws9BmbwUJ/UWpsGoGZ7xiDfbyUMuMQDt41ftYFWXmDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0gWAJw8TisNTW1v6syHrMu5P7ztbGA0opYqKUA7pusTjabwZZhlmhPzmcR70TzsLNqoN1ZwHgDsh2IZq0vQHHYQ4YAKuU/tUdvJKEpBKTAwensxJw5tTfimaaMC2OOxnTlQiyj1ErVwp6EKaW2N/JYypIM8keA/OrGl++xonbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RSRn4G8V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721302366;
	bh=ws9BmbwUJ/UWpsGoGZ7xiDfbyUMuMQDt41ftYFWXmDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSRn4G8VXfYISLSJYe5j7KUE5eIKqEjigvGm9Zn0PcY3E+9EJC74phZPI1reFvlPz
	 UtRpm0k33gqNN7VYF5Whyu5JmB0J2DdSiBYtv75UOqast0VBTimNo6F4rPBlGV46Dt
	 u+iFtTZUuRN9k0RIOfYr6gKWP77DhXDYxTjRrl1W6nEzeZhlg5KXIArDR+mLzIAmay
	 E7BXkZDGcypwnxzr3Q1b4WfLuQpah506muwZrZLIAjnC4LGWwNU95UWCuEz6KtrLZD
	 7nYBOVDV3wBUSl3NtF5dnJ5YY3FiawAcQxeKaPwgKbIuAgEw2fg8uGoXfn/VvLmkZ2
	 j5CNrG9U0Q/Ag==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBF1B378202D;
	Thu, 18 Jul 2024 11:32:42 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 2/4] selftests: x86: corrupt_xstate_header: remove manual counting and increase maintainability
Date: Thu, 18 Jul 2024 16:32:20 +0500
Message-Id: <20240718113222.867116-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718113222.867116-1-usama.anjum@collabora.com>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the skip, pass and fail return codes. Otherwise the test always
return 0. After the chaanges, correct number of stats about passed or
failed tests is being returned. Also print logs in standard format.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- correct description of the patch

Changes since v2:
- Update description of the patch and add before/after output

Before:
  # selftests: x86: corrupt_xstate_header_64
  # [RUN]	Send ourselves a signal
  # 	Wreck XSTATE header
  # 	Got SIGSEGV
  # [OK]	Back from the signal.  Now schedule.
  # [OK]	Back in the main thread.
  ok 41 selftests: x86: corrupt_xstate_header_64

After:
  # selftests: x86: corrupt_xstate_header_64
  # TAP version 13
  # 1..2
  # # Send ourselves a signal
  # # Wreck XSTATE header
  # # Got SIGSEGV
  # ok 1 Back from the signal. Now schedule.
  # ok 2 Back in the main thread.
  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
  ok 41 selftests: x86: corrupt_xstate_header_64
---
 .../selftests/x86/corrupt_xstate_header.c     | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index cf9ce8fbb656c..119ff74763c6d 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -39,7 +39,7 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 	sa.sa_flags = SA_SIGINFO | flags;
 	sigemptyset(&sa.sa_mask);
 	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
+		ksft_exit_fail_perror("sigaction");
 }
 
 static void sigusr1(int sig, siginfo_t *info, void *uc_void)
@@ -48,26 +48,29 @@ static void sigusr1(int sig, siginfo_t *info, void *uc_void)
 	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
 	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
 
-	printf("\tWreck XSTATE header\n");
+	ksft_print_msg("Wreck XSTATE header\n");
 	/* Wreck the first reserved bytes in the header */
 	*(xfeatures + 2) = 0xfffffff;
 }
 
 static void sigsegv(int sig, siginfo_t *info, void *uc_void)
 {
-	printf("\tGot SIGSEGV\n");
+	ksft_print_msg("Got SIGSEGV\n");
 }
 
 int main(void)
 {
 	cpu_set_t set;
 
+	ksft_print_header();
+	ksft_set_plan(2);
+
 	sethandler(SIGUSR1, sigusr1, 0);
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	if (!xsave_enabled()) {
-		printf("[SKIP] CR4.OSXSAVE disabled.\n");
-		return 0;
+		ksft_print_msg("CR4.OSXSAVE disabled.\n");
+		return KSFT_SKIP;
 	}
 
 	CPU_ZERO(&set);
@@ -79,18 +82,21 @@ int main(void)
 	 */
 	sched_setaffinity(getpid(), sizeof(set), &set);
 
-	printf("[RUN]\tSend ourselves a signal\n");
+	ksft_print_msg("Send ourselves a signal\n");
 	raise(SIGUSR1);
 
-	printf("[OK]\tBack from the signal.  Now schedule.\n");
+	ksft_test_result_pass("Back from the signal. Now schedule.\n");
+
 	pid_t child = fork();
-	if (child < 0)
-		err(1, "fork");
 	if (child == 0)
 		return 0;
-	if (child)
+
+	if (child < 0) {
+		ksft_test_result_fail("fork: %s\n", strerror(errno));
+	} else if (child) {
 		waitpid(child, NULL, 0);
-	printf("[OK]\tBack in the main thread.\n");
+		ksft_test_result_pass("Back in the main thread.\n");
+	}
 
 	/*
 	 * We could try to confirm that extended state is still preserved
@@ -98,5 +104,5 @@ int main(void)
 	 * a warning in the kernel logs.
 	 */
 
-	return 0;
+	ksft_finished();
 }
-- 
2.39.2


