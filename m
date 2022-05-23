Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F54531A6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiEWTbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiEWTbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 15:31:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE022131F02
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 12:12:38 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d198so11249572iof.12
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=JStlKIbKUC/PwbRbKFUm03f1smNJUGnmZn4JkjrBKHI=;
        b=MXEDTErUlwgJ0Up/ol3sCEtsDgSeOfENC6COieHU5AcoyhfZjIvZdnLr4dG5FG+Zzi
         uzipvOUSkaAW52M8lyzdSbHLWwNCyffOdFq4Bo4r0F+sMAD0kBOnnlv4DDuycv5H78Wp
         XhS5hR5sMlS62RKmlgVEoM627AjP298OPDqis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=JStlKIbKUC/PwbRbKFUm03f1smNJUGnmZn4JkjrBKHI=;
        b=lKilB1n0hs+IUptU0KA8KmK5ZPXjfKzaV2XooIUWvtaghKfpbvb802EtMZarbrBJub
         nbE7vsZofjvam7BhhWUvIZ7YkTyNq7Yu4PC8mQNdwGsBBU31pIPQQOk8N2Rltj41aeqL
         fbLutMMT7JpazIdNm01J68nROgV/UVAUxziI5EjG/EqPIKlgmHW00x7X9OM3VQey7lxZ
         hLqJdZ+mS/RccN8v6mvIx0jqO1y937t5gYnHyP1tEdAnK0OOBCOrZkZg53LrndVcBHlI
         XS64ujNm4bNo/KiYp2GBfJrSdiL+O0XoQ1j5o6qHgVR9bWHEZvibKe0nMMqI7koNauiI
         m87A==
X-Gm-Message-State: AOAM532shxjWVq1x3eXJok04juMJOOK1dumMiCDTLrxLElj81lylU4Ts
        mSD4tCopsNfXUIwjg63hRKJnW+BleyBJ1w==
X-Google-Smtp-Source: ABdhPJykhobWUO8gltxzndD3H+IbINiGxzAhsv2NaC6iB12OAcroNEYq9/5OXu+NZupy3IKidaI0CA==
X-Received: by 2002:a05:6638:4907:b0:32e:b8aa:325f with SMTP id cx7-20020a056638490700b0032eb8aa325fmr4931614jab.24.1653333158096;
        Mon, 23 May 2022 12:12:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c17-20020a023b11000000b0032e6f0d3796sm2893506jaa.145.2022.05.23.12.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:12:37 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.19-rc1
Message-ID: <4ffe7200-734b-f1f9-fcab-6510b0ecbfa7@linuxfoundation.org>
Date:   Mon, 23 May 2022 13:12:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8FE879EABC94246C693863F1"
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------8FE879EABC94246C693863F1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.19-rc1

This Kselftest update for Linux 5.19-rc1 consists of several fixes,
cleanups, and enhancements to tests:

- adds mips support for kprobe args string and syntax tests
- updates to resctrl test to use kselftest framework
- fixes, cleanups, and enhancements to tests

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

   Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.19-rc1

for you to fetch changes up to 15477b31db104bc795dd1acccb3e9b89465fff01:

   kselftests/ir : Improve readability of modprobe error message (2022-05-16 13:34:19 -0600)

----------------------------------------------------------------
linux-kselftest-next-5.19-rc1

This Kselftest update for Linux 5.19-rc1 consists of several fixes,
cleanups, and enhancements to tests:

- adds mips support for kprobe args string and syntax tests
- updates to resctrl test to use kselftest framework
- fixes, cleanups, and enhancements to tests

----------------------------------------------------------------
Colin Ian King (1):
       selftests/resctrl: Fix null pointer dereference on open failed

Gautam Menghani (1):
       kselftests/ir : Improve readability of modprobe error message

Geliang Tang (1):
       selftests: mqueue: drop duplicate min definition

Karthik Alapati (1):
       selftests/binderfs: Improve message to provide more info

Reinette Chatre (4):
       selftests: Provide local define of __cpuid_count()
       selftests/vm/pkeys: Use provided __cpuid_count() macro
       selftests/x86/amx: Use provided __cpuid_count() macro
       selftests/x86/corrupt_xstate_header: Use provided __cpuid_count() macro

Shaopeng Tan (8):
       selftests/resctrl: Extend CPU vendor detection
       selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel CPU
       selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
       selftests/resctrl: Change the default limited time to 120 seconds
       selftests/resctrl: Fix resctrl_tests' return code to work with selftest framework
       selftests/resctrl: Make resctrl_tests run using kselftest framework
       selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
       selftests/resctrl: Add missing SPDX license to Makefile

