Return-Path: <linux-kselftest+bounces-44046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87AC0A014
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F2A1C25487
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8772E1F01;
	Sat, 25 Oct 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVFJPAUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB329B793
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426433; cv=none; b=C9SY4Hei7zfxu2wm9numr2HPV7jLDRY+pT7WNRc3vSBDvM0Is4TRkY6sE6kkXLVjEamqqTMq+oqHdtkdwqxhhycFHS16bZ7i1U6nlBbSbWR7lt9APrKx3yIvZQaPKqL7DUFmL/eqizzpsJEP2GDvU6E+pbbRMm7XfZmFh0gw9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426433; c=relaxed/simple;
	bh=wqvT45qGYMuDuQ2nycCKDD1dsJd4Ss57Ns77t1WjGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb0GMLx4F3yzviaEZUpkPYBCkmZLcjKy6fRQLwNxHll6hSCgynHrS2KH4yYDD6GCj9fBAPVC5esGJV9LVmp5YfGcBhVjkUpu9VTCrwOv2ON7S9gWhXXiTnb+wSj8nwgm4ibcw5TpmCOC4Drmzh+rKCPvNVqKsRfrOPDA26Npj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVFJPAUg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592f7e50da2so3548890e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426428; x=1762031228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=VVFJPAUgHIYA3eLziEu29EshQcGP5tvr/67LUGUx5/Q17aBJIaCKBDYj7EkVXVyUdu
         8pd3KZs66BfsImgZIpaU7b83fdv+bq5+gHBAP5UtkKb2SI8inHCWPMIQL2qFTriTpXeV
         mNCvJGOYdfCqv9HW5TTANhBH7AXw5C9QHji8C73R9VhimyTNOIoaKnUcSu1BaqteSKne
         H+myX7YlChHcFW/lQIEYM2lJtC1a6++e7qeDbNOoVI5g5PJZwdJe5ekqoly1taeFq5FH
         FQvHt+ziiU4IjZ70EaMsqEfJ3yornb39PbnpbmRiCM9YvMnRyaGC1r7fU0vUmOgfCQQu
         ExHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426428; x=1762031228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=WmJAtQXpHJzyl97ksBQGPnTekMH2HNv6uuOzZRDq/zMw1zMSR7maFSX6Mcu7osQj8b
         h2WmoE8446PWMVnX1/hX5BoMGbMdWvOY/4BnTxrIxg/j142djau2tbdw5E+bPtMksD1g
         zS/Y9NOUP+z/64Rzz1irYOJOPvaKiotp5pO9x3fSXJxeSOp6Tla+L3DoU8H6RXiqCuMB
         zRqXLaiHkhpu1bpg5fcM4km/L3cBYLvwLv9ZalGsjmU7uyQzgkXcsqqJ2pjJBQ4dWMEZ
         +gai5vAajQEvTiQ2WwPb7B7B+dvVb5nAH+mDr4j298k7yRFC+hLVT+z2pzR/X/hgE507
         3jvA==
X-Forwarded-Encrypted: i=1; AJvYcCU86Pv7B0J1j1yxi53D0UZcosSoi7xSWmgJn7BtEGfzc3kH1JpEK7pU/IsiYPm3Aj0pk/8GBEgvve5fYGP3ctA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLb3tO7hnznYNcC1pqMcnHCVYrw3qaTcIIf41RhGReN1Bukyd
	m5dSwvQx0SYOASds6EfDS+EDhZU5sSe7cQ/OuDnQvrWFiZg7C/0aFx9t
X-Gm-Gg: ASbGnctm31NeiVRmO36KxGt4j1ANTFjL1wNjn4X6JcrZu3XlPCs9Ddim8zug/brxlzd
	hwI840yQM1NsjJ98ErTI3JdNdwrHNLMycHqxtLHOFX7prd0xLQXx7BBwEBIWHC7B1XD2dQqqSn8
	YdMccaNq8Kux/Pmd4t8JZ+PHfwm2PS8cx25zEzy55yD9fFnTLsH+7lzm+rfMnFcVvYuI9WaZogr
	mfFH4SmTVbclMegtJccXG8SRxroeAZQ8R6oOY6TAtNgQhRu84B/sLoKSrw9oR9dkrvpgbFZnRVV
	wextvgXyzxUS0v/bdLQl1H3fYI6tAb9noBj58E8Efll9XxzKJK91bqmdBJmWYycecxoP9QhHWMQ
	EiRTDspQLyFEgWsAorm3ImvVD5qHr57BYxVtBoIjmMmOSnGHnwDpLvXZslQsR+9w0sI738lAEVb
	ZbMA==
X-Google-Smtp-Source: AGHT+IEDTnYlHsHbxYTMbvTclp6aBf8KAfq0acQrqiIvksnO+SXu5n9y6cipJAxh49NWH/q/DLQsKw==
X-Received: by 2002:a05:6512:ad0:b0:592:fab3:9b1a with SMTP id 2adb3069b0e04-592fc11e15dmr2357987e87.14.1761426427877;
        Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v3 1/9] selftests: riscv: test ptrace vector interface
Date: Sun, 26 Oct 2025 00:06:34 +0300
Message-ID: <20251025210655.43099-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
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


