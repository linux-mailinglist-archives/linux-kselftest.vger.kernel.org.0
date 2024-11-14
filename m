Return-Path: <linux-kselftest+bounces-21990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3C9C80A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3321F23AA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A81F76CD;
	Thu, 14 Nov 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uQEkBnro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F811F7572
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550918; cv=none; b=PDAa0AOBm+RcSErf9JBe2RDDOK98jYYaAlN3m76IXOsgrTmliSaqVRIORxh1lnJ0xqGt5axZGmfXzgIYdN0xTq3fack+hlksfMoPCYZdrxwPG4TU0t114wpoX7BnYk2PZapsABzAO7FUQtDQHu6cBqiQcCDpHfKD84eSVrQQOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550918; c=relaxed/simple;
	bh=gb3C6KzMXc7O9n5RgIZ+oQYrGbjWeFuXLSOVe7rZJ5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4GrxM6h8nvAHbrK3upzAwSfjCARect/uFaj6rnMSeLNtCBShgnsA7n0RDMXNF9VkIx24hY/b2GHsc+PJCzMHQcmhgVaOpb2lUwDg11Rk1PLw9vFoRrTXrJPuB2eT2CUzHkSBx1Ndwi7+HkQZTH2pi6ePlB8YR5uT+7ZNR+1smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uQEkBnro; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so120929a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550916; x=1732155716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FbTT42ntRqTX7F9UxQU0NN8E/7QETZOJXWenNOfNwA=;
        b=uQEkBnrodwtUfEm9v7swSIVNvI3yqalvv+NZrVFyLpiCyNagf85a6eyk3o7kcKOrr2
         ebgKpSCD74AA0BtBkW2MotrcWN12mSfVOoGTg/TxPJ6b5hyuLcM3UfM4r1A6+xOCf6Ui
         M5iP6foj8xmCMUFaOdG/qJrnc2YjdKWoar1rJPuPUMxx9oDHPhoKh8j42iiTMjHZaIAz
         cvgZR9u+NLEOnS2+hQiY5HCWa4sNdV1tFzLzwjojCTkfViW6IPBJgQBQmD9353mqZ+m6
         oXYUHXjKx1Yv3rLau8bOQW3te087rGZ5hOEtWYVNOMtRdKVT4AXHro32c3l+/zITpiNP
         P8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550916; x=1732155716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FbTT42ntRqTX7F9UxQU0NN8E/7QETZOJXWenNOfNwA=;
        b=WrPpn8+hod1T8ln1NEO7x/5jbEH5xK3+ASO8b9UnpZImL3UNwv92svrIIinL4Wjmi7
         WiNMQDMRgGu5D2uW/llWQLrLcu25P2O33ZrGL2RCDx0zh/pjHfX8wNacGWlxsMP5EV0V
         Jtz7KTOzA8O2h3Gh9nb29C41McHDlnv/7gCsAGTWL6dqTVxGafXXIp98DZ5uYamQXSI0
         BJsdxG/0Q7tb7+tPjo9PvkSlMjZ9g4ZWT+xRXphntU0tLwOMqPCSIxSRhTmt2ISFWICk
         fhv+ufSvKy8OA0ATlQvDaXel1DitLc6PqqHta2dgJ4E+iEeN4BmcDLgfH4MLivBGDoDN
         diIg==
X-Forwarded-Encrypted: i=1; AJvYcCXoO+Nwd+SK/ki7RRUrAJOrjq+vsMYnmPTBzO6POesOkMsA6GlLCkcNTVpcroWyn589Db3zLwWB3OU8PoDsECA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Yy1da2cl8pek+X4cQNpq4D+H1E6RL3sYKQp6BRxjiWzNNQSx
	dFsPcTOSd5oj7+OP5huAcBSOjvLmGXVPVuaNSDmsBVSZ+Jahq2W7SZN3ibg8uC0=
X-Google-Smtp-Source: AGHT+IEjA7pSur9RnBVtnf9C2L0U6Pfdz6QFJIAnaWP82wpHX2kTy3qO334YbFkE0daF1V/+756Ogw==
X-Received: by 2002:a17:90b:17c8:b0:2e7:8593:8365 with SMTP id 98e67ed59e1d1-2e9b16f05e9mr28920476a91.5.1731550915657;
        Wed, 13 Nov 2024 18:21:55 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:54 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:18 -0800