Yuanchu Xie (1):
       selftests/damon: add damon to selftests root Makefile

Ze Zhang (2):
       selftests/ftrace: add mips support for kprobe args string tests
       selftests/ftrace: add mips support for kprobe args syntax tests

  tools/testing/selftests/Makefile                   |  2 +
  .../selftests/filesystems/binderfs/binderfs_test.c |  3 +-
  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  3 ++
  .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |  4 ++
  tools/testing/selftests/ir/ir_loopback.sh          |  2 +-
  tools/testing/selftests/kselftest.h                | 15 +++++++
  tools/testing/selftests/mqueue/mq_perf_tests.c     |  4 +-
  tools/testing/selftests/resctrl/Makefile           | 19 +++------
  tools/testing/selftests/resctrl/README             | 39 +++++++++++++----
  tools/testing/selftests/resctrl/cat_test.c         |  2 +-
  tools/testing/selftests/resctrl/fill_buf.c         |  4 +-
  tools/testing/selftests/resctrl/resctrl.h          |  5 ++-
  tools/testing/selftests/resctrl/resctrl_tests.c    | 49 +++++++++++++++-------
  tools/testing/selftests/resctrl/resctrl_val.c      |  1 +
  tools/testing/selftests/resctrl/resctrlfs.c        |  2 +-
  tools/testing/selftests/resctrl/settings           |  3 ++
  tools/testing/selftests/vm/pkey-x86.h              | 21 +---------
  tools/testing/selftests/x86/amx.c                  | 24 ++++-------
  .../testing/selftests/x86/corrupt_xstate_header.c  | 16 +------
  19 files changed, 124 insertions(+), 94 deletions(-)
  create mode 100644 tools/testing/selftests/resctrl/settings
----------------------------------------------------------------

--------------8FE879EABC94246C693863F1
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.19-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.19-rc1.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..0aedcd76cf0f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += damon
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
@@ -52,6 +53,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 0315955ff0f4..bc1c407651fc 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -412,7 +412,8 @@ TEST(binderfs_stress)
 
 		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
 		ASSERT_EQ(ret, 0) {
-			TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+			TH_LOG("%s - Failed to mount binderfs, check if CONFIG_ANDROID_BINDERFS is enabled in the running kernel",
+				strerror(errno));
 		}
 
 		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index dc7ade196798..459741565222 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -25,6 +25,9 @@ ppc*)
 s390*)
   ARG1=%r2
 ;;
+mips*)
+  ARG1=%r4
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 47d84b5cb6ca..d4662c8cf407 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -36,6 +36,10 @@ s390*)
   GOODREG=%r2
   BADREG=%s2
 ;;
+mips*)
+  GOODREG=%r4
+  BADREG=%r12
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ir/ir_loopback.sh b/tools/testing/selftests/ir/ir_loopback.sh
index b90dc9939f45..aff9299c9416 100755
--- a/tools/testing/selftests/ir/ir_loopback.sh
+++ b/tools/testing/selftests/ir/ir_loopback.sh
@@ -10,7 +10,7 @@ if [ $UID != 0 ]; then
 fi
 
 if ! /sbin/modprobe -q -n rc-loopback; then
-        echo "ir_loopback: module rc-loopback is not found [SKIP]"
+        echo "ir_loopback: module rc-loopback is not found in /lib/modules/`uname -r` [SKIP]"
         exit $ksft_skip
 fi
 
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8f248018174..33a0dbd26bd3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -53,6 +53,21 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+/*
+ * gcc cpuid.h provides __cpuid_count() since v4.4.
+ * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
+ *
+ * Provide local define for tests needing __cpuid_count() because
+ * selftests need to work in older environments that do not yet
+ * have __cpuid_count().
+ */
+#ifndef __cpuid_count
+#define __cpuid_count(level, count, a, b, c, d)				\
+	__asm__ __volatile__ ("cpuid\n\t"				\
+			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
+			      : "0" (level), "2" (count))
+#endif
+
 /* define kselftest exit codes */
 #define KSFT_PASS  0
 #define KSFT_FAIL  1
diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 84fda3b49073..5c16159d0bcd 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -35,6 +35,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/param.h>
 #include <mqueue.h>
 #include <popt.h>
 #include <error.h>
@@ -73,7 +74,6 @@ static char *usage =
 char *MAX_MSGS = "/proc/sys/fs/mqueue/msg_max";
 char *MAX_MSGSIZE = "/proc/sys/fs/mqueue/msgsize_max";
 
-#define min(a, b) ((a) < (b) ? (a) : (b))
 #define MAX_CPUS 64
 char *cpu_option_string;
 int cpus_to_pin[MAX_CPUS];
