Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D9D1C5F4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgEERva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 13:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbgEERv2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 13:51:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EEE1206B9;
        Tue,  5 May 2020 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588701087;
        bh=r1NrOndU3YS+eWt28dmHa/oAPjSkGoQJ/pvTSw5jq/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t75d5toBn8C/owlGNazWmDP3BOtSidvPKmezqRfAnkoUhyPEKiECNOJcaD1L92pfh
         DBiQkwplUzakgMjJ5CEZYZah0kCNyLGFumEqJfbrWFbpPe8YMImoQ988s5GGXyaA9i
         EKijL/urhdBf9031GrTJDZoeIOAHVryPi6aP4bZo=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
Date:   Tue,  5 May 2020 18:47:28 +0100
Message-Id: <20200505174728.46594-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505174728.46594-1-broonie@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
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
 .../testing/selftests/vDSO/vdso_test_getcpu.c | 50 +++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
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
index 000000000000..a9dd3db145f3
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -0,0 +1,50 @@
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
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	getcpu_t get_cpu = (getcpu_t)vdso_sym(version, name);
+	if (!get_cpu) {
+		printf("Could not find %s\n", name);
+		return KSFT_SKIP;
+	}
+
+	unsigned int cpu, node;
+	long ret = get_cpu(&cpu, &node, 0);
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