Subject: [PATCH v11 12/14] selftests: riscv: Fix vector tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-12-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19766; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=gb3C6KzMXc7O9n5RgIZ+oQYrGbjWeFuXLSOVe7rZJ5E=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3KLUB6Istns+OrE1X9ExmJghX+jy0nuJb3uHopCd7
 cqQ1NMdpSwMYhwMsmKKLDzXGphb7+iXHRUtmwAzh5UJZAgDF6cATORmFMNfcZ5Chfyk/lrZIPv7
 Aou7CgxSltp3y/Bwdz+2WTR3dsQaRoY3EQnnVT9ElAk3WS1f+uNcjeuppTc6rm9iKm43jjoWHMo
 LAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Overhaul the riscv vector tests to use kselftest_harness to help the
test cases correctly report the results and decouple the individual test
cases from each other. With this refactoring, only run the test cases if
vector is reported and properly report the test case as skipped
otherwise. The v_initval_nolibc test was previously not checking if
vector was supported and used a function (malloc) which invalidates
the state of the vector registers.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  85 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  57 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   6 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  16 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 278 ++++++++++++---------
 8 files changed, 337 insertions(+), 193 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
index 9ae7964491d5..7d9c87cd0649 100644
--- a/tools/testing/selftests/riscv/vector/.gitignore
+++ b/tools/testing/selftests/riscv/vector/.gitignore
@@ -1,3 +1,4 @@
 vstate_exec_nolibc
 vstate_prctl
-v_initval_nolibc
+v_initval
+v_exec_initval_nolibc
diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index bfff0ff4f3be..6f7497f4e7b3 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,18 +2,27 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := vstate_prctl v_initval_nolibc
-TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc
+TEST_GEN_PROGS := v_initval vstate_prctl
+TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
 
 include ../../lib.mk
 
-$(OUTPUT)/vstate_prctl: vstate_prctl.c ../hwprobe/sys_hwprobe.S
+$(OUTPUT)/sys_hwprobe.o: ../hwprobe/sys_hwprobe.S
+	$(CC) -static -c -o$@ $(CFLAGS) $^
+
+$(OUTPUT)/v_helpers.o: v_helpers.c
+	$(CC) -static -c -o$@ $(CFLAGS) $^
+
+$(OUTPUT)/vstate_prctl: vstate_prctl.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
 
 $(OUTPUT)/vstate_exec_nolibc: vstate_exec_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
 
