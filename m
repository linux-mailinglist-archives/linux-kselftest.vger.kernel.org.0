Return-Path: <linux-kselftest+bounces-42821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99542BC1481
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E533C25D3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88802DC793;
	Tue,  7 Oct 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la10+bkL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8A2DC34F
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838330; cv=none; b=Nn1BBYFsLqhY39v8DXft//UCiiCbQgWAUQHXLUHLHzr+WjhhybUrJSn7qMXr6lpgSYp/nqZypoDMEe+G3hDkySlVQMFnrsHZ1MMzjQ8ekk/xm3y1Y+PwC7uSqUE1WYEtS2nb+ryXKcqiDk1os2idFvnNgccGbxnsGRQVVa+2BPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838330; c=relaxed/simple;
	bh=mcJVA40xehln8g/vmGo6D124qbuR9E2HuyKpj9/eQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhsb7iuv8C2cN8novBjDwrUEE/XATannYDrglAEhU/23krmmiwPSGoIWDCoqNK2ooWIMf41T+9wEVpvox0hbrN3ChAXoN/1aBNhx4QRAIOcpfPFUJfPXBbuIkT7brwAJoKjZoixrYCUEi9wcE4ur4M37fCNsoLeQnNKEImTeJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la10+bkL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5818de29d15so7639412e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838326; x=1760443126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hkQNqMVuVavuueLTx2UspShKdK9McUVzuMp7MeB9bE=;
        b=la10+bkLN+mdwg75GE63u9WUmUYYX3ZEHmh0zGjfQji6476Z0eChRLgAH69P8g/u+D
         pQmjB74/L/hSQzhyB7FFaUEaiYCXkD26BduPa1HEARsm0xVSz9PuwAOGtMXkXQG9fQH8
         ygmvlbABTYspCUuBFwZS54lX3TDSZ90X5ae4k3qBxq7/O50B372gEYerBDbS01M2nsMy
         awVIPaADIwMs3tzqBrEwmVWhQpy8+wdm0JJ6BWagRgkvGvLyeEV+qsgYmgFSQiNbc5pu
         yVxL0CNElj13b4uMq4a1sfGA2bder/edYYnCz35sjWjC87BgMUpRj7oQPHwAml3nxpg5
         KExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838326; x=1760443126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hkQNqMVuVavuueLTx2UspShKdK9McUVzuMp7MeB9bE=;
        b=G36QHw2EdMgjry1ULY8s2Z/jfE6DMhIctWDUwaXGwdNunWSQg3XCa6LpbYg22BGJtR
         u6x831aTLZIH9qrXBxn5YSDgsQjx+xu0OW6tFdws4qgm15a0jkgvY4/CITldSBGYG2bH
         gF0AN3H92aoMjCjMI2j5pkZpxiKPDv8NgUO/gpusNnh0FT/Snu1hWqgMe+s5R2sm3GSX
         Zamc1Yku+pAltc3bUTTWNWkex5fjHAAgrYnEsgCW2joaTbSEG2D5l4aI+BqpVVkJpmI4
         uzjqvobJEgf5p//xhjAhdnHT93dHdw2+QVB/VzaIxM/WmourVFd5gnCS5Y33qlrLE0h5
         Fjng==
X-Forwarded-Encrypted: i=1; AJvYcCWYfPwdP9vdW4vU5FDyQiJ4/E8wtfWr/T1D9r3MsrMESfmAitBdAheeXWjYLWz4QIMorvAP8XARInmTLYzLwSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xAdFQJSdsLesM1XvsT7j1LSx+iOV8hU/DS1qP5JB/3sinJU5
	LTNFNnQGuIh70od4Ir73qcInANJ95M3TU7WxXleucvL1aMUby01futwL
X-Gm-Gg: ASbGncuJdm42z3lqSwlC4573GOlNLdwcUpAqvwRdwxgKhuo4kzEWv9b/HbLE4K3dDfc
	hjCf8uaKhlweO7YtCaTRHPzFV0EsXec4UD3SF1vud2hlWkODZXPBmVJBdmGjKcxbPxMoWG60EgM
	FZPxVj3gi91cPLIYSQW3opD0Qi7RG8moI+bGPSCl/oy9DlFSfgXDVvsV8HvNLcb4JAC9M5GIiOv
	IhqlnXBYhsdlSPAvyyOPwu/lQXvAWLYv0lOnscsz/3n4MfNM5Oz5/ySnI8uvel685MNJPOy6pw3
	36pf9e64DbGDQUNnsHRj0pauG8GzDpPbkeHvMW3MQRXpVTu7xkzK0i3HJae2fhm9mBXEHrEvK7b
	3XpxZJQ6leM7jcN02tWH8NqP04LeeYnnf+th2Sw==
X-Google-Smtp-Source: AGHT+IG37rD+PkxghSu66eoS6ldRFOZQ/XHIZ2H3lGBdSNiBQTjR1sXUQKZr50hfMoazfvibAaCTuQ==
X-Received: by 2002:a05:6512:3e02:b0:58a:f865:d7a0 with SMTP id 2adb3069b0e04-58cbb62b934mr5386340e87.35.1759838325227;
        Tue, 07 Oct 2025 04:58:45 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:44 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 1/6] selftests: riscv: test ptrace vector interface
Date: Tue,  7 Oct 2025 14:58:17 +0300
Message-ID: <20251007115840.2320557-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
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
 .../testing/selftests/riscv/vector/v_ptrace.c | 87 +++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
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
index 000000000000..6a8d56a5c4f4
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -0,0 +1,87 @@
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
+TEST(ptrace_rvv_not_enabled)
+{
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	chld_lock = 1;
+
+	pid = fork();
+
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


