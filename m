Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9872DB53B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgLOUgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 15:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgLOUgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 15:36:14 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B4C06179C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 12:35:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r9so21835590ioo.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 12:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=1OrrAqHNrkHdULfBKgPxbqGsTV1yvQrDH/F69wTbfJU=;
        b=LDlputcK9a7thimEVF6XMaSysCMzU7v/UBit5SAMp9pjmrgEMaHiXdzVT8w1eVcXEE
         WnB+BHI9rRIHTUJHgP1FbciaDZHSoEHK7koxHP53OaAZXhHdJL+jlj6U3HsPObO8my+9
         cdikRTXCNMUxm7RjUYlIMJn1U87u/W8oVa1fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=1OrrAqHNrkHdULfBKgPxbqGsTV1yvQrDH/F69wTbfJU=;
        b=eHp0urmAx4VylMt/lfBayiQrl7sWQUUw1T1GCyjzhJklSrESx3SR8OF++J7oYMvFPj
         Lqp19mur80MLVgYIC32af1rqjGZuHaHtK3wWU4IfAAJSfCZaxLDS8kYEWKuWuRWd7I2C
         gRdQHfLsG19MQFIL7sDDu4rl4ZYRxCgANPZpuTzNt2Tuy7gGd4HcgO4bJcRrrwHiMLtl
         tGhonnzwxqIJo/+dTF9dbETgL1NoEHOsXwutRWMsC1q3VZ8r2U0Zv/W6KxjXXTdeL1EI
         TzThz58sRWIMsCVxCVZq5XKfXeM2F3eAc78BHZz3Sjdt27JLuzDWpRK445uJ5jY3J6lX
         kD/A==
X-Gm-Message-State: AOAM5312fV53TGupj17wc8Qluaph+SUnpQs/KZWjSc/SpeDomDkA0j0A
        vBfS9faUsFh3Stb2sitGimzs0Q==
X-Google-Smtp-Source: ABdhPJz07iQ7EB7NnIzdc9PzlC5vya+5phlDRsQ6jfkNlgPCJXk3RsLrgCB9UGFMS0WIeKKGEJws7Q==
X-Received: by 2002:a6b:d21a:: with SMTP id q26mr39188022iob.128.1608064532735;
        Tue, 15 Dec 2020 12:35:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 143sm14315934ila.4.2020.12.15.12.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 12:35:31 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.11-rc1
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <60d232d5-30d8-3878-b525-491c4640d02c@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 13:35:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D073FA41C651D06259899F2F"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------D073FA41C651D06259899F2F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.11-rc1.

This kselftest update for Linux 5.11-rc1 consists of:

- Much needed gpio test Makefile cleanup to various problems with
   test dependencies and build errors from Michael Ellerman

- Enabling vDSO test on non x86 platforms from Vincenzo Frascino

- Fix intel_pstate to replace deprecated ftime() usages with
   clock_gettime() from Tommi Rantala

- cgroup test build fix on older releases from Sachin Sant

- A couple of spelling mistake fixes

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.11-rc1

for you to fetch changes up to c2e46f6b3e3551558d44c4dc518b9667cb0d5f8b:

   selftests/cgroup: Fix build on older distros (2020-11-10 15:13:25 -0700)

----------------------------------------------------------------
linux-kselftest-next-5.11-rc1

This kselftest update for Linux 5.11-rc1 consists of:

- Much needed gpio test Makefile cleanup to various problems with
   test dependencies and build errors from Michael Ellerman

- Enabling vDSO test on non x86 platforms from Vincenzo Frascino

- Fix intel_pstate to replace deprecated ftime() usages with
   clock_gettime() from Tommi Rantala

- cgroup test build fix on older releases from Sachin Sant

- A couple of spelling mistake fixes

----------------------------------------------------------------
Hangbin Liu (1):
       selftests/run_kselftest.sh: fix dry-run typo

Michael Ellerman (5):
       selftests/gpio: Use TEST_GEN_PROGS_EXTENDED
       selftests/gpio: Move include of lib.mk up
       selftests/gpio: Fix build when source tree is read only
       selftests/gpio: Add to CLEAN rule rather than overriding
       selftests/memfd: Fix implicit declaration warnings

