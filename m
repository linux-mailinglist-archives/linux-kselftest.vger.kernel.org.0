Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE05E1DED22
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEVQVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbgEVQVw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:21:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641E820756;
        Fri, 22 May 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164512;
        bh=Stxmy5bjtizNU8Nx6Mslgp2T+FmzRshtXGRDcZodBIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nC4Fjt+V7HSlwjlv0oD9X6Q57rCFAoKe3tDUwZ/ilw9ZqYEeo4MQvTQUKfqltWNZU
         ZvlSMpOgOBOdSkyaGvbU2DCc/mOPKbpIA38cIkaphdqCnNy8ek0wD/1Z2edlJoZpQI
         yopvNB09RWTBE/0xHkUwmO81x8Su1mx4f4KM5nFQ=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
Date:   Fri, 22 May 2020 17:21:39 +0100
Message-Id: <20200522162139.44380-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522162139.44380-1-broonie@kernel.org>
References: <20200522162139.44380-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide a very basic selftest for getcpu() which similarly to our existing
test for gettimeofday() looks up the function in the vDSO and prints the
results it gets if the function exists and succeeds.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/.gitignore       |  1 +
 tools/testing/selftests/vDSO/Makefile         |  3 +-
 .../testing/selftests/vDSO/vdso_test_getcpu.c | 54 +++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getcpu.c

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 74f49bd5f6dd..5eb64d41e541 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
 vdso_test_gettimeofday
+vdso_test_getcpu
 vdso_standalone_test_x86
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index ae15d700b62e..0069f2f83f86 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,7 @@ include ../lib.mk
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday
+TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -18,6 +18,7 @@ endif
 
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
+$(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
new file mode 100644
index 000000000000..fc25ede131b8
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vdso_test_getcpu.c: Sample code to test parse_vdso.c and vDSO getcpu()
+ *
+ * Copyright (c) 2020 Arm Ltd
+ */
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+
+#include "../kselftest.h"
+#include "parse_vdso.h"
+
+const char *version = "LINUX_2.6";
+const char *name = "__vdso_getcpu";
+
+struct getcpu_cache;
+typedef long (*getcpu_t)(unsigned int *, unsigned int *,
+			 struct getcpu_cache *);
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr;
+	unsigned int cpu, node;
+	getcpu_t get_cpu;
+	long ret;
+
+	sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	get_cpu = (getcpu_t)vdso_sym(version, name);
+	if (!get_cpu) {
+		printf("Could not find %s\n", name);
+		return KSFT_SKIP;
+	}
+
+	ret = get_cpu(&cpu, &node, 0);
+	if (ret == 0) {
+		printf("Running on CPU %u node %u\n", cpu, node);
+	} else {
+		printf("%s failed\n", name);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
-- 
2.20.1

