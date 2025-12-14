Return-Path: <linux-kselftest+bounces-47569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639FCBBD87
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1EE1300C377
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08672C21EC;
	Sun, 14 Dec 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRdA2VhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978202DF12A
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730159; cv=none; b=MALWKCkCFQkBWcxX7mMdAwHuOv5N9IdUJHpPXz3g4UDeEVNDSR6xdXRPvF6esw7fX5rIgveZPi8GXzbco/dwfIMxWL4NFiITDN6LroI1s5wDHVCeckW7aCpw9L+Y8Q6O2jSPbWR0vv0FMwXYEJOFp7gfSduGjHRc51AyI0ZrLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730159; c=relaxed/simple;
	bh=AX9Bi49c6VOIjDClUXqxhL4fzFAElwP2HRI9TAjl2yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgE9bqPCjM1QSO42wV9GNOSmuZ6GajtaYtZKMcMaF9a/E9yA3Tb61qpKZZ1N+zKs9QxHsuFMPchlRA1SC/E7vw6ihND/cwCqpKqfHk0bidg7S+7O8O3yNXUkMTLqoUbZ3k2aOPISqYnqmoXLQYNfgr5DnInIQWHOHwsd//TJDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRdA2VhZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-595819064cdso4353679e87.0
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730156; x=1766334956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzjkaycuriVDIslkX4nv+fXBvUrot6f7f5pS4rb9nTI=;
        b=FRdA2VhZgW6YB+rRUGRK26DjyMuRiNAfMXM/2IlEIry1tO5dPxxuRfANBGnmvs6MGz
         KX/0RHgAREa2Gu65u/KZcK4auHXJ24LNXDMqvkM43mYTo7H9vW+e2nbmGbNU7idLRce7
         RvQQWg6smUZgaXIHA6XUEIF1kdCUzlyH/Ier3mLZ+AgjUmQYnmukOkYT6jZ/KSwzDP6h
         fT6tswv1PxTBTAGjRIBcgh44l+gcqHv7+WS+xNnz2J3s5LuoIKy4iHjxQ5JG5M1L2jZp
         b2Xo87dDE43uEpa0mM5o2H3QDpLMquagV0Zj15RTk43pTyDOXSDxgoEfppXsRKaFtskR
         KeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730156; x=1766334956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzjkaycuriVDIslkX4nv+fXBvUrot6f7f5pS4rb9nTI=;
        b=UgSFh5uKLxvzJ7IeCehX8H5vl907QcRuBJEjLJW/z9ril9dwbSRKMI0YRvyzoi4Q3b
         1oaFMN9CkI5yEBzCaU3JFXKbBLijO/7vYMnyfgoSu9++G/Tp+XMyehbDuIMAK+aAN4RD
         PfateJgzRsp737EYTw5QJ6KaI0Hbqcqe93ISd+Zr2xwD+Na4w9PyzwI9E3ubog96RLek
         VLiT/9fmtZ2kbOn9FuAu5qM7tBl9omuCTdZ1X+B48D7dcH1dfBZ+lxOx2kIRstGQcMLu
         elpefqhxZZl1Ier5cUFt5D87csGAM9rut74ArdLf9qmQIT9s6kjbfd1y2Skn4z0Qbp7j
         PjQg==
X-Forwarded-Encrypted: i=1; AJvYcCU/yHbLQHB7MiYh4TTOd7TxqYetwZculaFr/BtZpdwvJKYT93tpyfyqJHWADlvb6GAmkBO2vLxSCUU0HuSi8Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnVCWAH+lvvwxoDGvA8Twr9xAFX7DvYy3n6Z3x73rPAn6CZNo
	TznYX3Ns7lEq6uFiNGUYX3c6fZIlAxtKUCBLXI8asSNDN9/eO56+cIg9
X-Gm-Gg: AY/fxX6GLR2dSQdxxMWLcqd6+uSBpfYcfxWsG72CaiHLpS8qdpgPY77Dxj3+Cxalvgc
	94NX1pZFVTBXhplUaSkUAwD8KATHiyXzpc3os4CI+7490lDcPMwGh3TOYe/vMzhTnrcvfYrOw+7
	HQTrTzmnOy4tvl3OowegcLBtp+4atFEt4p1SbZuDtzDsjnlm+iUQd+DJoFw7j9f42E2RwMWR6AN
	DbmnVUqWvk16U/N/IEP5iLmqHM1AUCMrmTo31DY2S/AZkJNd0GSzljTtArIZiw2yDQ7M/0+/5eA
	gbzcczH5hgklR5wGr9xgpQfMnkRGLEECbWaLDF5xZgKPlHlbEVPJmIBl+2QnAzgcGqwIbED9LNh
	y6l2qjbDFNek0kkujMfG9Ww6QAf9cFYWhoi+8oiPyHCvkRdJs9UQIPjBe7WxXdehlo/q22tZ79q
	6E/w==