Sachin Sant (1):
       selftests/cgroup: Fix build on older distros

Tommi Rantala (1):
       selftests: intel_pstate: ftime() is deprecated

Vincenzo Frascino (5):
       kselftest: Enable vDSO test on non x86 platforms
       kselftest: Extend vDSO selftest
       kselftest: Extend vDSO selftest to clock_getres
       kselftest: Move test_vdso to the vDSO test suite
       kselftest: Extend vdso correctness test to clock_gettime64

Wang Qing (1):
       tool: selftests: fix spelling typo of 'writting'

  tools/testing/selftests/Makefile                   |   1 +
  tools/testing/selftests/cgroup/cgroup_util.c       |   4 +-
tools/testing/selftests/gpio/Makefile              |  25 +--
  tools/testing/selftests/intel_pstate/aperf.c       |  22 +-
  tools/testing/selftests/memfd/fuse_test.c          |   2 +-
  tools/testing/selftests/memfd/memfd_test.c         |   2 +-
  tools/testing/selftests/run_kselftest.sh           |   2 +-
  tools/testing/selftests/vDSO/Makefile              |  16 +-
  tools/testing/selftests/vDSO/vdso_config.h         |  92 ++++++++
  tools/testing/selftests/vDSO/vdso_test_abi.c       | 244 
+++++++++++++++++++++
  .../selftests/vDSO/vdso_test_clock_getres.c        | 124 +++++++++++
  .../test_vdso.c => vDSO/vdso_test_correctness.c}   | 115 +++++++++-
  tools/testing/selftests/vm/userfaultfd.c           |   4 +-
  tools/testing/selftests/x86/Makefile               |   2 +-
  14 files changed, 621 insertions(+), 34 deletions(-)
  create mode 100644 tools/testing/selftests/vDSO/vdso_config.h
  create mode 100644 tools/testing/selftests/vDSO/vdso_test_abi.c
  create mode 100644 tools/testing/selftests/vDSO/vdso_test_clock_getres.c
  rename tools/testing/selftests/{x86/test_vdso.c => 
vDSO/vdso_test_correctness.c} (73%)

----------------------------------------------------------------

--------------D073FA41C651D06259899F2F
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.11-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.11-rc1.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..2dd60070d775 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -65,6 +65,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
+TARGETS += vDSO
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 05853b0b8831..027014662fb2 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -337,13 +337,13 @@ pid_t clone_into_cgroup(int cgroup_fd)
 #ifdef CLONE_ARGS_SIZE_VER2
 	pid_t pid;
 
