Return-Path: <linux-kselftest+bounces-39538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F6B30143
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4371CC619A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA433A022;
	Thu, 21 Aug 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL0LjXBD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4333A016
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798011; cv=none; b=V1kEd3b5iUpC9OQyn6bOjc6Kh0SdLfxc6gx+5NI3pJp1L2NPKZ95B4D2IoA3kGYmdFninPunsVXnsfm6xAbI+jwakbV0BMbefrBYrDGaWkRGVXVbzidP21Ex1fa8KfTd2dPcvjrvkMQoegEO8+SM35F944B/m6k/83xLYGrRyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798011; c=relaxed/simple;
	bh=xe9Nx273m4e0DonMHbZnkt45yEduUi6cnIFUW5DF9Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goVJDmRB0j+Uo/mjoWuTgjoymfdsMynp0u/+W9dlUpAZ/RN/P4a+hH6Sq94WEsKKtUcswBG67nQKUgyaGj0QR7KrcEVMiSsMWPw5FvomuSqnVPzU9+GDqQlxhOYtWnIoJW2+rIi2RtWyk/X40sNBDGcMpP6KkuTUfWwr8QwyHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL0LjXBD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so185838866b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755798007; x=1756402807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t35JYWS631G2fD8UxKORvftL0Lp/EpL5F0Ec1OYScY0=;
        b=kL0LjXBDK49CoelWhYNq7tU4gbAWuu9ZJahgTn0aOQS57kEAGcWoVoWvqOu1h3e6Gr
         fSclkZ6wns2MyGfTjBuYeG68Tvzce1jbDMxhl40IT9KY/Ko0cmyVW24ODBthXhRavpcf
         opx1pEDmEPw0F7QhPnVkYxnqwt/sRKRB4mMreleWz0ZsAselaDcT4XRrMq2zv/eMLzWL
         vtzAkQTm62XW3r2IRyF3XvYCp0+F8HIqAN0XCEaIT4e9DtQYQ0RlsK6bYGLtOrDQE56e
         LzTdHFHqZDlXuwgGmGqNDn21rNHQW1s4edydpVDW6asXAaH5hCf4dEB/xc0A3ua9iUmA
         g4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798007; x=1756402807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t35JYWS631G2fD8UxKORvftL0Lp/EpL5F0Ec1OYScY0=;
        b=ceb9X1YadXgiOTotRJU0IT5UG/Rxjjq1q/GeuQfvIvbGUqLvkeQxDSWZIPtlNaPy56
         uvL6hQQQNWL5zlX+1IAGnY4bVXMRbhKWOGk4fEDlcYaDlq9knwIeSqbh0fDPCoS3wl7n
         4u1WA21w8a+5ev07/+5o73H1+udVDQFAi3uU5VUuEJG6frERLa8bXp/qUNMz0/gDA54L
         IY/k6PvDueI+VoJZ9+e/5YWbtVGaMOvMxS7xZYKyyz4tuZOhU2N4H637moC4F9KzdrIV
         7yI6eakaL55HOCgZZh3YOwgPAvRcwQz/oWMi7pkymuFesqwe0TujANzkAcYBWMm82jkz
         /L3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpzcz9q7G6l1Tjv2dokiobdTkImwtA8siH8DkdjUvs+1CsoNNv0DFmHyqXf0qAOeIPFarArAx5tPF3W+ezXTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyqmQWm3rsn25l2wzEmVq0LX3ygYDAh4cBCawqsHMusIIePXu
	+fo9BIJeepOdBdX7xKdQ8joLv3kQ8+8EEMv4tBmdsVOesJ4wEHT0u9nY
