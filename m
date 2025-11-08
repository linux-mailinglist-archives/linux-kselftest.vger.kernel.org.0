Return-Path: <linux-kselftest+bounces-45181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657EBC433D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE6B188D05C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EB28642B;
	Sat,  8 Nov 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD10iIxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE568284B37
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630942; cv=none; b=UP0EK059jQUi5koVBA7LSjv6GH2zBdb+0k1hI+PQSCIeQ8CCfSipL90yMW3i63pYgzyVRuAK8d+s1ncZPYUjGqzOpbEVgJ6esBl5tQhCV0TIr0AXHAzqXt5fnRwQQ5ruoFYRTDeeccgCqeaR/QGjZo9f8+CmqEs7vN+ByL8B8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630942; c=relaxed/simple;
	bh=wqvT45qGYMuDuQ2nycCKDD1dsJd4Ss57Ns77t1WjGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5IZP72VawZx8p1gqFBkNmjYuxeQiNdvssvgmn41z86uSXzulZELs0DqqNtYfsA6LALtIJJkcw3M4LotYkIFXPrZEOPpytF/4LRKHCjy34XtzPWZ1ZdGU7YZvu7PDOMBTmbP3Kbx9eRvKyo0ICDZJX6iz5Ewnucu5YNGJ0WUi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD10iIxX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36295d53a10so14509481fa.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630939; x=1763235739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=kD10iIxX9rEVJmzZ3uZ0xowNdeIAX2lY7M5AA9URSYxqCcDLN3EEeScI8OexXBWvd5
         R8o19CH+srssn5guvdaFqApdQuk2ACS+zJoSGhk6mjDdb5RhTvDaykURrTy4vHBAKL6c
         bTeqDSNbLe1P0pQnkCxR5SiRjLKj88OA8dtgvmkdqr7IBr1EfyT3cOyVx6UFe4TiclS/
         TJ7aFo5SIYJ2lPZzeKv9X2TRWUXKfxQXNb063xrKfSsPcB2Po0DT7pObF5wwUgIklpz0
         rx/IN/pJ0fHuQO+5YDlJCklPVg9NbfMoz6J8OHAqcDY7xwbb17ObZ9CIttg3PewD04Wz
         p4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630939; x=1763235739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=s7btnHhrWLhTYh9HO2mt6LdBTGa6pCWoIo+LesNGfM41Z8XfmMcdUqK3OaQf/+RJi0
         51fqEeYUxmrI5YlNGpNszZ1d7Li4IgRNkFO0dcye1FWqcG5S/p/fj8s4GRcFvYz2LL22
         IMdpGucxVvV18Yo8KTzw0Gp9i8EL2yW6hyjY8TD8eKKC9B0pMG/Q/ygwTy/r2tVwvGsz
         SZWPW2B4TNqGgA08rsb1aVeN+MhoCOuk7/7WlCkYBEQKqqkaJE9KXJxO4KuhRe+4vxh9
         Hw+x1/QT9rUuAmftsOg/EDeTnhWKUMetgsQ9irH+EXFxy/H5gnVqXY8/fQ5aUF4O5FIj
         UM5w==
X-Forwarded-Encrypted: i=1; AJvYcCXGhBlSJjivHlLXmthntOjDbXnFYfyD3yTboWo7necAuBM/zxlvWCTzYiRpnUhN4/MIV6JSpPbk1viHohw5zQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3bm33GwBY5xnwRKdFA66rQFmT3Si2aAj4M/0QVwDGE/JikWx
	H6xQJwMzAGAFVaKuOYI98mTgE678uwu8yjTzgZvnKSBVvDBFd+0spcaQ
X-Gm-Gg: ASbGncsYgvzbwD0aUwxEN0+JTB4U6oElE6ZNNxNt0ucxpKmoHz8VSDm5XChPTz5agFU
	CyM0ZwJB9rg2w5uNUX124TBn+FVo88VGnIoJ5k3Pxui/Y68XLXjnDxZgPSQIRFxYJVyk24Bui0Z
	3oYtedciyOMyyPvHen04kzSX/Tc4zpZLwu7Kht1eB2L5LzyapzywNv6ij/o/cKpO2/8IRmblbeW
	SGF3FqYdDlogHdjoERnhlqDXkyNdEJ7ADIbWxbSR80iP2y4wWH4b8fTGY36Zuv2QRt3X29rDLT+
	FmPtr0Ra93Zpa9+3zw5DU/pcvvk6twXw27/CGReVNCTX6MbBWb5ZP2uidiGp+xVbY/SMpvtbg3J
	GfMWLFX6z80zGqwUf6I03zLHpmyY8UHLDUV/TzpqlN1pibQgw6KPxgRAI9j24es8UtF8=
X-Google-Smtp-Source: AGHT+IF3y7EhnrI50/eOKBcDvbA1ZdP19crRLl5icMKNiFVT61otI/EZ1TlvdKRA1oAFy9eUXhK/mw==
X-Received: by 2002:a2e:8796:0:b0:37a:2dfa:c774 with SMTP id 38308e7fff4ca-37a7b1f475bmr6593681fa.31.1762630938599;
        Sat, 08 Nov 2025 11:42:18 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:16 -0800 (PST)
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
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 1/9] selftests: riscv: test ptrace vector interface
Date: Sat,  8 Nov 2025 22:41:40 +0300
Message-ID: <20251108194207.1257866-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
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
---
 .../testing/selftests/riscv/vector/.gitignore |  1 +
 tools/testing/selftests/riscv/vector/Makefile |  5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 85 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
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
index 000000000000..6a4b5a2ab4a2
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -0,0 +1,85 @@
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
+volatile unsigned long chld_lock;
+
+TEST(ptrace_v_not_enabled)
+{
+	pid_t pid;
+
+	if (!is_vector_supported())
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
+		unsigned long vlenb;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+		int ret;
+
+		asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+		ASSERT_GT(vlenb, 0)
+			TH_LOG("vlenb is not valid: %lu\n", vlenb);
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
2.51.0


