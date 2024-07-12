Return-Path: <linux-kselftest+bounces-13657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C663C92F733
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B761F23240
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE411428F1;
	Fri, 12 Jul 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NGj2JXKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBD13C9A4;
	Fri, 12 Jul 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774047; cv=none; b=nFf0xbc18ZrZ8seGIkULhuaMtaj//vWIkdeWq4Kx5ohAXcqEviOUSrYLrPGLTSZBvrC1TtGQIXDgC3VT1+Q4ux0PxfO5Pc9x4H2OCYFzlOfbJSTbLbhMhdiWrOJuWo6lWuhB1PB60glwJtjnK//PBSNz6rKmGAV0OpiBdhyys1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774047; c=relaxed/simple;
	bh=3MDi7FHmO1ZC5BgTBljZuDhp6QNlf+5LjqAVlUaXsWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWj0LeGo3+QNBDDwg6slm30CbH/uJTh2m25x1n0cNhIjdgOGDgLLq4YJNvzlluKXsJ429A/XS9TYvHo5DGZZDHo4Uuj5dL8Wqml/6845Rw7DrFntMszRQd6lww/SESs1U3MJt0RWVNSWBYsAGh2hg5494k5wMmW++6aZd4uk/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NGj2JXKv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774043;
	bh=3MDi7FHmO1ZC5BgTBljZuDhp6QNlf+5LjqAVlUaXsWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGj2JXKvfBR7Fd9KyLP4JcOHtP4XwAkKTelQwJ6eayIDOTOsZ6SuMM3gAnDWhLPba
	 hufmoAUzDuWJAWydjDhvLDDMEKEJ0gQr8zm1VxZ82CYo2mGKMNVEDQLzW8uH6hmVNI
	 EnYI+CIdFYT9Xax2QB2IstlKbBd3j9Be0ivfUS5oMjcziPsWr6c22gbzR3L+s4DWtw
	 1jZK/TTpjLPBmlEIxHx+hZRlfFaQBB42wDHtxdcbHiktIh/pYDLw1/5tsyohaAnqPF
	 +m87TlClSQE+vas3UP84cdrwk1r0jRaRIyWv1wKOE4veTW+jxT8paRvxy5mbl3ivQF
	 pXDNGdsunfQ4w==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B90B33782212;
	Fri, 12 Jul 2024 08:47:20 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/4] selftests: x86: fsgsbase_restore: remove manual counting and increase maintainability
Date: Fri, 12 Jul 2024 13:46:24 +0500
Message-Id: <20240712084625.297249-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712084625.297249-1-usama.anjum@collabora.com>
References: <20240712084625.297249-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add test skip support instead of returning success at skip time for the
  kselftest script to understand correct exit status
- Print details about errno if error occurs
- Increase readability and maintainability
- Print logs in standard format

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 224058c1e4b2e..ef326c08d3508 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -30,6 +30,7 @@
 #include <sys/ptrace.h>
 #include <sys/wait.h>
 #include <stdint.h>
+#include "../kselftest.h"
 
 #define EXPECTED_VALUE 0x1337f00d
 
@@ -45,18 +46,18 @@
  */
 unsigned int dereference_seg_base(void);
 
-static void init_seg(void)
+static int init_seg(void)
 {
 	unsigned int *target = mmap(
 		NULL, sizeof(unsigned int),
 		PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
 	if (target == MAP_FAILED)
-		err(1, "mmap");
+		ksft_exit_fail_perror("mmap");
 
 	*target = EXPECTED_VALUE;
 
-	printf("\tsegment base address = 0x%lx\n", (unsigned long)target);
+	ksft_print_msg("segment base address = 0x%lx\n", (unsigned long)target);
 
 	struct user_desc desc = {
 		.entry_number    = 0,
@@ -70,7 +71,7 @@ static void init_seg(void)
 		.useable         = 0
 	};
 	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
-		printf("\tusing LDT slot 0\n");
+		ksft_print_msg("using LDT slot 0\n");
 		asm volatile ("mov %0, %" SEG :: "rm" ((unsigned short)0x7));
 	} else {
 		/* No modify_ldt for us (configured out, perhaps) */
@@ -96,14 +97,16 @@ static void init_seg(void)
 		munmap(low_desc, sizeof(desc));
 
 		if (ret != 0) {
-			printf("[NOTE]\tcould not create a segment -- can't test anything\n");
-			exit(0);
+			ksft_print_msg("could not create a segment -- can't test anything\n");
+			return KSFT_SKIP;
 		}
-		printf("\tusing GDT slot %d\n", desc.entry_number);
+		ksft_print_msg("using GDT slot %d\n", desc.entry_number);
 
 		unsigned short sel = (unsigned short)((desc.entry_number << 3) | 0x3);
 		asm volatile ("mov %0, %" SEG :: "rm" (sel));
 	}
+
+	return 0;
 }
 
 static void tracee_zap_segment(void)
@@ -114,7 +117,7 @@ static void tracee_zap_segment(void)
 	 * we modify a segment register in order to make sure that ptrace
 	 * can correctly restore segment registers.
 	 */
-	printf("\tTracee: in tracee_zap_segment()\n");
+	ksft_print_msg("Tracee: in tracee_zap_segment()\n");
 
 	/*
 	 * Write a nonzero selector with base zero to the segment register.
@@ -129,70 +132,72 @@ static void tracee_zap_segment(void)
 
 	pid_t pid = getpid(), tid = syscall(SYS_gettid);
 
-	printf("\tTracee is going back to sleep\n");
+	ksft_print_msg("Tracee is going back to sleep\n");
 	syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 	/* Should not get here. */