-$(OUTPUT)/v_initval_nolibc: v_initval_nolibc.c
+$(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
+
+$(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
new file mode 100644
index 000000000000..4a39cab29c34
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Get values of vector registers as soon as the program starts to test if
+ * is properly cleaning the values before starting a new program. Vector
+ * registers are caller saved, so no function calls may happen before reading
+ * the values. To further ensure consistency, this file is compiled without
+ * libc and without auto-vectorization.
+ *
+ * To be "clean" all values must be either all ones or all zeroes.
+ */
+
+#define __stringify_1(x...)	#x
+#define __stringify(x...)	__stringify_1(x)
+
+int main(int argc, char **argv)
+{
+	char prev_value = 0, value;
+	unsigned long vl;
+	int first = 1;
+
+	asm volatile (
+		".option push\n\t"
+		".option arch, +v\n\t"
+		"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
+		".option pop\n\t"
+		: [vl] "=r" (vl)
+	);
+
+#define CHECK_VECTOR_REGISTER(register) ({					\
+	for (int i = 0; i < vl; i++) {						\
+		asm volatile (							\
+			".option push\n\t"					\
+			".option arch, +v\n\t"					\
+			"vmv.x.s %0, " __stringify(register) "\n\t"		\
+			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
+			".option pop\n\t"					\
+			: "=r" (value));					\
+		if (first) {							\
+			first = 0;						\
+		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
+			printf("Register " __stringify(register)		\
+				" values not clean! value: %u\n", value);	\
+			exit(-1);						\
+		}								\
+		prev_value = value;						\
+	}									\
+})
+
+	CHECK_VECTOR_REGISTER(v0);
+	CHECK_VECTOR_REGISTER(v1);
+	CHECK_VECTOR_REGISTER(v2);
+	CHECK_VECTOR_REGISTER(v3);
+	CHECK_VECTOR_REGISTER(v4);
+	CHECK_VECTOR_REGISTER(v5);
+	CHECK_VECTOR_REGISTER(v6);
+	CHECK_VECTOR_REGISTER(v7);
+	CHECK_VECTOR_REGISTER(v8);
+	CHECK_VECTOR_REGISTER(v9);
+	CHECK_VECTOR_REGISTER(v10);
+	CHECK_VECTOR_REGISTER(v11);
+	CHECK_VECTOR_REGISTER(v12);
+	CHECK_VECTOR_REGISTER(v13);
+	CHECK_VECTOR_REGISTER(v14);
+	CHECK_VECTOR_REGISTER(v15);
+	CHECK_VECTOR_REGISTER(v16);
+	CHECK_VECTOR_REGISTER(v17);
+	CHECK_VECTOR_REGISTER(v18);
+	CHECK_VECTOR_REGISTER(v19);
+	CHECK_VECTOR_REGISTER(v20);
+	CHECK_VECTOR_REGISTER(v21);
+	CHECK_VECTOR_REGISTER(v22);
+	CHECK_VECTOR_REGISTER(v23);
+	CHECK_VECTOR_REGISTER(v24);
+	CHECK_VECTOR_REGISTER(v25);
+	CHECK_VECTOR_REGISTER(v26);
+	CHECK_VECTOR_REGISTER(v27);
+	CHECK_VECTOR_REGISTER(v28);
+	CHECK_VECTOR_REGISTER(v29);
+	CHECK_VECTOR_REGISTER(v30);
+	CHECK_VECTOR_REGISTER(v31);
+
+#undef CHECK_VECTOR_REGISTER
+
+	return 0;
+}
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.c b/tools/testing/selftests/riscv/vector/v_helpers.c
new file mode 100644
index 000000000000..d50f4dfbf9e5
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../hwprobe/hwprobe.h"
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+bool is_vector_supported(void)
+{
+	struct riscv_hwprobe pair;
+
+	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	return pair.value & RISCV_HWPROBE_EXT_ZVE32X;
+}
+
+int launch_test(char *next_program, int test_inherit)
+{
+	char *exec_argv[3], *exec_envp[1];
+	int rc, pid, status;
+
+	pid = fork();
+	if (pid < 0) {
+		printf("fork failed %d", pid);
+		return -1;
+	}
+
+	if (!pid) {
+		exec_argv[0] = next_program;
+		exec_argv[1] = test_inherit != 0 ? "x" : NULL;
+		exec_argv[2] = NULL;
+		exec_envp[0] = NULL;
+		/* launch the program again to check inherit */
+		rc = execve(next_program, exec_argv, exec_envp);
+		if (rc) {
+			perror("execve");
+			printf("child execve failed %d\n", rc);
+			exit(-1);
+		}
+	}
+
+	rc = waitpid(-1, &status, 0);
+	if (rc < 0) {
+		printf("waitpid failed\n");
+		return -3;
+	}
+
+	if ((WIFEXITED(status) && WEXITSTATUS(status) == -1) ||
+	    WIFSIGNALED(status)) {
+		printf("child exited abnormally\n");
+		return -4;
+	}
+
+	return WEXITSTATUS(status);
+}
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.h b/tools/testing/selftests/riscv/vector/v_helpers.h
new file mode 100644
index 000000000000..faeeeb625b6e
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_helpers.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <stdbool.h>
+
+bool is_vector_supported(void);
+
+int launch_test(char *next_program, int test_inherit);
diff --git a/tools/testing/selftests/riscv/vector/v_initval.c b/tools/testing/selftests/riscv/vector/v_initval.c
new file mode 100644
index 000000000000..f38b5797fa31
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_initval.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest_harness.h"
+#include "v_helpers.h"
+
+#define NEXT_PROGRAM "./v_exec_initval_nolibc"
+
+TEST(v_initval)
+{
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	ASSERT_EQ(0, launch_test(NEXT_PROGRAM, 0));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
deleted file mode 100644
index 1dd94197da30..000000000000
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include "../../kselftest.h"
-#define MAX_VSIZE	(8192 * 32)
-
-void dump(char *ptr, int size)
-{
-	int i = 0;
-
-	for (i = 0; i < size; i++) {
-		if (i != 0) {
-			if (i % 16 == 0)
-				printf("\n");
-			else if (i % 8 == 0)
-				printf("  ");
-		}
-		printf("%02x ", ptr[i]);
-	}
-	printf("\n");
-}
-
-int main(void)
-{
-	int i;
-	unsigned long vl;
-	char *datap, *tmp;
-
-	datap = malloc(MAX_VSIZE);
-	if (!datap) {
-		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
-		exit(-1);
-	}
-
-	tmp = datap;
-	asm volatile (
-		".option push\n\t"
-		".option arch, +v\n\t"
-		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
-		"vse8.v		v0, (%2)\n\t"
-		"add		%1, %2, %0\n\t"
-		"vse8.v		v8, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vse8.v		v16, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vse8.v		v24, (%1)\n\t"
-		".option pop\n\t"
-		: "=&r" (vl), "=r" (tmp) : "r" (datap) : "memory");
-
-	ksft_print_msg("vl = %lu\n", vl);
-
-	if (datap[0] != 0x00 && datap[0] != 0xff) {
-		ksft_test_result_fail("v-regesters are not properly initialized\n");
-		dump(datap, vl * 4);
-		exit(-1);
-	}
-
-	for (i = 1; i < vl * 4; i++) {
-		if (datap[i] != datap[0]) {
-			ksft_test_result_fail("detect stale values on v-regesters\n");
-			dump(datap, vl * 4);
-			exit(-2);
-		}
-	}
-
-	free(datap);
-	ksft_exit_pass();
-	return 0;
-}
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 895177f6bf4c..2fc86924bf42 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -3,50 +3,13 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <stdlib.h>
 
-#include "../hwprobe/hwprobe.h"
-#include "../../kselftest.h"
+#include "../../kselftest_harness.h"
+#include "v_helpers.h"
 
 #define NEXT_PROGRAM "./vstate_exec_nolibc"
-static int launch_test(int test_inherit)
-{
-	char *exec_argv[3], *exec_envp[1];
-	int rc, pid, status;
-
-	pid = fork();
-	if (pid < 0) {
-		ksft_test_result_fail("fork failed %d", pid);
-		return -1;
-	}
-
-	if (!pid) {
-		exec_argv[0] = NEXT_PROGRAM;
-		exec_argv[1] = test_inherit != 0 ? "x" : NULL;
-		exec_argv[2] = NULL;
-		exec_envp[0] = NULL;
-		/* launch the program again to check inherit */
-		rc = execve(NEXT_PROGRAM, exec_argv, exec_envp);
-		if (rc) {
-			perror("execve");
-			ksft_test_result_fail("child execve failed %d\n", rc);
-			exit(-1);
-		}
-	}
-
-	rc = waitpid(-1, &status, 0);
-	if (rc < 0) {
-		ksft_test_result_fail("waitpid failed\n");
-		return -3;
-	}
-
-	if ((WIFEXITED(status) && WEXITSTATUS(status) == -1) ||
-	    WIFSIGNALED(status)) {
-		ksft_test_result_fail("child exited abnormally\n");
-		return -4;
-	}
-
-	return WEXITSTATUS(status);
-}
 
 int test_and_compare_child(long provided, long expected, int inherit)
 {
@@ -54,128 +17,203 @@ int test_and_compare_child(long provided, long expected, int inherit)
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, provided);
 	if (rc != 0) {
-		ksft_test_result_fail("prctl with provided arg %lx failed with code %d\n",
-				      provided, rc);
+		printf("prctl with provided arg %lx failed with code %d\n",
+		       provided, rc);
 		return -1;
 	}
-	rc = launch_test(inherit);
+	rc = launch_test(NEXT_PROGRAM, inherit);
 	if (rc != expected) {
-		ksft_test_result_fail("Test failed, check %d != %ld\n", rc,
-				      expected);
+		printf("Test failed, check %d != %ld\n", rc, expected);
 		return -2;
 	}
 	return 0;
 }
 
