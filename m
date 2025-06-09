Return-Path: <linux-kselftest+bounces-34476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD7FAD1EE7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B551615F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB412459F2;
	Mon,  9 Jun 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlSY2SGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F8D528;
	Mon,  9 Jun 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475943; cv=none; b=WgcERqcsqCTEc7E6bW4MOpXbpa8ESAyA4pGnysI9MfN8zNZkngtC1BSjQvYIXJ8zud2Wj7XjVdzRA7xX6vXPf+j3KrDr0jl0AxziU38UsgSqonrd7TaXuye03HvwWdMAB60Eb62n4clrRusQ2asciv3qcWaKHYQf4uz+5v/eU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475943; c=relaxed/simple;
	bh=saOkQ/3rx6ZFGPKCS6zsEVobhtu/zh8QlGy2Xu55YeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fk76P/R/z4MSy+iIa9xaSPCNSQAQfcY67a4nAKpJ+fU3EY0F6QnMGbI2biRbFAMxba2wTY0bzkfrOk6p7IoyevIyhtVSMfeF3EnY1bGjnLr/5Msl/8nyquFp/8QKEXfCjTkAAyv410zpHnG4RqSTppu4p9S+USbbMW9zx3r4vxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlSY2SGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3DCC4CEEB;
	Mon,  9 Jun 2025 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475942;
	bh=saOkQ/3rx6ZFGPKCS6zsEVobhtu/zh8QlGy2Xu55YeA=;
	h=From:Date:Subject:To:Cc:From;
	b=OlSY2SGrvEgdjETHVplkoK82hdbxeZt2Z0qtL3sZhblJ4lD97mWgjVH5RTzhB3nfm
	 wWXUwXqGdxh2wNOZ/dTbTRDRRuAfVFIeolAc8Nf8HEQsSYGS73a/i+vRjh8u99YiyX
	 hAmc4jO7Uv6hwbdHRXhvAS3mrn1JGbf4xut8TwnWTCem3aw6Iz4+d+ux7vTMwd9Rml
	 UWyZCIrv8WVdce7KcSq10JpmBa4vkStzFupPr9JeEZ0/aDmTH6re4YBlDQRzJ+Ywe3
	 U9GoCxG+ZbsKzV1uaViQOLreIR33CH12Hs45NyHR7EBUdEka9DyV65YmTT/qhXsLaY
	 x5DDBUybnSeng==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 14:29:10 +0100
Subject: [PATCH] kselftest/arm64: Convert tpidr2 test to use kselftest.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-kselftest-arm64-nolibc-header-v1-1-16ee1c6fbfed@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKXhRmgC/x3MQQqDMBAF0KvIrDuQhsRAr1K6iPpTh9pYZkQK4
 t0bunybd5BBBUa37iDFLiZrbbheOhrnXJ9gmZrJOx9d9IlfhqVssI2zvvvAdV1kGHlGnqA89NH
 lEFNJJVA7Pooi3/9/f5znD5iyh2FvAAAA
X-Change-ID: 20250527-kselftest-arm64-nolibc-header-b650a457f7f4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=saOkQ/3rx6ZFGPKCS6zsEVobhtu/zh8QlGy2Xu55YeA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRuJk/IFe0UeZ4Zbvl0mqp/8nsgL1KSj9e2Sgwl8n
 fx0n/iiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEbiZAAKCRAk1otyXVSH0IbGB/
 9f/99sdxXDh6Em94zAfg8m8nqAB9JvEEp0nbL1+GpwGjwCZdy9uRfyKC2lMNobWUlSlRtD1vknZo71
 NmizF1vO0kfQz6mb+PUW2B/JHZhbmbjqjrfVUdrykSCiul2etMf3zsIUVTcYHkDVaAeIPVGtaIDQi1
 e9ZsqwL8FJdsIFLWlnVb+Ny4oCck+QlBFf46ohMBH2NXkJ3o0Gd+4OHGpY2B4686DOZ0xb6b/oiz+X
 5cxIH1wxRjcFywUzPqe05TyAin1DGqzskRpUb1sLz8nePn2uTDr/IHKJniFZkFSu66JL4HMcJ+YI2z
 zvD0jqrZt0xXwsWaenN6mmqY+Lezm6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Recent work by Thomas Weißschuh means that it is now possible to use
kselftest.h with nolibc. Convert the tpidr2 test which is nolibc specific
to use kselftest.h, making it look more standard and ensuring it gets the
benefit of any work done on kselftest.h.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/Makefile |   2 +-
 tools/testing/selftests/arm64/abi/tpidr2.c | 140 ++++++++---------------------
 2 files changed, 38 insertions(+), 104 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