@@ -560,7 +560,7 @@ int main(int argc, char *argv[])
 			"require root in order to modify\nsystem settings.  "
 			"Exiting.\n");
 
-	cpus_online = min(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
+	cpus_online = MIN(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
 	cpu_set = CPU_ALLOC(cpus_online);
 	if (cpu_set == NULL) {
 		perror("CPU_ALLOC()");
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6bcee2ec91a9..73d53257df42 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,10 @@
-CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
-
-all: resctrl_tests
+# SPDX-License-Identifier: GPL-2.0
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
+CFLAGS += $(KHDR_INCLUDES)
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
+TEST_GEN_PROGS := resctrl_tests
 
-.PHONY: clean
+include ../lib.mk
 
-clean:
-	$(RM) $(OBJS) resctrl_tests
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..8d11ce7c2ee5 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -12,24 +12,49 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
 And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
 as well.
 
+resctrl_tests can be run with or without kselftest framework.
+
+WITH KSELFTEST FRAMEWORK
+=======================
+
 BUILD
 -----
 
-Run "make" to build executable file "resctrl_tests".
+Build executable file "resctrl_tests" from top level directory of the kernel source:
+ $ make -C tools/testing/selftests TARGETS=resctrl
 
 RUN
 ---
 
-To use resctrl_tests, root or sudoer privileges are required. This is because
-the test needs to mount resctrl file system and change contents in the file
-system.
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
+Using kselftest framework will run all supported tests within resctrl_tests:
+
+ $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests
+
+More details about kselftest framework can be found in
+Documentation/dev-tools/kselftest.rst.
+
+WITHOUT KSELFTEST FRAMEWORK
+===========================
+
+BUILD
+-----
+
+Build executable file "resctrl_tests" from this directory(tools/testing/selftests/resctrl/):
+  $ make
+
+RUN
+---
 
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
 Executing the test without any parameter will run all supported tests:
 
-	sudo ./resctrl_tests
+ $ sudo ./resctrl_tests
 
 OVERVIEW OF EXECUTION
----------------------
+=====================
 
 A test case has four stages:
 
@@ -41,7 +66,7 @@ A test case has four stages:
   - teardown: umount resctrl and clear temporary files.
 
 ARGUMENTS
----------
+=========
 
 Parameter '-h' shows usage information.
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index cd4f68388e0f..1c5e90c63254 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -89,7 +89,7 @@ static int check_results(struct resctrl_val_param *param)
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
-			       !is_amd, false);
+			       get_vendor() == ARCH_INTEL, false);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 51e5cf22632f..56ccbeae0638 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -121,8 +121,10 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
-	if (!fp)
+	if (!fp) {
 		perror("Unable to write to /dev/null");
+		return -1;
+	}
 	fprintf(fp, "Sum: %d ", ret);
 	fclose(fp);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1ad10c47e31d..f0ded31fb3c7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -34,6 +34,9 @@
 #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
 #define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
+#define ARCH_INTEL     1
+#define ARCH_AMD       2
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -75,8 +78,8 @@ struct resctrl_val_param {
 extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
-extern bool is_amd;
 
+int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..df0d8d8526fc 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -13,25 +13,41 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
-bool is_amd;
-
-void detect_amd(void)
+static int detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
+	int vendor_id = 0;
+	char *s = NULL;
 	char *res;
 
 	if (!inf)
-		return;
+		return vendor_id;
 
 	res = fgrep(inf, "vendor_id");
 
-	if (res) {
-		char *s = strchr(res, ':');
+	if (res)
+		s = strchr(res, ':');
+
+	if (s && !strcmp(s, ": GenuineIntel\n"))
+		vendor_id = ARCH_INTEL;
+	else if (s && !strcmp(s, ": AuthenticAMD\n"))
+		vendor_id = ARCH_AMD;
 
-		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
-		free(res);
-	}
 	fclose(inf);
+	free(res);
+	return vendor_id;
+}
+
+int get_vendor(void)
+{
+	static int vendor = -1;
+
+	if (vendor == -1)
+		vendor = detect_vendor();
+	if (vendor == 0)
+		ksft_print_msg("Can not get vendor info...\n");
+
+	return vendor;
 }
 
 static void cmd_help(void)
@@ -70,6 +86,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 		sprintf(benchmark_cmd[5], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
+	if ((get_vendor() == ARCH_INTEL) && res)
+		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 	mbm_test_cleanup();
 }
 
@@ -106,6 +124,8 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		sprintf(benchmark_cmd[5], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
+	if ((get_vendor() == ARCH_INTEL) && res)
+		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 	cmt_test_cleanup();
 }
 
@@ -205,10 +225,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
-
-	/* Detect AMD vendor */
-	detect_amd();
+		return ksft_exit_skip("Not running as root. Skipping...\n");
 
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
@@ -235,16 +252,16 @@ int main(int argc, char **argv)
 	sprintf(bm_type, "fill_buf");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
 	filter_dmesg();
 
 	ksft_set_plan(tests ? : 4);
 
-	if (!is_amd && mbm_test)
+	if ((get_vendor() == ARCH_INTEL) && mbm_test)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test)
+	if ((get_vendor() == ARCH_INTEL) && mba_test)
 		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 95224345c78e..b32b96356ec7 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = SA_SIGINFO;
 	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
 		perror("# sigaction");
 		ret = errno;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5f5a166ade60..6f543e470ad4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -106,7 +106,7 @@ int get_resource_id(int cpu_no, int *resource_id)
 	char phys_pkg_path[1024];
 	FILE *fp;
 