X-Google-Smtp-Source: AGHT+IFEo7YnyX/RrmJbiSGf+H84hqlpjB1NYRQJ0t5IGQa+lkiCRASkjTEgJgxSlpqyoasVp+264w==
X-Received: by 2002:a05:6512:3c8f:b0:596:9cf0:fb85 with SMTP id 2adb3069b0e04-598f3bb013emr3764095e87.4.1765730155530;
        Sun, 14 Dec 2025 08:35:55 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:53 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 5/9] selftests: riscv: test ptrace vector interface
Date: Sun, 14 Dec 2025 19:35:09 +0300
Message-ID: <20251214163537.1054292-6-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to check ptrace behavior in the case when vector
extension is supported by the system, but vector context is not
yet enabled for the traced process.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>
---
 .../testing/selftests/riscv/vector/.gitignore |  2 +
 tools/testing/selftests/riscv/vector/Makefile | 10 ++-
 .../selftests/riscv/vector/v_helpers.c        | 23 ++++++
 .../selftests/riscv/vector/v_helpers.h        |  2 +
 .../riscv/vector/validate_v_ptrace.c          | 80 +++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/vector/validate_v_ptrace.c

diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
index 7d9c87cd0649..40a82baf364f 100644
--- a/tools/testing/selftests/riscv/vector/.gitignore
+++ b/tools/testing/selftests/riscv/vector/.gitignore
@@ -2,3 +2,5 @@ vstate_exec_nolibc
 vstate_prctl
 v_initval
 v_exec_initval_nolibc
+vstate_ptrace
+validate_v_ptrace
diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index 2c2a33fc083e..326dafd739bf 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,11 +2,14 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := v_initval vstate_prctl vstate_ptrace
+TEST_GEN_PROGS := v_initval vstate_prctl vstate_ptrace validate_v_ptrace
 TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
+TEST_GEN_LIBS := v_helpers.c sys_hwprobe.c
 
 include ../../lib.mk
 
+TEST_GEN_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(TEST_GEN_LIBS))
+
 $(OUTPUT)/sys_hwprobe.o: ../hwprobe/sys_hwprobe.S
 	$(CC) -static -c -o$@ $(CFLAGS) $^
 
@@ -29,3 +32,8 @@ $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 
 $(OUTPUT)/vstate_ptrace: vstate_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
+
+$(OUTPUT)/validate_v_ptrace: validate_v_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
+
+EXTRA_CLEAN += $(TEST_GEN_OBJ)
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.c b/tools/testing/selftests/riscv/vector/v_helpers.c
index 01a8799dcb78..de6da7c8d2f1 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -26,6 +26,29 @@ bool is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_EXT_ZVE32X;
 }
 
+unsigned long get_vr_len(void)
+{
+	unsigned long vlenb;
+
+	if (is_vector_supported()) {
+		asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+		return vlenb;
+	}
+
+	if (is_xtheadvector_supported()) {
+		asm volatile (
+			// 0 | zimm[10:0] | rs1 | 1 1 1 | rd | 1010111 | vsetvli
+			// vsetvli	t4, x0, e8, m1, d1
+			".4byte		0b00000000000000000111111011010111\n\t"
+			"mv		%[vlenb], t4\n\t"
+			: [vlenb] "=r"(vlenb) : : "memory", "t4");
+		return vlenb;
+	}
+
+	printf("WARNING: vector not supported\n");
+	return 0;
+}
+
 int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
 	char *exec_argv[4], *exec_envp[1];
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.h b/tools/testing/selftests/riscv/vector/v_helpers.h
index 763cddfe26da..c538077f1195 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.h
+++ b/tools/testing/selftests/riscv/vector/v_helpers.h
@@ -5,4 +5,6 @@ bool is_xtheadvector_supported(void);
 
 bool is_vector_supported(void);
 
+unsigned long get_vr_len(void);
+
 int launch_test(char *next_program, int test_inherit, int xtheadvector);
diff --git a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
new file mode 100644
index 000000000000..b64986b42270
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <linux/ptrace.h>
+#include <linux/elf.h>
+
+#include "kselftest_harness.h"
+#include "v_helpers.h"
+
+volatile unsigned long chld_lock;
+
+TEST(ptrace_v_not_enabled)
+{
+	pid_t pid;
+
+	if (!(is_vector_supported() || is_xtheadvector_supported()))
+		SKIP(return, "Vector not supported");
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm volatile ("ebreak" : : : );
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vlenb = get_vr_len();
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+		int ret;
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0));
+
+		/* resume and wait for ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* try to read vector registers from the tracee */
+
+		regset_size = sizeof(*regset_data) + vlenb * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		/* V extension is available, but not yet enabled for the tracee */
+
+		errno = 0;
+		ret = ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov);
+		ASSERT_EQ(ENODATA, errno);
+		ASSERT_EQ(-1, ret);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0