index a6d30c620908..483488f8c2ad 100644
--- a/tools/testing/selftests/arm64/abi/Makefile
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -12,4 +12,4 @@ $(OUTPUT)/syscall-abi: syscall-abi.c syscall-abi-asm.S
 $(OUTPUT)/tpidr2: tpidr2.c
 	$(CC) -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
 		-static -include ../../../../include/nolibc/nolibc.h \
-		-ffreestanding -Wall $^ -o $@ -lgcc
+		-I../.. -ffreestanding -Wall $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index eb19dcc37a75..f58a9f89b952 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -3,31 +3,12 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 
+#include "kselftest.h"
+
 #define SYS_TPIDR2 "S3_3_C13_C0_5"
 
 #define EXPECTED_TESTS 5
 
-static void putstr(const char *str)
-{
-	write(1, str, strlen(str));
-}
-
-static void putnum(unsigned int num)
-{
-	char c;
-
-	if (num / 10)
-		putnum(num / 10);
-
-	c = '0' + (num % 10);
-	write(1, &c, 1);
-}
-
-static int tests_run;
-static int tests_passed;
-static int tests_failed;
-static int tests_skipped;
-
 static void set_tpidr2(uint64_t val)
 {
 	asm volatile (
@@ -50,20 +31,6 @@ static uint64_t get_tpidr2(void)
 	return val;
 }
 
-static void print_summary(void)
-{
-	if (tests_passed + tests_failed + tests_skipped != EXPECTED_TESTS)
-		putstr("# UNEXPECTED TEST COUNT: ");
-
-	putstr("# Totals: pass:");
-	putnum(tests_passed);
-	putstr(" fail:");
-	putnum(tests_failed);
-	putstr(" xfail:0 xpass:0 skip:");
-	putnum(tests_skipped);
-	putstr(" error:0\n");
-}
-
 /* Processes should start with TPIDR2 == 0 */
 static int default_value(void)
 {
@@ -105,9 +72,8 @@ static int write_fork_read(void)
 	if (newpid == 0) {
 		/* In child */
 		if (get_tpidr2() != oldpid) {
-			putstr("# TPIDR2 changed in child: ");
-			putnum(get_tpidr2());
-			putstr("\n");
+			ksft_print_msg("TPIDR2 changed in child: %llx\n",
+				       get_tpidr2());
 			exit(0);
 		}
 
@@ -115,14 +81,12 @@ static int write_fork_read(void)
 		if (get_tpidr2() == getpid()) {
 			exit(1);
 		} else {
-			putstr("# Failed to set TPIDR2 in child\n");
+			ksft_print_msg("Failed to set TPIDR2 in child\n");
 			exit(0);
 		}
 	}
 	if (newpid < 0) {
-		putstr("# fork() failed: -");
-		putnum(-newpid);
-		putstr("\n");
+		ksft_print_msg("fork() failed: %d\n", newpid);
 		return 0;
 	}
 
@@ -132,23 +96,22 @@ static int write_fork_read(void)
 		if (waiting < 0) {
 			if (errno == EINTR)
 				continue;
-			putstr("# waitpid() failed: ");
-			putnum(errno);
-			putstr("\n");
+			ksft_print_msg("waitpid() failed: %d\n", errno);
 			return 0;
 		}
 		if (waiting != newpid) {
-			putstr("# waitpid() returned wrong PID\n");
+			ksft_print_msg("waitpid() returned wrong PID: %d != %d\n",
+				       waiting, newpid);
 			return 0;
 		}
 
 		if (!WIFEXITED(status)) {
-			putstr("# child did not exit\n");
+			ksft_print_msg("child did not exit\n");
 			return 0;
 		}
 
 		if (getpid() != get_tpidr2()) {
-			putstr("# TPIDR2 corrupted in parent\n");
+			ksft_print_msg("TPIDR2 corrupted in parent\n");
 			return 0;
 		}
 
@@ -188,35 +151,32 @@ static int write_clone_read(void)
 
 	stack = malloc(__STACK_SIZE);
 	if (!stack) {
-		putstr("# malloc() failed\n");
+		ksft_print_msg("malloc() failed\n");
 		return 0;
 	}
 
 	ret = sys_clone(CLONE_VM, (unsigned long)stack + __STACK_SIZE,
 			&parent_tid, 0, &child_tid);
 	if (ret == -1) {
-		putstr("# clone() failed\n");
-		putnum(errno);
-		putstr("\n");
+		ksft_print_msg("clone() failed: %d\n", errno);
 		return 0;
 	}
 
 	if (ret == 0) {
 		/* In child */
 		if (get_tpidr2() != 0) {
-			putstr("# TPIDR2 non-zero in child: ");
-			putnum(get_tpidr2());
-			putstr("\n");
+			ksft_print_msg("TPIDR2 non-zero in child: %llx\n",
+				       get_tpidr2());
 			exit(0);
 		}
 
 		if (gettid() == 0)
-			putstr("# Child TID==0\n");
+			ksft_print_msg("Child TID==0\n");
 		set_tpidr2(gettid());
 		if (get_tpidr2() == gettid()) {
 			exit(1);
 		} else {
-			putstr("# Failed to set TPIDR2 in child\n");
+			ksft_print_msg("Failed to set TPIDR2 in child\n");
 			exit(0);
 		}
 	}
@@ -227,25 +187,22 @@ static int write_clone_read(void)
 		if (waiting < 0) {
 			if (errno == EINTR)
 				continue;
-			putstr("# wait4() failed: ");
-			putnum(errno);
-			putstr("\n");
+			ksft_print_msg("wait4() failed: %d\n", errno);
 			return 0;
 		}
 		if (waiting != ret) {
-			putstr("# wait4() returned wrong PID ");
-			putnum(waiting);
-			putstr("\n");
+			ksft_print_msg("wait4() returned wrong PID %d\n",
+				       waiting);
 			return 0;
 		}
 
 		if (!WIFEXITED(status)) {
-			putstr("# child did not exit\n");
+			ksft_print_msg("child did not exit\n");
 			return 0;
 		}
 
 		if (parent != get_tpidr2()) {
-			putstr("# TPIDR2 corrupted in parent\n");
+			ksft_print_msg("TPIDR2 corrupted in parent\n");
 			return 0;
 		}
 
@@ -253,35 +210,14 @@ static int write_clone_read(void)
 	}
 }
 