-	while (true) {
-		printf("[FAIL]\tTracee hit unreachable code\n");
-		pause();
-	}
+	ksft_exit_fail_msg("Tracee hit unreachable code\n");
 }
 
 int main()
 {
-	printf("\tSetting up a segment\n");
-	init_seg();
+	int ret;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	ksft_print_msg("Setting up a segment\n");
+
+	ret = init_seg();
+	if (ret)
+		return ret;
 
 	unsigned int val = dereference_seg_base();
-	if (val != EXPECTED_VALUE) {
-		printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
-		return 1;
-	}
-	printf("[OK]\tThe segment points to the right place.\n");
+	ksft_test_result(val == EXPECTED_VALUE, "The segment points to the right place.\n");
 
 	pid_t chld = fork();
 	if (chld < 0)
-		err(1, "fork");
+		ksft_exit_fail_perror("fork");
 
 	if (chld == 0) {
 		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0, 0);
 
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
-			err(1, "PTRACE_TRACEME");
+			ksft_exit_fail_perror("PTRACE_TRACEME");
 
 		pid_t pid = getpid(), tid = syscall(SYS_gettid);
 
-		printf("\tTracee will take a nap until signaled\n");
+		ksft_print_msg("Tracee will take a nap until signaled\n");
 		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
-		printf("\tTracee was resumed.  Will re-check segment.\n");
+		ksft_print_msg("Tracee was resumed. Will re-check segment.\n");
 
 		val = dereference_seg_base();
-		if (val != EXPECTED_VALUE) {
-			printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
-			exit(1);
+
+		if (val == EXPECTED_VALUE) {
+			ksft_print_msg("The segment points to the right place.\n");
+			return EXIT_SUCCESS;
 		}
 
-		printf("[OK]\tThe segment points to the right place.\n");
-		exit(0);
+		ksft_print_msg("seg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
+		return EXIT_FAILURE;
 	}
 
 	int status;
 
 	/* Wait for SIGSTOP. */
 	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
-		err(1, "waitpid");
+		ksft_exit_fail_perror("waitpid");
 
 	struct user_regs_struct regs;
 
 	if (ptrace(PTRACE_GETREGS, chld, NULL, &regs) != 0)
-		err(1, "PTRACE_GETREGS");
+		ksft_exit_fail_perror("PTRACE_GETREGS");
 
 #ifdef __x86_64__
-	printf("\tChild GS=0x%lx, GSBASE=0x%lx\n", (unsigned long)regs.gs, (unsigned long)regs.gs_base);
+	ksft_print_msg("Child GS=0x%lx, GSBASE=0x%lx\n", (unsigned long)regs.gs, (unsigned long)regs.gs_base);
 #else
-	printf("\tChild FS=0x%lx\n", (unsigned long)regs.xfs);
+	ksft_print_msg("Child FS=0x%lx\n", (unsigned long)regs.xfs);
 #endif
 
 	struct user_regs_struct regs2 = regs;
@@ -203,42 +208,34 @@ int main()
 	regs2.eip = (unsigned long)tracee_zap_segment;
 #endif
 
-	printf("\tTracer: redirecting tracee to tracee_zap_segment()\n");
+	ksft_print_msg("Tracer: redirecting tracee to tracee_zap_segment()\n");
 	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs2) != 0)
-		err(1, "PTRACE_GETREGS");
+		ksft_exit_fail_perror("PTRACE_GETREGS");
 	if (ptrace(PTRACE_CONT, chld, NULL, NULL) != 0)
-		err(1, "PTRACE_GETREGS");
+		ksft_exit_fail_perror("PTRACE_GETREGS");
 
 	/* Wait for SIGSTOP. */
 	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
-		err(1, "waitpid");
+		ksft_exit_fail_perror("waitpid");
 
-	printf("\tTracer: restoring tracee state\n");
+	ksft_print_msg("Tracer: restoring tracee state\n");
 	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs) != 0)
-		err(1, "PTRACE_GETREGS");
+		ksft_exit_fail_perror("PTRACE_GETREGS");
 	if (ptrace(PTRACE_DETACH, chld, NULL, NULL) != 0)
-		err(1, "PTRACE_GETREGS");
+		ksft_exit_fail_perror("PTRACE_GETREGS");
 
 	/* Wait for SIGSTOP. */
 	if (waitpid(chld, &status, 0) != chld)
-		err(1, "waitpid");
-
-	if (WIFSIGNALED(status)) {
-		printf("[FAIL]\tTracee crashed\n");
-		return 1;
-	}
-
-	if (!WIFEXITED(status)) {
-		printf("[FAIL]\tTracee stopped for an unexpected reason: %d\n", status);
-		return 1;
-	}
-
-	int exitcode = WEXITSTATUS(status);
-	if (exitcode != 0) {
-		printf("[FAIL]\tTracee reported failure\n");
-		return 1;
-	}
-
-	printf("[OK]\tAll is well.\n");
-	return 0;
+		ksft_exit_fail_perror("waitpid");
+
+	if (WIFSIGNALED(status))
+		ksft_test_result_fail("Tracee crashed\n");
+	else if (!WIFEXITED(status))
+		ksft_test_result_fail("Tracee stopped for an unexpected reason: %d\n", status);
+	else if (WEXITSTATUS(status) != 0)
+		ksft_test_result_fail("Tracee reported failure\n");
+	else
+		ksft_test_result_pass("Tracee exited correctly\n");
+
+	ksft_finished();
 }
-- 
2.39.2


