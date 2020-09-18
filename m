Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59926FAE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIRKrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIRKrt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 06:47:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9872C061756;
        Fri, 18 Sep 2020 03:47:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so5126747wrp.8;
        Fri, 18 Sep 2020 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIUKYQBe5Fl+GZXzuMdAIZ0zeMrQ+6eL85ZD/kHw8aY=;
        b=o/l08dU0a3iblTzC+cQL18/yCNFr+G6et9Nfymcwn3P7xz+BuqkejV3JvsJI4gVLq+
         nN3aArF1cqbbiT00q1Sd0xLznM6Hr9WQAVN12rzM3eQMRX5QkYum4QFvbWnt9upRItHo
         1NRxIeeMeeoNyr2KaWG3U4dk97gxDRlY1XYEzwtVstTPU7YFvR9SWxA0orlnIRuKl9Md
         sycaJp8s0tg9su+5g5VscOmyRIqkulX6lyPNCPJIwTZZplkm/dauDGzaNgbpEyRzTetS
         uyPUkYK1mmfNZm7AffTQTN/WzdLNN2CXGYq+LSpWj2IkcZ3LhDGMn3HFN6i79mqrO7fW
         p+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIUKYQBe5Fl+GZXzuMdAIZ0zeMrQ+6eL85ZD/kHw8aY=;
        b=Zwkpuos2GP2wY7NqDq8FLiwdmc8TF1kJtQhi7YVyo4Q1lI0NuGSYsz8V8al63P+TMA
         wqAwtwGSVdIpszMHs/knK78g3C3VBdW1jyOrFPzH9jmljA20TSeG63o1JnEGm2nX3GJY
         Qchn3UfK801W1ddAsc4Bdv4sMqLav6U2rc5mqTinxdovGKaoKNIwmnry5JpZ+fvdpAkn
         M2wiyeubQW7k+0M0GKKU8g02PQWFIUDB4IG5ZiZOhEaviP9QZJoOL2qgs55FzbBR4pR8
         LMlp4oTuYbm7Tgk11N4ftCzdUapCQr0nxsFpDZGEVDHsAcOL5e+uEK0ShU6oMvB5ffMk
         40Rw==
X-Gm-Message-State: AOAM533x7JpVsZHUvx02pYfvQ4dZ2SPdBwLVaY2+L+AcmA8JeaJKzqj2
        4LwqNw/FEirUuaiOFkqUipQ=
X-Google-Smtp-Source: ABdhPJyDY4zAyIqiiJ/zK6mMJVToLY91t8rOydnNP7+wypwPmVLmuAtew63ljrzeKgiu1sV0AjqoKQ==
X-Received: by 2002:a5d:430d:: with SMTP id h13mr39405899wrq.41.1600426067296;
        Fri, 18 Sep 2020 03:47:47 -0700 (PDT)
Received: from trantor.home (cpc153975-seac28-2-0-cust722.7-2.cable.virginm.net. [81.109.38.211])
        by smtp.gmail.com with ESMTPSA id h4sm5197846wrm.54.2020.09.18.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:47:46 -0700 (PDT)
From:   Boyan Karatotev <boian4o1@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boyan Karatotev <boian4o1@gmail.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 3/4] kselftests/arm64: add PAuth test for whether exec() changes keys
Date:   Fri, 18 Sep 2020 11:47:14 +0100
Message-Id: <20200918104715.182310-4-boian4o1@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918104715.182310-1-boian4o1@gmail.com>
References: <20200918104715.182310-1-boian4o1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Boyan Karatotev <boyan.karatotev@arm.com>

Kernel documentation states that it will change PAuth keys on exec() calls.

Verify that all keys are correctly switched to new ones.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
---
 tools/testing/selftests/arm64/pauth/Makefile  |   4 +
 .../selftests/arm64/pauth/exec_target.c       |  34 ++++
 tools/testing/selftests/arm64/pauth/helper.h  |  10 ++
 tools/testing/selftests/arm64/pauth/pac.c     | 150 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c

diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
index 5c0dd129562f..72e290b0b10c 100644
--- a/tools/testing/selftests/arm64/pauth/Makefile
+++ b/tools/testing/selftests/arm64/pauth/Makefile
@@ -13,6 +13,7 @@ pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x c /dev/nu
 ifeq ($(pauth_cc_support),1)
 TEST_GEN_PROGS := pac
 TEST_GEN_FILES := pac_corruptor.o helper.o
+TEST_GEN_PROGS_EXTENDED := exec_target
 endif
 
 include ../../lib.mk
@@ -30,6 +31,9 @@ $(OUTPUT)/helper.o: helper.c
 # greater, gcc emits pac* instructions which are not in HINT NOP space,
 # preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
 # run on earlier targets and print a meaningful error messages
