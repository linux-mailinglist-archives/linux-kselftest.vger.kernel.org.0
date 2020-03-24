Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA11913A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgCXOvp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 10:51:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbgCXOvo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 10:51:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2941045;
        Tue, 24 Mar 2020 07:51:38 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A860B3F52E;
        Tue, 24 Mar 2020 07:51:37 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] kselftest: Extend vDSO selftest
Date:   Tue, 24 Mar 2020 14:51:19 +0000
Message-Id: <20200324145120.42194-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324145120.42194-1-vincenzo.frascino@arm.com>
References: <20200324145120.42194-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current version of the multiarch vDSO selftest verifies only
gettimeofday.

Extend the vDSO selftest to the other library functions:
 - time
 - clock_getres
 - clock_gettime

The extension has been used to verify the unified vdso library on the
supported architectures.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 tools/testing/selftests/vDSO/vdso_config.h    |  90 +++++++
 tools/testing/selftests/vDSO/vdso_full_test.c | 244 ++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_config.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 2989e4d5a730..46aab4eaccbd 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS += $(OUTPUT)/vdso_full_test
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -17,6 +18,7 @@ endif
 
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_full_test: parse_vdso.c vdso_full_test.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
new file mode 100644
index 000000000000..eeb725df6045
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * vdso_config.h: Configuration options for vDSO tests.
+ * Copyright (c) 2019 Arm Ltd.
+ */
+#ifndef __VDSO_CONFIG_H__
+#define __VDSO_CONFIG_H__
+
+/*
+ * Each architecture exports its vDSO implementation with different names
+ * and a different version from the others, so we need to handle it as a
+ * special case.
+ */
+#if defined(__arm__)
+#define VDSO_VERSION		0
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#elif defined(__aarch64__)
+#define VDSO_VERSION		3
+#define VDSO_NAMES		0
+#elif defined(__powerpc__)
+#define VDSO_VERSION		1
+#define VDSO_NAMES		0
+#define VDSO_32BIT		1
+#elif defined(__powerpc64__)
+#define VDSO_VERSION		1
+#define VDSO_NAMES		0
+#elif defined (__s390__)
+#define VDSO_VERSION		2
+#define VDSO_NAMES		0
+#define VDSO_32BIT		1
+#elif defined (__s390X__)
+#define VDSO_VERSION		2
+#define VDSO_NAMES		0
+#elif defined(__mips__)
+#define VDSO_VERSION		0
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#elif defined(__sparc__)
+#define VDSO_VERSION		0
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#elif defined(__i386__)
+#define VDSO_VERSION		0
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#elif defined(__x86_64__)
+#define VDSO_VERSION		0
+#define VDSO_NAMES		1
+#elif defined(__riscv__)
+#define VDSO_VERSION		5
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#else /* nds32 */
+#define VDSO_VERSION		4
+#define VDSO_NAMES		1
+#define VDSO_32BIT		1
+#endif
+
+static const char *versions[6] = {
+	"LINUX_2.6",
+	"LINUX_2.6.15",
+	"LINUX_2.6.29",
+	"LINUX_2.6.39",
+	"LINUX_4",
+	"LINUX_4.15",
+};
+
+static const char *names[2][5] = {
+	{
+		"__kernel_gettimeofday",
+		"__kernel_clock_gettime",
+		"__kernel_time",
+		"__kernel_clock_getres",
+#if defined(VDSO_32BIT)
+		"__kernel_clock_gettime64",
+#endif
+	},
+	{
+		"__vdso_gettimeofday",
+		"__vdso_clock_gettime",
+		"__vdso_time",
+		"__vdso_clock_getres",
+#if defined(VDSO_32BIT)
+		"__vdso_clock_gettime64",
+#endif
+	},
+};
+
+#endif /* __VDSO_CONFIG_H__ */
diff --git a/tools/testing/selftests/vDSO/vdso_full_test.c b/tools/testing/selftests/vDSO/vdso_full_test.c
new file mode 100644
index 000000000000..3d603f1394af
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_full_test.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vdso_full_test.c: Sample code to test all the timers.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_full_test.c parse_vdso.c
+ *
+ */
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+#include "vdso_config.h"
+
+extern void *vdso_sym(const char *version, const char *name);
+extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+extern void vdso_init_from_auxv(void *auxv);
+
+static const char *version;
+static const char **name;
+
+typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
+typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
+typedef time_t (*vdso_time_t)(time_t *t);
+
+static int vdso_test_gettimeofday(void)
+{
+	/* Find gettimeofday. */
+	vdso_gettimeofday_t vdso_gettimeofday =
+		(vdso_gettimeofday_t)vdso_sym(version, name[0]);
+
+	if (!vdso_gettimeofday) {
+		printf("Could not find %s\n", name[0]);
+		return KSFT_SKIP;
+	}
+
+	struct timeval tv;
+	long ret = vdso_gettimeofday(&tv, 0);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)tv.tv_sec, (long long)tv.tv_usec);
+	} else {
+		printf("%s failed\n", name[0]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_clock_gettime(clockid_t clk_id)
+{
+	/* Find clock_gettime. */
+	vdso_clock_gettime_t vdso_clock_gettime =
+		(vdso_clock_gettime_t)vdso_sym(version, name[1]);
+
+	if (!vdso_clock_gettime) {
+		printf("Could not find %s\n", name[1]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts;
+	long ret = vdso_clock_gettime(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[1]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_time(void)
+{
+	/* Find time. */
+	vdso_time_t vdso_time =
+		(vdso_time_t)vdso_sym(version, name[2]);
+
+	if (!vdso_time) {
+		printf("Could not find %s\n", name[2]);
+		return KSFT_SKIP;
+	}
+
+	long ret = vdso_time(NULL);
+
+	if (ret > 0) {
+		printf("The time in hours since January 1, 1970 is %lld\n",
+				(long long)(ret / 3600));
+	} else {
+		printf("%s failed\n", name[2]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_clock_getres(clockid_t clk_id)
+{
+	/* Find clock_getres. */
+	vdso_clock_getres_t vdso_clock_getres =
+		(vdso_clock_getres_t)vdso_sym(version, name[3]);
+
+	if (!vdso_clock_getres) {
+		printf("Could not find %s\n", name[3]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts, sys_ts;
+	long ret = vdso_clock_getres(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The resolution is %lld %lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+
+	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec)) {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+const char *vdso_clock_name[12] = {
+	"CLOCK_REALTIME",
+	"CLOCK_MONOTONIC",
+	"CLOCK_PROCESS_CPUTIME_ID",
+	"CLOCK_THREAD_CPUTIME_ID",
+	"CLOCK_MONOTONIC_RAW",
+	"CLOCK_REALTIME_COARSE",
+	"CLOCK_MONOTONIC_COARSE",
+	"CLOCK_BOOTTIME",
+	"CLOCK_REALTIME_ALARM",
+	"CLOCK_BOOTTIME_ALARM",
+	"CLOCK_SGI_CYCLE",
+	"CLOCK_TAI",
+};
+
+/*
+ * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
+ * with different values for clock_id.
+ */
+static inline int vdso_test_clock(clockid_t clock_id)
+{
+	int ret0, ret1;
+
+	ret0 = vdso_test_clock_gettime(clock_id);
+	/* A skipped test is considered passed */
+	if (ret0 == KSFT_SKIP)
+		ret0 = KSFT_PASS;
+
+	ret1 = vdso_test_clock_getres(clock_id);
+	/* A skipped test is considered passed */
+	if (ret1 == KSFT_SKIP)
+		ret1 = KSFT_PASS;
+
+	ret0 += ret1;
+
+	printf("clock_id: %s", vdso_clock_name[clock_id]);
+
+	if (ret0 > 0)
+		printf(" [FAIL]\n");
+	else
+		printf(" [PASS]\n");
+
+	return ret0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	int ret;
+
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	version = versions[VDSO_VERSION];
+	name = (const char **)&names[VDSO_NAMES];
+
+	printf("[vDSO kselftest] VDSO_VERSION: %s\n", version);
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	ret = vdso_test_gettimeofday();
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	ret += vdso_test_clock(CLOCK_REALTIME);
+#endif
+
+#ifdef CLOCK_BOOTTIME
+	ret += vdso_test_clock(CLOCK_BOOTTIME);
+#endif
+
+#ifdef CLOCK_TAI
+	ret += vdso_test_clock(CLOCK_TAI);
+#endif
+
+#ifdef CLOCK_REALTIME_COARSE
+	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
+#endif
+
+#ifdef CLOCK_MONOTONIC
+	ret += vdso_test_clock(CLOCK_MONOTONIC);
+#endif
+
+#ifdef CLOCK_MONOTONIC_RAW
+	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
+#endif
+
+#ifdef CLOCK_MONOTONIC_COARSE
+	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+#endif
+
+#endif
+
+	ret += vdso_test_time();
+
+	if (ret > 0)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
-- 
2.25.2