-	struct clone_args args = {
+	struct __clone_args args = {
 		.flags = CLONE_INTO_CGROUP,
 		.exit_signal = SIGCHLD,
 		.cgroup = cgroup_fd,
 	};
 
-	pid = sys_clone3(&args, sizeof(struct clone_args));
+	pid = sys_clone3(&args, sizeof(struct __clone_args));
 	/*
 	 * Verify that this is a genuine test failure:
 	 * ENOSYS -> clone3() not available
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 32bdc978a711..41582fe485ee 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -11,22 +11,21 @@ LDLIBS += $(VAR_LDLIBS)
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_PROGS_EXTENDED := gpio-mockup-chardev
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-chardev
 
-GPIODIR := $(realpath ../../../gpio)
-GPIOOBJ := gpio-utils.o
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
 
-all: $(TEST_PROGS_EXTENDED)
+GPIODIR := $(realpath ../../../gpio)
+GPIOOUT := $(OUTPUT)/tools-gpio/
+GPIOOBJ := $(GPIOOUT)/gpio-utils.o
 
-override define CLEAN
-	$(RM) $(TEST_PROGS_EXTENDED)
-	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
-endef
+CLEAN += ; $(RM) -rf $(GPIOOUT)
 
-KSFT_KHDR_INSTALL := 1
-include ../lib.mk
+$(TEST_GEN_PROGS_EXTENDED): $(GPIOOBJ)
 
-$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
+$(GPIOOUT):
+	mkdir -p $@
 
-$(GPIODIR)/$(GPIOOBJ):
-	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
+$(GPIOOBJ): $(GPIOOUT)
+	$(MAKE) OUTPUT=$(GPIOOUT) -C $(GPIODIR)
diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index f6cd03a87493..a8acf3996973 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -10,8 +10,12 @@
 #include <sched.h>
 #include <errno.h>
 #include <string.h>
+#include <time.h>
 #include "../kselftest.h"
 
+#define MSEC_PER_SEC	1000L
+#define NSEC_PER_MSEC	1000000L
+
 void usage(char *name) {
 	printf ("Usage: %s cpunum\n", name);
 }
@@ -22,7 +26,7 @@ int main(int argc, char **argv) {
 	long long tsc, old_tsc, new_tsc;
 	long long aperf, old_aperf, new_aperf;
 	long long mperf, old_mperf, new_mperf;
-	struct timeb before, after;
+	struct timespec before, after;
 	long long int start, finish, total;
 	cpu_set_t cpuset;
 
@@ -55,7 +59,10 @@ int main(int argc, char **argv) {
 		return 1;
 	}
 
-	ftime(&before);
+	if (clock_gettime(CLOCK_MONOTONIC, &before) < 0) {
+		perror("clock_gettime");
+		return 1;
+	}
 	pread(fd, &old_tsc,  sizeof(old_tsc), 0x10);
 	pread(fd, &old_aperf,  sizeof(old_mperf), 0xe7);
 	pread(fd, &old_mperf,  sizeof(old_aperf), 0xe8);
@@ -64,7 +71,10 @@ int main(int argc, char **argv) {
 		sqrt(i);
 	}
 
-	ftime(&after);
+	if (clock_gettime(CLOCK_MONOTONIC, &after) < 0) {
+		perror("clock_gettime");
+		return 1;
+	}
 	pread(fd, &new_tsc,  sizeof(new_tsc), 0x10);
 	pread(fd, &new_aperf,  sizeof(new_mperf), 0xe7);
 	pread(fd, &new_mperf,  sizeof(new_aperf), 0xe8);
@@ -73,11 +83,11 @@ int main(int argc, char **argv) {
 	aperf = new_aperf-old_aperf;
 	mperf = new_mperf-old_mperf;
 
-	start = before.time*1000 + before.millitm;
-	finish = after.time*1000 + after.millitm;
+	start = before.tv_sec*MSEC_PER_SEC + before.tv_nsec/NSEC_PER_MSEC;
+	finish = after.tv_sec*MSEC_PER_SEC + after.tv_nsec/NSEC_PER_MSEC;
 	total = finish - start;
 
-	printf("runTime: %4.2f\n", 1.0*total/1000);
+	printf("runTime: %4.2f\n", 1.0*total/MSEC_PER_SEC);
 	printf("freq: %7.0f\n", tsc / (1.0*aperf / (1.0 * mperf)) / total);
 	return 0;
 }
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index b018e835737d..be675002f918 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -20,7 +20,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 334a7eea2004..74baab83fec3 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -6,7 +6,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 609a4ef9300e..97165a83df63 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -48,7 +48,7 @@ while true; do
 		-l | --list)
 			echo "$available"
 			exit 0 ;;
-		-n | --dry-run)
+		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
 		-h | --help)
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 0069f2f83f86..d53a4d8008f9 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -5,13 +5,16 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
-ifeq ($(ARCH),x86)
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
+ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 
-ifndef CROSS_COMPILE
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -19,9 +22,14 @@ endif
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
+$(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
+$(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
-
-endif
+$(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
+	$(CC) $(CFLAGS) \
+		vdso_test_correctness.c \
+		-o $@ \
+		$(LDFLAGS_vdso_test_correctness)
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
new file mode 100644
index 000000000000..6a6fe8d4ff55
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -0,0 +1,92 @@
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
+static const char *names[2][6] = {
+	{
+		"__kernel_gettimeofday",
+		"__kernel_clock_gettime",
+		"__kernel_time",
+		"__kernel_clock_getres",
+		"__kernel_getcpu",
+#if defined(VDSO_32BIT)
+		"__kernel_clock_gettime64",
+#endif
+	},
+	{
+		"__vdso_gettimeofday",
+		"__vdso_clock_gettime",
+		"__vdso_time",
+		"__vdso_clock_getres",
+		"__vdso_getcpu",
+#if defined(VDSO_32BIT)
+		"__vdso_clock_gettime64",
+#endif
+	},
+};
+
+#endif /* __VDSO_CONFIG_H__ */
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
new file mode 100644
index 000000000000..3d603f1394af
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
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
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
new file mode 100644
index 000000000000..15dcee16ff72
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+/*
+ * vdso_clock_getres.c: Sample code to test clock_getres.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_clock_getres.c
+ *
+ * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
+ * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
+ * Might work on other architectures.
+ */
+
+#define _GNU_SOURCE
+#include <elf.h>
+#include <err.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
+{
+	long ret;
+
+	ret = syscall(SYS_clock_getres, _clkid, _ts);
+
+	return ret;
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
+ * This function calls clock_getres in vdso and by system call
+ * with different values for clock_id.
+ *
+ * Example of output:
+ *
+ * clock_id: CLOCK_REALTIME [PASS]
+ * clock_id: CLOCK_BOOTTIME [PASS]
+ * clock_id: CLOCK_TAI [PASS]
+ * clock_id: CLOCK_REALTIME_COARSE [PASS]
+ * clock_id: CLOCK_MONOTONIC [PASS]
+ * clock_id: CLOCK_MONOTONIC_RAW [PASS]
+ * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
+ */
+static inline int vdso_test_clock(unsigned int clock_id)
+{
+	struct timespec x, y;
+
+	printf("clock_id: %s", vdso_clock_name[clock_id]);
+	clock_getres(clock_id, &x);
+	syscall_clock_getres(clock_id, &y);
+
+	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
+		printf(" [FAIL]\n");
+		return KSFT_FAIL;
+	}
+
+	printf(" [PASS]\n");
+	return KSFT_PASS;
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	ret = vdso_test_clock(CLOCK_REALTIME);
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
+	if (ret > 0)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
similarity index 73%
rename from tools/testing/selftests/x86/test_vdso.c
rename to tools/testing/selftests/vDSO/vdso_test_correctness.c
index 42052db0f870..5029ef9b228c 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -19,6 +19,10 @@
 #include <stdbool.h>
 #include <limits.h>
 
+#include "vdso_config.h"
+
+static const char **name;
+
 #ifndef SYS_getcpu
 # ifdef __x86_64__
 #  define SYS_getcpu 309
@@ -27,6 +31,17 @@
 # endif
 #endif
 
+#ifndef __NR_clock_gettime64
+#define __NR_clock_gettime64	403
+#endif
+
+#ifndef __kernel_timespec
+struct __kernel_timespec {
+	long long	tv_sec;
+	long long	tv_nsec;
+};
+#endif
+
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
@@ -36,6 +51,10 @@ typedef int (*vgettime_t)(clockid_t, struct timespec *);
 
 vgettime_t vdso_clock_gettime;
 
+typedef int (*vgettime64_t)(clockid_t, struct __kernel_timespec *);
+
+vgettime64_t vdso_clock_gettime64;
+
 typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
 
 vgtod_t vdso_gettimeofday;
@@ -99,17 +118,23 @@ static void fill_function_pointers()
 		return;
 	}
 
-	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
+	vdso_getcpu = (getcpu_t)dlsym(vdso, name[4]);
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
 
-	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, name[1]);
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
 