-#define PR_RISCV_V_VSTATE_CTRL_CUR_SHIFT	0
-#define PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT	2
+#define PR_RISCV_V_VSTATE_CTRL_CUR_SHIFT 0
+#define PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT 2
 
-int main(void)
+TEST(get_control_no_v)
 {
-	struct riscv_hwprobe pair;
-	long flag, expected;
 	long rc;
 
-	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
-	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
-	if (rc < 0) {
-		ksft_test_result_fail("hwprobe() failed with %ld\n", rc);
-		return -1;
-	}
+	if (is_vector_supported())
+		SKIP(return, "Test expects vector to be not supported");
 
-	if (pair.key != RISCV_HWPROBE_KEY_IMA_EXT_0) {
-		ksft_test_result_fail("hwprobe cannot probe RISCV_HWPROBE_KEY_IMA_EXT_0\n");
-		return -2;
-	}
+	rc = prctl(PR_RISCV_V_GET_CONTROL);
+	EXPECT_EQ(-1, rc)
+	TH_LOG("GET_CONTROL should fail on kernel/hw without ZVE32X");
+	EXPECT_EQ(EINVAL, errno)
+	TH_LOG("GET_CONTROL should fail on kernel/hw without ZVE32X");
+}
 
-	if (!(pair.value & RISCV_HWPROBE_EXT_ZVE32X)) {
-		rc = prctl(PR_RISCV_V_GET_CONTROL);
-		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without ZVE32X\n");
-			return -3;
-		}
-
-		rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
-		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("SET_CONTROL should fail on kernel/hw without ZVE32X\n");
-			return -4;
-		}
-
-		ksft_test_result_skip("Vector not supported\n");
-		return 0;
-	}
+TEST(set_control_no_v)
+{
+	long rc;
+
+	if (is_vector_supported())
+		SKIP(return, "Test expects vector to be not supported");
+
+	rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
+	EXPECT_EQ(-1, rc)
+	TH_LOG("SET_CONTROL should fail on kernel/hw without ZVE32X");
+	EXPECT_EQ(EINVAL, errno)
+	TH_LOG("SET_CONTROL should fail on kernel/hw without ZVE32X");
+}
+
+TEST(vstate_on_current)
+{
+	long flag;
+	long rc;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_ON;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	if (rc != 0) {
-		ksft_test_result_fail("Enabling V for current should always success\n");
-		return -5;
-	}
+	EXPECT_EQ(0, rc) TH_LOG("Enabling V for current should always success");
+}
+
+TEST(vstate_off_eperm)
+{
+	long flag;
+	long rc;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	if (rc != -1 || errno != EPERM) {
-		ksft_test_result_fail("Disabling current's V alive must fail with EPERM(%d)\n",
-				      errno);
-		return -5;
-	}
+	EXPECT_EQ(EPERM, errno)
+	TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
+	EXPECT_EQ(-1, rc)
+	TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
+}
+
+TEST(vstate_on_no_nesting)
+{
+	long flag;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	/* Turn on next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
-	if (test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0))
-		return -6;
+
+	EXPECT_EQ(0,
+		  test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0));
+}
+
+TEST(vstate_off_nesting)
+{
+	long flag;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	/* Turn off next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
-	if (test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 0))
-		return -7;
+
+	EXPECT_EQ(0,
+		  test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 1));
+}
+
+TEST(vstate_on_inherit_no_nesting)
+{
+	long flag, expected;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	/* Turn on next's vector explicitly and test no inherit */
+	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
+	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
+	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
+
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+}
+
+TEST(vstate_on_inherit)
+{
+	long flag, expected;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	/* Turn on next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
-	if (test_and_compare_child(flag, expected, 0))
-		return -8;
 
-	if (test_and_compare_child(flag, expected, 1))
-		return -9;
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+}
+
+TEST(vstate_off_inherit_no_nesting)
+{
+	long flag, expected;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	/* Turn off next's vector explicitly and test no inherit */
+	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
+	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
+	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
+
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+}
+
+TEST(vstate_off_inherit)
+{
+	long flag, expected;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	/* Turn off next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
-	if (test_and_compare_child(flag, expected, 0))
-		return -10;
 
-	if (test_and_compare_child(flag, expected, 1))
-		return -11;
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+}
+
+/* arguments should fail with EINVAL */
+TEST(inval_set_control_1)
+{
+	int rc;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
-	/* arguments should fail with EINVAL */
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xff0);
-	if (rc != -1 || errno != EINVAL) {
-		ksft_test_result_fail("Undefined control argument should return EINVAL\n");
-		return -12;
-	}
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+/* arguments should fail with EINVAL */
+TEST(inval_set_control_2)
+{
+	int rc;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0x3);
-	if (rc != -1 || errno != EINVAL) {
-		ksft_test_result_fail("Undefined control argument should return EINVAL\n");
-		return -12;
-	}
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
 
-	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xc);
-	if (rc != -1 || errno != EINVAL) {
-		ksft_test_result_fail("Undefined control argument should return EINVAL\n");
-		return -12;
-	}
+/* arguments should fail with EINVAL */
+TEST(inval_set_control_3)
+{
+	int rc;
 
-	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xc);
-	if (rc != -1 || errno != EINVAL) {
-		ksft_test_result_fail("Undefined control argument should return EINVAL\n");
-		return -12;
-	}
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
 
-	ksft_test_result_pass("tests for riscv_v_vstate_ctrl pass\n");
-	ksft_exit_pass();
-	return 0;
+	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xc);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
 }
+
+TEST_HARNESS_MAIN

-- 
2.34.1


