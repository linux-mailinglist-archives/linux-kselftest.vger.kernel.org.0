Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987681DED20
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgEVQVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVQVt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:21:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580AF2070A;
        Fri, 22 May 2020 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164508;
        bh=g3UdUTQMH/yzAnPPAs0/Cm8ryI0Ks4xGB7coM2wy1y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3labHkV1TX9HgGRNPRaCzV2Pt58cpvpm7cOy2jZgyPlBplZbSUUwbcu+mjSz6Tno
         j3Qk9ach8zXoWaUivr7HpnD9OAUrsbQ5Rz+fqaW/OwEyo6wzD27JtJC9n0r384kuB/
         CStcNx+Xe8Ca0k1Hp22Ve6Yos4pfJAZRZPJYKtEg=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/3] selftests: vdso: Use a header file to prototype parse_vdso API
Date:   Fri, 22 May 2020 17:21:38 +0100
Message-Id: <20200522162139.44380-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522162139.44380-1-broonie@kernel.org>
References: <20200522162139.44380-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both vdso_test_gettimeofday and vdso_standalone_test_x86 use the library in
parse_vdso.c but each separately declares the API it offers which is not
ideal. Create a header file with prototypes of the functions and use it in
both the library and the tests to ensure that the same prototypes are used
throughout.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/parse_vdso.c     | 24 +-------------
 tools/testing/selftests/vDSO/parse_vdso.h     | 31 +++++++++++++++++++
 .../selftests/vDSO/vdso_standalone_test_x86.c |  4 +--
 .../selftests/vDSO/vdso_test_gettimeofday.c   |  5 +--
 4 files changed, 34 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/parse_vdso.h

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 1dbb4b87268f..413f75620a35 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -21,29 +21,7 @@
 #include <limits.h>
 #include <elf.h>
 
-/*
- * To use this vDSO parser, first call one of the vdso_init_* functions.
- * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
- * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
- * Then call vdso_sym for each symbol you want.  For example, to look up
- * gettimeofday on x86_64, use:
- *
- *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
- * or
- *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
- *
- * vdso_sym will return 0 if the symbol doesn't exist or if the init function
- * failed or was not called.  vdso_sym is a little slow, so its return value
- * should be cached.
- *
- * vdso_sym is threadsafe; the init functions are not.
- *
- * These are the prototypes:
- */
-extern void vdso_init_from_auxv(void *auxv);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void *vdso_sym(const char *version, const char *name);
-
+#include "parse_vdso.h"
 
 /* And here's the code. */
 #ifndef ELF_BITS
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selftests/vDSO/parse_vdso.h
new file mode 100644
index 000000000000..de0453067d7c
--- /dev/null
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef PARSE_VDSO_H
+#define PARSE_VDSO_H
+
+#include <stdint.h>
+
+/*
+ * To use this vDSO parser, first call one of the vdso_init_* functions.
+ * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
+ * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
+ * Then call vdso_sym for each symbol you want.  For example, to look up
+ * gettimeofday on x86_64, use:
+ *
+ *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
+ * or
+ *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
+ *
+ * vdso_sym will return 0 if the symbol doesn't exist or if the init function
+ * failed or was not called.  vdso_sym is a little slow, so its return value
+ * should be cached.
+ *
+ * vdso_sym is threadsafe; the init functions are not.
+ *
+ * These are the prototypes:
+ */
+void *vdso_sym(const char *version, const char *name);
+void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+void vdso_init_from_auxv(void *auxv);
+
+#endif
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 5ac4b00acfbc..8a44ff973ee1 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -16,9 +16,7 @@
 #include <unistd.h>
 #include <stdint.h>
 
-extern void *vdso_sym(const char *version, const char *name);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void vdso_init_from_auxv(void *auxv);
+#include "parse_vdso.h"
 
 /* We need a libc functions... */
 int strcmp(const char *a, const char *b)
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 511c0dc5e47e..8ccc73ed8240 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -17,10 +17,7 @@
 #include <sys/time.h>
 
 #include "../kselftest.h"
-
-extern void *vdso_sym(const char *version, const char *name);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void vdso_init_from_auxv(void *auxv);
+#include "parse_vdso.h"
 
 /*
  * ARM64's vDSO exports its gettimeofday() implementation with a different
-- 
2.20.1