-	vdso_gettimeofday = (vgtod_t)dlsym(vdso, "__vdso_gettimeofday");
+#if defined(VDSO_32BIT)
+	vdso_clock_gettime64 = (vgettime64_t)dlsym(vdso, name[5]);
+	if (!vdso_clock_gettime64)
+		printf("Warning: failed to find clock_gettime64 in vDSO\n");
+#endif
+
+	vdso_gettimeofday = (vgtod_t)dlsym(vdso, name[0]);
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
@@ -126,6 +151,11 @@ static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
 	return syscall(__NR_clock_gettime, id, ts);
 }
 
+static inline int sys_clock_gettime64(clockid_t id, struct __kernel_timespec *ts)
+{
+	return syscall(__NR_clock_gettime64, id, ts);
+}
+
 static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	return syscall(__NR_gettimeofday, tv, tz);
@@ -191,6 +221,15 @@ static bool ts_leq(const struct timespec *a, const struct timespec *b)
 		return a->tv_nsec <= b->tv_nsec;
 }
 
+static bool ts64_leq(const struct __kernel_timespec *a,
+		     const struct __kernel_timespec *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_nsec <= b->tv_nsec;
+}
+
 static bool tv_leq(const struct timeval *a, const struct timeval *b)
 {
 	if (a->tv_sec != b->tv_sec)
@@ -254,7 +293,10 @@ static void test_one_clock_gettime(int clock, const char *name)
 	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");
 		nerrs++;
+		return;
 	}