-#define run_test(name)			     \
-	if (name()) {			     \
-		tests_passed++;		     \
-	} else {			     \
-		tests_failed++;		     \
-		putstr("not ");		     \
-	}				     \
-	putstr("ok ");			     \
-	putnum(++tests_run);		     \
-	putstr(" " #name "\n");
-
-#define skip_test(name)			     \
-	tests_skipped++;		     \
-	putstr("ok ");			     \
-	putnum(++tests_run);		     \
-	putstr(" # SKIP " #name "\n");
-
 int main(int argc, char **argv)
 {
 	int ret;
 
-	putstr("TAP version 13\n");
-	putstr("1..");
-	putnum(EXPECTED_TESTS);
-	putstr("\n");
+	ksft_print_header();
+	ksft_set_plan(5);
 
-	putstr("# PID: ");
-	putnum(getpid());
-	putstr("\n");
+	ksft_print_msg("PID: %d\n", getpid());
 
 	/*
 	 * This test is run with nolibc which doesn't support hwcap and
@@ -290,23 +226,21 @@ int main(int argc, char **argv)
 	 */
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
-		run_test(default_value);
-		run_test(write_read);
-		run_test(write_sleep_read);
-		run_test(write_fork_read);
-		run_test(write_clone_read);
+		ksft_test_result(default_value(), "default_value\n");
+		ksft_test_result(write_read, "write_read\n");
+		ksft_test_result(write_sleep_read, "write_sleep_read\n");
+		ksft_test_result(write_fork_read, "write_fork_read\n");
+		ksft_test_result(write_clone_read, "write_clone_read\n");
 
 	} else {
-		putstr("# SME support not present\n");
+		ksft_print_msg("SME support not present\n");
 
-		skip_test(default_value);
-		skip_test(write_read);
-		skip_test(write_sleep_read);
-		skip_test(write_fork_read);
-		skip_test(write_clone_read);
+		ksft_test_result_skip("default_value\n");
+		ksft_test_result_skip("write_read\n");
+		ksft_test_result_skip("write_sleep_read\n");
+		ksft_test_result_skip("write_fork_read\n");
+		ksft_test_result_skip("write_clone_read\n");
 	}
 
-	print_summary();
-
-	return 0;
+	ksft_finished();
 }

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250527-kselftest-arm64-nolibc-header-b650a457f7f4

Best regards,
-- 
Mark Brown <broonie@kernel.org>