X-Gm-Gg: ASbGncuCvkdCgcxyN3SN+g7f3OywcoQVfV1YHFXZKB0Ec7J0oI6vQPNQLAkdSOPqftq
	i3An/MNzWDBY5H4tjxKW8oaPWI5EMWtkFtcLmdmPzrFvDWmFZKbuiFceCpz/yG5l5O+UMi94iqb
	fO7SXsRsKsIbiRywIjMkc0Z8kp5UF8qjnp1HL+zihe2HW4iUSqWvtaJPpXZT8R2f40/RRhYgUL0
	c57+5ZggRi+hJHhVtbhn790dN5OfVj1HovK6y1GUtsZO3HT9GLLICKOU+cl4phmNGeNxNZvEPkJ
	FEWpLA6c4ZD+dFoOKZxddpisZvIyNksKoq7EPsXfc/kLMDozd2nNntg7ZgPBtKCvC9qVe0uxdKF
	5i8MujcBiZTuIyxg=
X-Google-Smtp-Source: AGHT+IH595ELbW4syrWCRa0Ezghv9nt+E2W13XW9CQb5/1Ur/79kB7Ff/baL4WnCWIP49qxsQWryaA==
X-Received: by 2002:a17:907:7b85:b0:afd:ff8c:1307 with SMTP id a640c23a62f3a-afe28ec571fmr2142866b.11.1755798006963;
        Thu, 21 Aug 2025 10:40:06 -0700 (PDT)
Received: from curiosity ([80.211.22.60])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4c9c12sm422705266b.82.2025.08.21.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:40:06 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 1/2] selftests: riscv: vector: add early ptrace test
Date: Thu, 21 Aug 2025 20:39:49 +0300
Message-ID: <20250821173957.563472-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that simulates early vector debug: attach to the process right
after enabling vector context and check csr_vlenb.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/.gitignore |  1 +
 tools/testing/selftests/riscv/vector/Makefile |  5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 84 +++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c

diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
index 7d9c87cd0649..d21c03c3ee0e 100644
--- a/tools/testing/selftests/riscv/vector/.gitignore
+++ b/tools/testing/selftests/riscv/vector/.gitignore
@@ -2,3 +2,4 @@ vstate_exec_nolibc
 vstate_prctl
 v_initval
 v_exec_initval_nolibc
+v_ptrace
diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index 6f7497f4e7b3..c14ad127e7fb 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := v_initval vstate_prctl
+TEST_GEN_PROGS := v_initval vstate_prctl v_ptrace
 TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
 
 include ../../lib.mk
@@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
+
+$(OUTPUT)/v_ptrace: v_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
new file mode 100644
index 000000000000..1ae1b6d44363
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -0,0 +1,84 @@
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
+#include "../../kselftest_harness.h"
+#include "v_helpers.h"
+
+volatile unsigned long data = 0;
+volatile unsigned long lock = 0;
+
+TEST(ptrace_vlenb)
+{
+	pid_t pid;
+
+	if (!is_vector_supported() && !is_xtheadvector_supported())
+		SKIP(return, "Vector not supported");
+
+	pid = fork();
+
+	ASSERT_LE(0, pid) {
+		TH_LOG("fork: %m");
+	}
+
+	if (pid == 0) {
+		while (lock == 0)
+			asm volatile("" : : "g"(lock) : "memory");
+
+		asm volatile("csrr %[data], vlenb" : [data] "=r"(data));
+		asm volatile ("ebreak" : : : );
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		size_t regset_size;
+		struct iovec iov;
+		unsigned long vlenb_csr;
+		int status;
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &lock, 1));
+
+		/* resume and wait ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vlenb via ptrace peek */
+
+		errno = 0;
+		vlenb_csr = ptrace(PTRACE_PEEKDATA, pid, &data, NULL);
+		ASSERT_FALSE((errno != 0) && (vlenb_csr == -1));
+
+		/* read tracee vlenb via ptrace regs */
+
+		regset_size = sizeof(struct __riscv_v_regset_state) +
+			vlenb_csr * 8 * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* compare */
+
+		EXPECT_EQ(vlenb_csr, regset_data->vlenb);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.1