-	if (is_amd)
+	if (get_vendor() == ARCH_AMD)
 		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
 			PHYS_ID_PATH, cpu_no);
 	else
diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 000000000000..a383f3d4565b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1,3 @@
+# If running time is longer than 120 seconds when new tests are added in
+# the future, increase timeout here.
+timeout=120
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index e4a4ce2b826d..b078ce9c6d2a 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -80,19 +80,6 @@ static inline void __write_pkey_reg(u64 pkey_reg)
 	assert(pkey_reg == __read_pkey_reg());
 }
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-		unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile(
-		"cpuid;"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
-
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
@@ -104,9 +91,7 @@ static inline int cpu_has_pkeys(void)
 	unsigned int ecx;
 	unsigned int edx;
 
-	eax = 0x7;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(0x7, 0x0, eax, ebx, ecx, edx);
 
 	if (!(ecx & X86_FEATURE_PKU)) {
 		dprintf2("cpu does not have PKU\n");
@@ -142,9 +127,7 @@ int pkey_reg_xstate_offset(void)
 	/* assume that XSTATE_PKEY is set in XCR0 */
 	leaf = XSTATE_PKEY_BIT;
 	{
-		eax = XSTATE_CPUID;
-		ecx = leaf;
-		__cpuid(&eax, &ebx, &ecx, &edx);
+		__cpuid_count(XSTATE_CPUID, leaf, eax, ebx, ecx, edx);
 
 		if (leaf == XSTATE_PKEY_BIT) {
 			xstate_offset = ebx;
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 2189f0322d8b..625e42901237 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -17,6 +17,8 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 
+#include "../kselftest.h" /* For __cpuid_count() */
+
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
@@ -45,13 +47,6 @@ static inline uint64_t xgetbv(uint32_t index)
 	return eax + ((uint64_t)edx << 32);
 }
 
-static inline void cpuid(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
-{
-	asm volatile("cpuid;"
-		     : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
-		     : "0" (*eax), "2" (*ecx));
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -115,9 +110,7 @@ static inline void check_cpuid_xsave(void)
 	 * support for the XSAVE feature set, including
 	 * XGETBV.
 	 */
-	eax = 1;
-	ecx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(1, 0, eax, ebx, ecx, edx);
 	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
 		fatal_error("cpuid: no CPU xsave support");
 	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
@@ -140,9 +133,8 @@ static void check_cpuid_xtiledata(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 
-	eax = CPUID_LEAF_XSTATE;
-	ecx = CPUID_SUBLEAF_XSTATE_USER;
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
 
 	/*
 	 * EBX enumerates the size (in bytes) required by the XSAVE
@@ -153,10 +145,8 @@ static void check_cpuid_xtiledata(void)
 	 */
 	xbuf_size = ebx;
 
-	eax = CPUID_LEAF_XSTATE;
-	ecx = XFEATURE_XTILEDATA;
-
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(CPUID_LEAF_XSTATE, XFEATURE_XTILEDATA,
+		      eax, ebx, ecx, edx);
 	/*
 	 * eax: XTILEDATA state component size
 	 * ebx: XTILEDATA state component offset in user buffer
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index ab8599c10ce5..cf9ce8fbb656 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -17,25 +17,13 @@
 #include <stdint.h>
 #include <sys/wait.h>
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
-{
-	asm volatile(
-		"cpuid;"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
+#include "../kselftest.h" /* For __cpuid_count() */
 
 static inline int xsave_enabled(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 
-	eax = 0x1;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(0x1, 0x0, eax, ebx, ecx, edx);
 
 	/* Is CR4.OSXSAVE enabled ? */
 	return ecx & (1U << 27);

--------------8FE879EABC94246C693863F1--