+
+	printf("[OK]\tTest Passed.\n");
 }
 
 static void test_clock_gettime(void)
@@ -275,6 +317,70 @@ static void test_clock_gettime(void)
 	test_one_clock_gettime(INT_MAX, "invalid");
 }
 
+static void test_one_clock_gettime64(int clock, const char *name)
+{
+	struct __kernel_timespec start, vdso, end;
+	int vdso_ret, end_ret;
+
+	printf("[RUN]\tTesting clock_gettime64 for clock %s (%d)...\n", name, clock);
+
+	if (sys_clock_gettime64(clock, &start) < 0) {
+		if (errno == EINVAL) {
+			vdso_ret = vdso_clock_gettime64(clock, &vdso);
+			if (vdso_ret == -EINVAL) {
+				printf("[OK]\tNo such clock.\n");
+			} else {
+				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime64 returned %d\n", vdso_ret);
+				nerrs++;
+			}
+		} else {
+			printf("[WARN]\t clock_gettime64(%d) syscall returned error %d\n", clock, errno);
+		}
+		return;
+	}
+
+	vdso_ret = vdso_clock_gettime64(clock, &vdso);
+	end_ret = sys_clock_gettime64(clock, &end);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_nsec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+	       (unsigned long long)end.tv_sec, end.tv_nsec);
+
+	if (!ts64_leq(&start, &vdso) || !ts64_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+		return;
+	}
+
+	printf("[OK]\tTest Passed.\n");
+}
+
+static void test_clock_gettime64(void)
+{
+	if (!vdso_clock_gettime64) {
+		printf("[SKIP]\tNo vDSO, so skipping clock_gettime64() tests\n");
+		return;
+	}
+
+	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
+	     clock++) {
+		test_one_clock_gettime64(clock, clocknames[clock]);
+	}
+
+	/* Also test some invalid clock ids */
+	test_one_clock_gettime64(-1, "invalid");
+	test_one_clock_gettime64(INT_MIN, "invalid");
+	test_one_clock_gettime64(INT_MAX, "invalid");
+}
+
 static void test_gettimeofday(void)
 {
 	struct timeval start, vdso, end;
@@ -327,9 +433,12 @@ static void test_gettimeofday(void)
 
 int main(int argc, char **argv)
 {
+	name = (const char **)&names[VDSO_NAMES];
+
 	fill_function_pointers();
 
 	test_clock_gettime();
+	test_clock_gettime64();
 	test_gettimeofday();
 
 	/*
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9b0912a01777..9132fae7ad65 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -894,7 +894,7 @@ static int faulting_process(int signal_test)
 				count_verify[nr]);
 	        }
 		/*
-		 * Trigger write protection if there is by writting
+		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
 		*area_count(area_dst, nr) = count;
@@ -922,7 +922,7 @@ static int faulting_process(int signal_test)
 				count_verify[nr]); exit(1);
 		}
 		/*
-		 * Trigger write protection if there is by writting
+		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
 		*area_count(area_dst, nr) = count;
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 6703c7906b71..333980375bc7 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vdso test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap \
 			syscall_arg_fault fsgsbase_restore
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \

--------------D073FA41C651D06259899F2F--