+$(OUTPUT)/exec_target: exec_target.c $(OUTPUT)/helper.o
+	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
+
 $(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o $(OUTPUT)/helper.o
 	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
 endif
diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
new file mode 100644
index 000000000000..4435600ca400
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/exec_target.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/auxv.h>
+
+#include "helper.h"
+
+int main(void)
+{
+	struct signatures signed_vals;
+	unsigned long hwcaps;
+	size_t val;
+
+	fread(&val, sizeof(size_t), 1, stdin);
+
+	/* don't try to execute illegal (unimplemented) instructions) caller
+	 * should have checked this and keep worker simple
+	 */
+	hwcaps = getauxval(AT_HWCAP);
+
+	if (hwcaps & HWCAP_PACA) {
+		signed_vals.keyia = keyia_sign(val);
+		signed_vals.keyib = keyib_sign(val);
+		signed_vals.keyda = keyda_sign(val);
+		signed_vals.keydb = keydb_sign(val);
+	}
+	signed_vals.keyg = (hwcaps & HWCAP_PACG) ?  keyg_sign(val) : 0;
+
+	fwrite(&signed_vals, sizeof(struct signatures), 1, stdout);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
index 35c4f3357ae3..652496c7b411 100644
--- a/tools/testing/selftests/arm64/pauth/helper.h
+++ b/tools/testing/selftests/arm64/pauth/helper.h
@@ -6,6 +6,16 @@
 
 #include <stdlib.h>
 
+#define NKEYS 5
+
+struct signatures {
+	size_t keyia;
+	size_t keyib;
+	size_t keyda;
+	size_t keydb;
+	size_t keyg;
+};
+
 void pac_corruptor(void);
 
 /* PAuth sign a value with key ia and modifier value 0 */
diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index bd3d4c0eca9d..b363ad6a0b50 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -2,6 +2,8 @@
 // Copyright (C) 2020 ARM Limited
 
 #include <sys/auxv.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <signal.h>
 #include <setjmp.h>
 
@@ -28,6 +30,117 @@ do { \
 	ASSERT_NE(0, hwcaps & HWCAP_PACG) TH_LOG("Generic PAUTH not enabled"); \
 } while (0)
 
+void sign_specific(struct signatures *sign, size_t val)
+{
+	sign->keyia = keyia_sign(val);
+	sign->keyib = keyib_sign(val);
+	sign->keyda = keyda_sign(val);
+	sign->keydb = keydb_sign(val);
+}
+
+void sign_all(struct signatures *sign, size_t val)
+{
+	sign->keyia = keyia_sign(val);
+	sign->keyib = keyib_sign(val);
+	sign->keyda = keyda_sign(val);
+	sign->keydb = keydb_sign(val);
+	sign->keyg  = keyg_sign(val);
+}
+
+int n_same(struct signatures *old, struct signatures *new, int nkeys)
+{
+	int res = 0;
+
+	res += old->keyia == new->keyia;
+	res += old->keyib == new->keyib;
+	res += old->keyda == new->keyda;
+	res += old->keydb == new->keydb;
+	if (nkeys == NKEYS)
+		res += old->keyg == new->keyg;
+
+	return res;
+}
+
+int exec_sign_all(struct signatures *signed_vals, size_t val)
+{
+	int new_stdin[2];
+	int new_stdout[2];
+	int status;
+	ssize_t ret;
+	pid_t pid;
+
+	ret = pipe(new_stdin);
+	if (ret == -1) {
+		perror("pipe returned error");
+		return -1;
+	}
+
+	ret = pipe(new_stdout);
+	if (ret == -1) {
+		perror("pipe returned error");
+		return -1;
+	}
+
+	pid = fork();
+	// child
+	if (pid == 0) {
+		dup2(new_stdin[0], STDIN_FILENO);
+		if (ret == -1) {
+			perror("dup2 returned error");
+			exit(1);
+		}
+
+		dup2(new_stdout[1], STDOUT_FILENO);
+		if (ret == -1) {
+			perror("dup2 returned error");
+			exit(1);
+		}
+
+		close(new_stdin[0]);
+		close(new_stdin[1]);
+		close(new_stdout[0]);
+		close(new_stdout[1]);
+
+		ret = execl("exec_target", "exec_target", (char *)NULL);
+		if (ret == -1) {
+			perror("exec returned error");
+			exit(1);
+		}
+	}
+
+	close(new_stdin[0]);
+	close(new_stdout[1]);
+
+	ret = write(new_stdin[1], &val, sizeof(size_t));
+	if (ret == -1) {
+		perror("write returned error");
+		return -1;
+	}
+
+	/*
+	 * wait for the worker to finish, so that read() reads all data
+	 * will also context switch with worker so that this function can be used
+	 * for context switch tests
+	 */
+	waitpid(pid, &status, 0);
+	if (WIFEXITED(status) == 0) {
+		fprintf(stderr, "worker exited unexpectedly\n");
+		return -1;
+	}
+	if (WEXITSTATUS(status) != 0) {
+		fprintf(stderr, "worker exited with error\n");
+		return -1;
+	}
+
+	ret = read(new_stdout[0], signed_vals, sizeof(struct signatures));
+	if (ret == -1) {
+		perror("read returned error");
+		return -1;
+	}
+
+	return 0;
+}
+
 sigjmp_buf jmpbuf;
 void pac_signal_handler(int signum, siginfo_t *si, void *uc)
 {
@@ -92,4 +205,41 @@ TEST(pac_instructions_not_nop_generic)
 	ASSERT_NE(0, keyg)  TH_LOG("keyg instructions did nothing");
 }
 
+/*
+ * fork() does not change keys. Only exec() does so call a worker program.
+ * Its only job is to sign a value and report back the resutls
+ */
+TEST(exec_changed_keys)
+{
+	struct signatures new_keys;
+	struct signatures old_keys;
+	int ret;
+	int same = 10;
+	int nkeys = NKEYS;
+	unsigned long hwcaps = getauxval(AT_HWCAP);
+
+	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
+	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
+	if (!(hwcaps & HWCAP_PACG)) {
+		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
+		nkeys = NKEYS - 1;
+	}
+
+	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++) {
+		ret = exec_sign_all(&new_keys, i);
+		ASSERT_EQ(0, ret) TH_LOG("failed to run worker");
+
+		if (nkeys == NKEYS)
+			sign_all(&old_keys, i);
+		else
+			sign_specific(&old_keys, i);
+
+		ret = n_same(&old_keys, &new_keys, nkeys);
+		if (ret < same)
+			same = ret;
+	}
+
+	ASSERT_EQ(0, same) TH_LOG("exec() did not change %d keys", same);
+}
+
 TEST_HARNESS_MAIN
-- 
2.28.0

