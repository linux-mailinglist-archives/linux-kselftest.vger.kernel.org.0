Return-Path: <linux-kselftest+bounces-3838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0F844149
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BC11F26F1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64683CD0;
	Wed, 31 Jan 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZrDnzEY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814083CC3;
	Wed, 31 Jan 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709931; cv=none; b=HBCrxsymG7DdWkd4AAwM2F2g8sfc4tgJjAri+jGLqay3krbeVMJW81wThYkuW6ACzhvZxZ9YMTT0vRLIm9jfI9o5Czok8fzCSIQBshxKDVJZbZtjiMYOLxOpd2wPqJOKykEmJIusXnrKHhI2E5XTjffNlkD+RmC5NSDT+JKLBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709931; c=relaxed/simple;
	bh=CPJegAn2jct8qTIbcEKKHIZ5byMY8HScpq2uBuAZ1YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFi+24ZAVDDCQMLNxj2t1RhNSr1H2MZSlLJB4KNqlKkjcaCKmt+5Iss3nKyIkTbxesBRtZVoDkdTcugfas4RVPayu0WR7NUD4tCt74RHFFq5z1eixbf2sO4TD01d3im19XLQkLmjZbwlmB5GII0oFi6q+M1g6sEuowOvxcQgPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZrDnzEY3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709928;
	bh=CPJegAn2jct8qTIbcEKKHIZ5byMY8HScpq2uBuAZ1YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrDnzEY3rzWcjZkSa3uAcAd9BGqFqhU2OHdHPsNsJbhysLzQzaE7YLsDLyB+7FYWS
	 Xoz0pswOQGcJE1Tau57YwdpSq1a439eI86rf3V8kch+DhoDmPAo0LJBkuDSea0mUWW
	 I8fh0ntBg97aZHyjSrQwYDpBhAWHVhczZ95HPMiN+wnTDusYfdWvfQxuyD24FpKu7/
	 pua8hdFYFKUxHkTDIOaYvVQEacnCKixrqEjVsachpClsphQqL2h33y0g8tFupsmc6N
	 8Ih09s0cBS4PokvOsM6QONYqIWL0bU6pzbZrGsIO5FiXA5t8Y11VY33C/dUw8P5ccK
	 Js/k2cnu2zqdw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A0B44378200E;
	Wed, 31 Jan 2024 14:05:26 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] selftests/mm: mrelease_test: conform test to TAP format output
Date: Wed, 31 Jan 2024 19:05:16 +0500
Message-ID: <20240131140528.320252-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131140528.320252-1-usama.anjum@collabora.com>
References: <20240131140528.320252-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mrelease_test.c | 80 +++++++++-------------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index d822004a374e9..100370a7111df 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -26,19 +26,15 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
 
 	buf = (char *)mmap(NULL, nr_pages * psize(), PROT_READ | PROT_WRITE,
 			   MAP_PRIVATE | MAP_ANON, 0, 0);
-	if (buf == MAP_FAILED) {
-		perror("mmap failed, halting the test");
-		return KSFT_FAIL;
-	}
+	if (buf == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed, halting the test: %s\n", strerror(errno));
 
 	for (i = 0; i < nr_pages; i++)
 		*((unsigned long *)(buf + (i * psize()))) = i;
 
 	/* Signal the parent that the child is ready */
-	if (write(pipefd, "", 1) < 0) {
-		perror("write");
-		return KSFT_FAIL;
-	}
+	if (write(pipefd, "", 1) < 0)
+		ksft_exit_fail_msg("write: %s\n", strerror(errno));
 
 	/* Wait to be killed (when reparenting happens) */
 	while (getppid() == ppid && timeout > 0) {
@@ -54,23 +50,17 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
 /* The process_mrelease calls in this test are expected to fail */
 static void run_negative_tests(int pidfd)
 {
-	int res;
 	/* Test invalid flags. Expect to fail with EINVAL error code. */
 	if (!syscall(__NR_process_mrelease, pidfd, (unsigned int)-1) ||
 			errno != EINVAL) {
-		res = (errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
-		perror("process_mrelease with wrong flags");
-		exit(res);
+		ksft_exit_fail_msg("process_mrelease with wrong flags: %s\n", strerror(errno));
 	}
 	/*
 	 * Test reaping while process is alive with no pending SIGKILL.
 	 * Expect to fail with EINVAL error code.
 	 */
-	if (!syscall(__NR_process_mrelease, pidfd, 0) || errno != EINVAL) {
-		res = (errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
-		perror("process_mrelease on a live process");
-		exit(res);
-	}
+	if (!syscall(__NR_process_mrelease, pidfd, 0) || errno != EINVAL)
+		ksft_exit_fail_msg("process_mrelease on a live process: %s\n", strerror(errno));
 }
 
 static int child_main(int pipefd[], size_t size)
@@ -93,11 +83,18 @@ int main(void)
 	char byte;
 	int res;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	/* Test a wrong pidfd */
 	if (!syscall(__NR_process_mrelease, -1, 0) || errno != EBADF) {
-		res = (errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
-		perror("process_mrelease with wrong pidfd");
-		exit(res);
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("process_mrelease not implemented\n");
+			ksft_finished();
+		} else {
+			ksft_exit_fail_msg("process_mrelease with wrong pidfd: %s",
+					   strerror(errno));
+		}
 	}
 
 	/* Start the test with 1MB child memory allocation */
@@ -107,16 +104,14 @@ int main(void)
 	 * Pipe for the child to signal when it's done allocating
 	 * memory
 	 */
-	if (pipe(pipefd)) {
-		perror("pipe");
-		exit(KSFT_FAIL);
-	}
+	if (pipe(pipefd))
+		ksft_exit_fail_msg("pipe: %s\n", strerror(errno));
+
 	pid = fork();
 	if (pid < 0) {
-		perror("fork");
 		close(pipefd[0]);
 		close(pipefd[1]);
-		exit(KSFT_FAIL);
+		ksft_exit_fail_msg("fork: %s\n", strerror(errno));
 	}
 
 	if (pid == 0) {
@@ -134,28 +129,23 @@ int main(void)
 	res = read(pipefd[0], &byte, 1);
 	close(pipefd[0]);
 	if (res < 0) {
-		perror("read");
 		if (!kill(pid, SIGKILL))
 			waitpid(pid, NULL, 0);
-		exit(KSFT_FAIL);
+		ksft_exit_fail_msg("read: %s\n", strerror(errno));
 	}
 
 	pidfd = syscall(__NR_pidfd_open, pid, 0);
 	if (pidfd < 0) {
-		perror("pidfd_open");
 		if (!kill(pid, SIGKILL))
 			waitpid(pid, NULL, 0);
-		exit(KSFT_FAIL);
+		ksft_exit_fail_msg("pidfd_open: %s\n", strerror(errno));
 	}
 
 	/* Run negative tests which require a live child */
 	run_negative_tests(pidfd);
 
-	if (kill(pid, SIGKILL)) {
-		res = (errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
-		perror("kill");
-		exit(res);
-	}
+	if (kill(pid, SIGKILL))
+		ksft_exit_fail_msg("kill: %s\n", strerror(errno));
 
 	success = (syscall(__NR_process_mrelease, pidfd, 0) == 0);
 	if (!success) {
@@ -169,18 +159,15 @@ int main(void)
 		if (errno == ESRCH) {
 			retry = (size <= MAX_SIZE_MB);
 		} else {
-			res = (errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
-			perror("process_mrelease");
 			waitpid(pid, NULL, 0);
-			exit(res);
+			ksft_exit_fail_msg("process_mrelease: %s\n", strerror(errno));
 		}
 	}
 
 	/* Cleanup to prevent zombies */
-	if (waitpid(pid, NULL, 0) < 0) {
-		perror("waitpid");
-		exit(KSFT_FAIL);
-	}
+	if (waitpid(pid, NULL, 0) < 0)
+		ksft_exit_fail_msg("waitpid: %s\n", strerror(errno));
+
 	close(pidfd);
 
 	if (!success) {
@@ -188,11 +175,10 @@ int main(void)
 			size *= 2;
 			goto retry;
 		}
-		printf("All process_mrelease attempts failed!\n");
-		exit(KSFT_FAIL);
+		ksft_exit_fail_msg("All process_mrelease attempts failed!\n");
 	}
 
-	printf("Success reaping a child with %zuMB of memory allocations\n",
-	       size);
-	return KSFT_PASS;
+	ksft_test_result_pass("Success reaping a child with %zuMB of memory allocations\n",
+			      size);
+	ksft_finished();
 }
-- 
2.42.0


