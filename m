Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D2104A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfEPVwo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 17:52:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45629 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfEPVwo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 17:52:44 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so3816031iob.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2019 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=E3V3xSAr3HS+mCRxel6KSvTWtoEk5Nqx3/YpG25iUas=;
        b=fK214iTo5lVCZs0UDPUSnKWoX9sItHxFFPcBsEkqHv2owOio3MLBZW317sXuCAfZ9f
         HWFBxetAml8KfrlWW2A1oiTH9aRJlJSdHCy5pEfkEX4Wd2/6qTH1r40Yi03x62GzR/E8
         UViJVE3vfJdZXxUHOyrQiutmw/C95TDNp2qkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=E3V3xSAr3HS+mCRxel6KSvTWtoEk5Nqx3/YpG25iUas=;
        b=Sl19IiSDI+HW87Tr3yM+EuEZ2NCEkDE0Upd3hPm437hW4Hl7WkyvCXkxD/BuJESlC2
         NSzEe5+bap+uK5uUT4yofg+P7f4bL5tMDia7JPp+PhlSD+ZmeJb4RraEdFNvpHOuJA3z
         Y53DtqT5Bc3Nd3exJTy74P4/45+l019SM/c8WV8vVOz8y1Taz8CXE+aEtLtK2AjqLR/C
         aaGFqR/rFFTGiwatTL7/tXtSMttRJUYn4N9LAuDLmuqxfdm9oV78Euiwho/GR65aW2KR
         I+DLzvKIzFqJ/Dcqf98hRfb7FfqEx4IDjUZRIDJqXHRT9tpsYuKN7fnqo6VSJwjh2vg6
         t4Kg==
X-Gm-Message-State: APjAAAWn9N6EIgwbWxoFnxftjWqoUCRPxWptn1s2XH+YDw99UTwbXyLW
        DbqoCfyRDi5Mg/4H10wS4yyajb3ZKVM=
X-Google-Smtp-Source: APXvYqx7fTsOXXxKuEgD6uVRPlzmEXhyQQ0LqwHLAfTPqZdq7S7lRibEBkVDd6K0pngcX5bws18nOw==
X-Received: by 2002:a6b:b485:: with SMTP id d127mr28820144iof.273.1558043560967;
        Thu, 16 May 2019 14:52:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i25sm2146457ioi.42.2019.05.16.14.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:52:40 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest second update for Linux 5.2-rc1
Message-ID: <7af4f05b-abec-8d5b-3b99-a1eb12fd4a67@linuxfoundation.org>
Date:   Thu, 16 May 2019 15:52:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1A24A026F2D70035F17A721C"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------1A24A026F2D70035F17A721C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.2-rc1

This kselftest second update for Linux 5.2-rc1 consists of

Kselftest framework fixes from Shuah Khan

- kselftest framework bpf build/test workflow regression fix
- Fix to kselftest install to use default install path
- Fix to kselftest KBUILD_OUTPUT builds to not clutter main
   KBUILD_OUTPUT directory with selftest objects

- .gitignore fixes from Kelsey Skunberg

- rseq selftests updates from Mathieu Desnoyers and Martin Schwidefsky:

   They change the per-architecture pre-abort signatures to ensure those
   are valid trap instructions.

   The way exit points are presented to debuggers is enhanced, ensuring
   all exit points are present, so debuggers don't have to disassemble
   rseq critical section to properly skip over them.

   Discussions with the glibc community is reaching a consensus of
   exposing a __rseq_handled symbol from glibc to coexist with rseq early
   adopters.
   Update the rseq selftest code to expose and use this symbol.

   Support for compiling asm goto with clang is added with the
   "-no-integrated-as" compiler switch, similarly to the top level kernel
   Makefile.

- kselftest Makefile test run output refactoring and making test
   output TAP13 compliant from Kees Cook:

   This re-factors the selftest Makefiles to extract the test running
   logic to be reused between "run_tests" and "emit_tests", while also
   fixing up the test output to be TAP version 13 compliant:
         - added "plan" line
         - fixed result line syntax
         - moved all test output to be "# "-prefixed as TAP "diagnostic"
           lines

   The prefixing code includes a fallback mode for limited execution
   environments.

   Additionally, the plan lines are fixed for all callers of kselftest.h.

diff is attached.

Also, there is a merge conflict with the following commit which went
through the s390 maintainer tree and is now in your master which will
require a minor fix-up.

commit e24e4712efad737ca09ff299276737331cd021d9
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
       rseq/selftests: s390: use trap4 for RSEQ_SIG


thanks,
-- Shuah

---------------------------------------------------------------
The following changes since commit d917fb876f6eaeeea8a2b620d2a266ce26372f4d:

   selftests: build and run gpio when output directory is the src dir 
(2019-04-22 17:02:26 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc1-2

for you to fetch changes up to 61c2018c0743fe0c9ca68e308b5727b8a7c3d544:

   selftests: avoid KBUILD_OUTPUT dir cluttering with selftest objects 
(2019-05-14 17:37:41 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc1-2

This kselftest second update for Linux 5.2-rc1 consists of

Kselftest framework fixes from Shuah Khan

- kselftest framework bpf build/test workflow regression fix
- Fix to kselftest install to use default install path
- Fix to kselftest KBUILD_OUTPUT builds to not clutter main
   KBUILD_OUTPUT directory with selftest objects

- .gitignore fixes from Kelsey Skunberg

- rseq selftests updates from Mathieu Desnoyers and Martin Schwidefsky:

   They change the per-architecture pre-abort signatures to ensure those
   are valid trap instructions.

   The way exit points are presented to debuggers is enhanced, ensuring
   all exit points are present, so debuggers don't have to disassemble
   rseq critical section to properly skip over them.

   Discussions with the glibc community is reaching a consensus of exposing
   a __rseq_handled symbol from glibc to coexist with rseq early adopters.
   Update the rseq selftest code to expose and use this symbol.

   Support for compiling asm goto with clang is added with the
   "-no-integrated-as" compiler switch, similarly to the top level kernel
   Makefile.

- kselftest Makefile test run output refactoring and making test
   output TAP13 compliant from Kees Cook:

   This re-factors the selftest Makefiles to extract the test running logic
   to be reused between "run_tests" and "emit_tests", while also fixing
   up the test output to be TAP version 13 compliant:
         - added "plan" line
         - fixed result line syntax
         - moved all test output to be "# "-prefixed as TAP "diagnostic"
           lines

   The prefixing code includes a fallback mode for limited execution
   environments.

   Additionally, the plan lines are fixed for all callers of kselftest.h.

----------------------------------------------------------------
Kees Cook (8):
       selftests: Extract single-test shell logic from lib.mk
       selftests: Use runner.sh for emit targets
       selftests: Extract logic for multiple test runs
       selftests: Add plan line and fix result line syntax
       selftests: Distinguish between missing and non-executable
       selftests: Move test output to diagnostic lines
       selftests: Remove KSFT_TAP_LEVEL
       selftests: Add test plan API to kselftest.h and adjust callers

Kelsey Skunberg (2):
       selftests: pidfd: Create .gitignore to include pidfd_test
       selftests: drivers: Create .gitignore to include /dma-buf/udmabuf

Martin Schwidefsky (1):
       rseq/selftests: s390: use trap4 for RSEQ_SIG

Mathieu Desnoyers (11):
       rseq/selftests: x86: Work-around bogus gcc-8 optimisation
       rseq/selftests: Add __rseq_exit_point_array section for debuggers
       rseq/selftests: Introduce __rseq_cs_ptr_array, rename 
__rseq_table to __rseq_cs
       rseq/selftests: Use __rseq_handled symbol to coexist with glibc
       rseq/selftests: s390: use jg instruction for jumps outside of the asm
       rseq/selftests: x86: use ud1 instruction as RSEQ_SIG opcode
       rseq/selftests: arm: use udf instruction for RSEQ_SIG
       rseq/selftests: aarch64 code signature: handle big-endian environment
       rseq/selftests: powerpc code signature: generate valid instructions
       rseq/selftests: mips: use break instruction for RSEQ_SIG
       rseq/selftests: add -no-integrated-as for clang

Shuah Khan (3):
       selftests: fix install target to use default install path
       selftests: fix bpf build/test workflow regression when 
KBUILD_OUTPUT is set
       selftests: avoid KBUILD_OUTPUT dir cluttering with selftest objects

  tools/testing/selftests/.gitignore                 |   1 -
  tools/testing/selftests/Makefile                   |  39 +--
  .../selftests/breakpoints/breakpoint_test.c        |  15 +-
  .../selftests/breakpoints/breakpoint_test_arm64.c  |   3 +-
  .../breakpoints/step_after_suspend_test.c          |   8 +
  tools/testing/selftests/capabilities/test_execve.c |   6 +-
  tools/testing/selftests/drivers/.gitignore         |   1 +
  .../selftests/futex/functional/futex_requeue_pi.c  |   1 +
  .../functional/futex_requeue_pi_mismatched_ops.c   |   1 +
  .../functional/futex_requeue_pi_signal_restart.c   |   1 +
  .../functional/futex_wait_private_mapped_file.c    |   1 +
  .../futex/functional/futex_wait_timeout.c          |   1 +
  .../functional/futex_wait_uninitialized_heap.c     |   1 +
  .../futex/functional/futex_wait_wouldblock.c       |   1 +
  tools/testing/selftests/kselftest.h                |  17 +-
  tools/testing/selftests/kselftest/prefix.pl        |  23 ++
  tools/testing/selftests/kselftest/runner.sh        |  86 +++++++
  tools/testing/selftests/lib.mk                     |  76 ++----
  .../testing/selftests/membarrier/membarrier_test.c |   1 +

  tools/testing/selftests/pidfd/.gitignore           |   1 +
  tools/testing/selftests/pidfd/pidfd_test.c         |   1 +
  tools/testing/selftests/rseq/Makefile              |   8 +-
  tools/testing/selftests/rseq/rseq-arm.h            | 132 +++++++++--
  tools/testing/selftests/rseq/rseq-arm64.h          |  74 +++++-
  tools/testing/selftests/rseq/rseq-mips.h           | 115 ++++++++-
  tools/testing/selftests/rseq/rseq-ppc.h            |  90 ++++++-
  tools/testing/selftests/rseq/rseq-s390.h           |  78 +++++-
  tools/testing/selftests/rseq/rseq-x86.h            | 264 
++++++++++++++-------
  tools/testing/selftests/rseq/rseq.c                |  55 ++++-
  tools/testing/selftests/rseq/rseq.h                |   1 +
  tools/testing/selftests/sigaltstack/sas.c          |   1 +
  tools/testing/selftests/sync/sync_test.c           |   1 +
  32 files changed, 883 insertions(+), 221 deletions(-)
  create mode 100644 tools/testing/selftests/drivers/.gitignore
  create mode 100755 tools/testing/selftests/kselftest/prefix.pl
  create mode 100644 tools/testing/selftests/kselftest/runner.sh
  create mode 100644 tools/testing/selftests/pidfd/.gitignore

---------------------------------------------------------------

--------------1A24A026F2D70035F17A721C
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc1-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc1-2.diff"

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 91750352459d..8059ce834247 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -1,4 +1,3 @@
-kselftest
 gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f2ebf8cf4686..9781ca79794a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -71,6 +71,9 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
+# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# KBUILD_OUTPUT with selftest objects and headers installed
+# by selftests Makefile or lib.mk.
 ifneq ($(KBUILD_SRC),)
 override LDFLAGS =
 endif
@@ -79,19 +82,13 @@ ifneq ($(O),)
 	BUILD := $(O)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)
+		BUILD := $(KBUILD_OUTPUT)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
 	endif
 endif
 
-# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
-# printing from tests. Applicable to run_tests case where run_tests adds
-# TAP header prior running tests and when a test program invokes another
-# with system() call. Export it here to cover override RUN_TESTS defines.
-export KSFT_TAP_LEVEL=`echo 1`
-
 # Prepare for headers install
 top_srcdir ?= ../../..
 include $(top_srcdir)/scripts/subarch.include
@@ -169,14 +166,22 @@ clean_hotplug:
 run_pstore_crash:
 	make -C pstore run_crash
 
-INSTALL_PATH ?= install
+# Use $BUILD as the default install root. $BUILD points to the
+# right output location for the following cases:
+# 1. output_dir=kernel_src
+# 2. a separate output directory is specified using O= KBUILD_OUTPUT
+# 3. a separate output directory is specified using KBUILD_OUTPUT
+#
+INSTALL_PATH ?= $(BUILD)/install
 INSTALL_PATH := $(abspath $(INSTALL_PATH))
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 
-install:
+install: all
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
-	mkdir -p $(INSTALL_PATH)
+	mkdir -p $(INSTALL_PATH)/kselftest
+	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
+	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		make OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
@@ -186,24 +191,20 @@ ifdef INSTALL_PATH
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
 	echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
 	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
+	echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
 	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
 	echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
-	echo "  OUTPUT=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
-	echo "  cat /dev/null > \$$OUTPUT" >> $(ALL_SCRIPT)
-	echo "else" >> $(ALL_SCRIPT)
-	echo "  OUTPUT=/dev/stdout" >> $(ALL_SCRIPT)
+	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
+	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
-	echo "export KSFT_TAP_LEVEL=1" >> $(ALL_SCRIPT)
-	echo "export skip=4" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		echo "echo ; echo TAP version 13" >> $(ALL_SCRIPT);	\
-		echo "echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
-		echo "echo ========================================" >> $(ALL_SCRIPT); \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
+		echo -n "run_many" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
+		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
 	done;
 
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index 901b85ea6a59..8f3655e59020 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -21,6 +21,8 @@
 
 #include "../kselftest.h"
 
+#define COUNT_ISN_BPS	4
+#define COUNT_WPS	4
 
 /* Breakpoint access modes */
 enum {
@@ -220,7 +222,7 @@ static void trigger_tests(void)
 			if (!local && !global)
 				continue;
 
-			for (i = 0; i < 4; i++) {
+			for (i = 0; i < COUNT_ISN_BPS; i++) {
 				dummy_funcs[i]();
 				check_trapped();
 			}
@@ -292,7 +294,7 @@ static void launch_instruction_breakpoints(char *buf, int local, int global)
 {
 	int i;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < COUNT_ISN_BPS; i++) {
 		set_breakpoint_addr(dummy_funcs[i], i);
 		toggle_breakpoint(i, BP_X, 1, local, global, 1);
 		ptrace(PTRACE_CONT, child_pid, NULL, 0);
@@ -314,7 +316,7 @@ static void launch_watchpoints(char *buf, int mode, int len,
 	else
 		mode_str = "read";
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < COUNT_WPS; i++) {
 		set_breakpoint_addr(&dummy_var[i], i);
 		toggle_breakpoint(i, mode, len, local, global, 1);
 		ptrace(PTRACE_CONT, child_pid, NULL, 0);
@@ -330,8 +332,15 @@ static void launch_watchpoints(char *buf, int mode, int len,
 static void launch_tests(void)
 {
 	char buf[1024];
+	unsigned int tests = 0;
 	int len, local, global, i;
 
+	tests += 3 * COUNT_ISN_BPS;
+	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
+	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
+	tests += 2;
+	ksft_set_plan(tests);
+
 	/* Instruction breakpoints */
 	for (local = 0; local < 2; local++) {
 		for (global = 0; global < 2; global++) {
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 2d95e5adde72..ab59d814341a 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -118,7 +118,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool run_test(int wr_size, int wp_size, int wr, int wp)
+static bool arun_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;
@@ -214,6 +214,7 @@ int main(int argc, char **argv)
 	bool result;
 
 	ksft_print_header();
+	ksft_set_plan(213);
 
 	act.sa_handler = sigalrm;
 	sigemptyset(&act.sa_mask);
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index f82dcc1f8841..cf868b5e00f7 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -173,6 +173,7 @@ int main(int argc, char **argv)
 	int opt;
 	bool do_suspend = true;
 	bool succeeded = true;
+	unsigned int tests = 0;
 	cpu_set_t available_cpus;
 	int err;
 	int cpu;
@@ -191,6 +192,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &available_cpus))
+			continue;
+		tests++;
+	}
+	ksft_set_plan(tests);
+
 	if (do_suspend)
 		suspend();
 
diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 3ab39a61b95b..df0ef02b4036 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -430,8 +430,6 @@ int main(int argc, char **argv)
 {
 	char *tmp1, *tmp2, *our_path;
 
-	ksft_print_header();
-
 	/* Find our path */
 	tmp1 = strdup(argv[0]);
 	if (!tmp1)
@@ -445,6 +443,8 @@ int main(int argc, char **argv)
 	mpid = getpid();
 
 	if (fork_wait()) {
+		ksft_print_header();
+		ksft_set_plan(12);
 		ksft_print_msg("[RUN]\t+++ Tests with uid == 0 +++\n");
 		return do_tests(0, our_path);
 	}
@@ -452,6 +452,8 @@ int main(int argc, char **argv)
 	ksft_print_msg("==================================================\n");
 
 	if (fork_wait()) {
+		ksft_print_header();
+		ksft_set_plan(9);
 		ksft_print_msg("[RUN]\t+++ Tests with uid != 0 +++\n");
 		return do_tests(1, our_path);
 	}
diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
new file mode 100644
index 000000000000..f6aebcc27b76
--- /dev/null
+++ b/tools/testing/selftests/drivers/.gitignore
@@ -0,0 +1 @@
+/dma-buf/udmabuf
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 54cd5c414e82..8d20957f7586 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -395,6 +395,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test requeue functionality\n", basename(argv[0]));
 	ksft_print_msg(
 		"\tArguments: broadcast=%d locked=%d owner=%d timeout=%ldns\n",
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index 08187a16507f..742624c59ba7 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
@@ -79,6 +79,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index f0542a344d95..a0f5934707ff 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -144,6 +144,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test signal handling during requeue_pi\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: <none>\n");
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
index 6216de828093..a458d42ff86e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
@@ -98,6 +98,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg(
 		"%s: Test the futex value of private file mappings in FUTEX_WAIT\n",
 		basename(argv[0]));
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index bab3dfe1787f..04b95478059c 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -69,6 +69,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
index 26975322545b..3a1d12a14921 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -100,6 +100,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test the uninitialized futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index da15a63269b4..a34a6bbc30ce 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -65,6 +65,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 47e1d995c182..ec15c4f6af55 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -33,6 +33,7 @@ struct ksft_count {
 };
 
 static struct ksft_count ksft_cnt;
+static unsigned int ksft_plan;
 
 static inline int ksft_test_num(void)
 {
@@ -61,13 +62,21 @@ static inline void ksft_print_header(void)
 		printf("TAP version 13\n");
 }
 
+static inline void ksft_set_plan(unsigned int plan)
+{
+	ksft_plan = plan;
+	printf("1..%d\n", ksft_plan);
+}
+
 static inline void ksft_print_cnts(void)
 {
-	printf("Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
+	if (ksft_plan != ksft_test_num())
+		printf("# Planned tests != run tests (%u != %u)\n",
+			ksft_plan, ksft_test_num());
+	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
-	printf("1..%d\n", ksft_test_num());
 }
 
 static inline void ksft_print_msg(const char *msg, ...)
@@ -111,7 +120,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("ok %d # skip ", ksft_test_num());
+	printf("not ok %d # SKIP ", ksft_test_num());
 	vprintf(msg, args);
 	va_end(args);
 }
@@ -172,7 +181,7 @@ static inline int ksft_exit_skip(const char *msg, ...)
 		va_list args;
 
 		va_start(args, msg);
-		printf("1..%d # Skipped: ", ksft_test_num());
+		printf("not ok %d # SKIP ", 1 + ksft_test_num());
 		vprintf(msg, args);
 		va_end(args);
 	} else {
diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
new file mode 100755
index 000000000000..ec7e48118183
--- /dev/null
+++ b/tools/testing/selftests/kselftest/prefix.pl
@@ -0,0 +1,23 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+# Prefix all lines with "# ", unbuffered. Command being piped in may need
+# to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
+use strict;
+
+binmode STDIN;
+binmode STDOUT;
+
+STDOUT->autoflush(1);
+
+my $needed = 1;
+while (1) {
+	my $char;
+	my $bytes = sysread(STDIN, $char, 1);
+	exit 0 if ($bytes == 0);
+	if ($needed) {
+		print "# ";
+		$needed = 0;
+	}
+	print $char;
+	$needed = 1 if ($char eq "\n");
+}
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
new file mode 100644
index 000000000000..eff3ee303d0d
--- /dev/null
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs a set of tests in a given subdirectory.
+export skip_rc=4
+export logfile=/dev/stdout
+export per_test_logging=
+
+# There isn't a shell-agnostic way to find the path of a sourced file,
+# so we must rely on BASE_DIR being set to find other tools.
+if [ -z "$BASE_DIR" ]; then
+	echo "Error: BASE_DIR must be set before sourcing." >&2
+	exit 1
+fi
+
+# If Perl is unavailable, we must fall back to line-at-a-time prefixing
+# with sed instead of unbuffered output.
+tap_prefix()
+{
+	if [ ! -x /usr/bin/perl ]; then
+		sed -e 's/^/# /'
+	else
+		"$BASE_DIR"/kselftest/prefix.pl
+	fi
+}
+
+# If stdbuf is unavailable, we must fall back to line-at-a-time piping.
+tap_unbuffer()
+{
+	if ! which stdbuf >/dev/null ; then
+		"$@"
+	else
+		stdbuf -i0 -o0 -e0 "$@"
+	fi
+}
+
+run_one()
+{
+	DIR="$1"
+	TEST="$2"
+	NUM="$3"
+
+	BASENAME_TEST=$(basename $TEST)
+
+	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
+	echo "# $TEST_HDR_MSG"
+	if [ ! -x "$TEST" ]; then
+		echo -n "# Warning: file $TEST is "
+		if [ ! -e "$TEST" ]; then
+			echo "missing!"
+		else
+			echo "not executable, correct this."
+		fi
+		echo "not ok $test_num $TEST_HDR_MSG"
+	else
+		cd `dirname $TEST` > /dev/null
+		(((((tap_unbuffer ./$BASENAME_TEST 2>&1; echo $? >&3) |
+			tap_prefix >&4) 3>&1) |
+			(read xs; exit $xs)) 4>>"$logfile" &&
+		echo "ok $test_num $TEST_HDR_MSG") ||
+		(if [ $? -eq $skip_rc ]; then	\
+			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+		else
+			echo "not ok $test_num $TEST_HDR_MSG"
+		fi)
+		cd - >/dev/null
+	fi
+}
+
+run_many()
+{
+	echo "TAP version 13"
+	DIR=$(basename "$PWD")
+	test_num=0
+	total=$(echo "$@" | wc -w)
+	echo "1..$total"
+	for TEST in "$@"; do
+		BASENAME_TEST=$(basename $TEST)
+		test_num=$(( test_num + 1 ))
+		if [ -n "$per_test_logging" ]; then
+			logfile="/tmp/$BASENAME_TEST"
+			cat /dev/null > "$logfile"
+		fi
+		run_one "$DIR" "$TEST" "$test_num"
+	done
+}
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5979fdc4f36c..077337195783 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,17 +3,12 @@
 CC := $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
-    ifneq ($(O),)
-	OUTPUT := $(O)
-    else
-	ifneq ($(KBUILD_OUTPUT),)
-		OUTPUT := $(KBUILD_OUTPUT)
-	else
-		OUTPUT := $(shell pwd)
-		DEFAULT_INSTALL_HDR_PATH := 1
-	endif
+    ifeq ($(OUTPUT),)
+	OUTPUT := $(shell pwd)
+	DEFAULT_INSTALL_HDR_PATH := 1
     endif
 endif
+selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
@@ -65,44 +60,13 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
 .ONESHELL:
-define RUN_TEST_PRINT_RESULT
-	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
-	echo $$TEST_HDR_MSG;					\
-	echo "========================================";	\
-	if [ ! -x $$TEST ]; then	\
-		echo "$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.";\
-		echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]"; \
-	else					\
-		cd `dirname $$TEST` > /dev/null; \
-		if [ "X$(summary)" != "X" ]; then	\
-			(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
-			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") || \
-			(if [ $$? -eq $$skip ]; then	\
-				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]";				\
-			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";					\
-			fi;)			\
-		else				\
-			(./$$BASENAME_TEST &&	\
-			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") ||						\
-			(if [ $$? -eq $$skip ]; then \
-				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]"; \
-			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";				\
-			fi;)		\
-		fi;				\
-		cd - > /dev/null;		\
-	fi;
-endef
-
 define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;		\
-	test_num=`echo 0`;				\
-	skip=`echo 4`;					\
-	echo "TAP version 13";				\
-	for TEST in $(1); do				\
-		BASENAME_TEST=`basename $$TEST`;	\
-		test_num=`echo $$test_num+1 | bc`;	\
-		$(call RUN_TEST_PRINT_RESULT,$(TEST),$(BASENAME_TEST),$(test_num),$(skip))						\
-	done;
+	@BASE_DIR="$(selfdir)";			\
+	. $(selfdir)/kselftest/runner.sh;	\
+	if [ "X$(summary)" != "X" ]; then       \
+		per_test_logging=1;		\
+	fi;                                     \
+	run_many $(1)
 endef
 
 run_tests: all
@@ -139,24 +103,12 @@ else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
-define EMIT_TESTS
-	@test_num=`echo 0`;				\
+emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		test_num=`echo $$test_num+1 | bc`;	\
-		TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
-		echo "echo $$TEST_HDR_MSG";	\
-		if [ ! -x $$TEST ]; then	\
-			echo "echo \"$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.\"";		\
-			echo "echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\""; \
-		else
-			echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
-		fi;		\
-	done;
-endef
-
-emit_tests:
-	$(EMIT_TESTS)
+		echo "	\\";				\
+		echo -n "	\"$$BASENAME_TEST\"";	\
+	done;						\
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 6793f8ecc8e7..70b4ddbf126b 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -304,6 +304,7 @@ static int test_membarrier_query(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
+	ksft_set_plan(13);
 
 	test_membarrier_query();
 	test_membarrier();
diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
new file mode 100644
index 000000000000..822a1e63d045
--- /dev/null
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -0,0 +1 @@
+pidfd_test
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..5bae1792e3d6 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -371,6 +371,7 @@ static int test_pidfd_send_signal_syscall_support(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
+	ksft_set_plan(4);
 
 	test_pidfd_send_signal_syscall_support();
 	test_pidfd_send_signal_simple_success();
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index c30c52e1d0d2..d6469535630a 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
-CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
+
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
+CLANG_FLAGS += -no-integrated-as
+endif
+
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
+	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
 # Own dependencies because we only want to build against 1st prerequisite, but
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 3cea19877227..84f28f147fb6 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -5,7 +5,54 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+ * value 0x5de3. This traps if user-space reaches this instruction by mistake,
+ * and the uncommon operand ensures the kernel does not move the instruction
+ * pointer to attacker-controlled code on rseq abort.
+ *
+ * The instruction pattern in the A32 instruction set is:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * This translates to the following instruction pattern in the T16 instruction
+ * set:
+ *
+ * little endian:
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * pre-ARMv6 big endian code:
+ * e7f5        b.n    <7f5>
+ * def3        udf    #243      ; 0xf3
+ *
+ * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
+ * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
+ * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
+ * (which match), so there is no need to reverse the endianness of the data
+ * representation of the signature. However, the choice between BE32 and BE8
+ * is done by the linker, so we cannot know whether code and data endianness
+ * will be mixed before the linker is invoked.
+ */
+
+#define RSEQ_SIG_CODE	0xe7f5def3
+
+#ifndef __ASSEMBLER__
+
+#define RSEQ_SIG_DATA							\
+	({								\
+		int sig;						\
+		asm volatile ("b 2f\n\t"				\
+			      "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
+			      "2:\n\t"					\
+			      "ldr %[sig], 1b\n\t"			\
+			      : [sig] "=r" (sig));			\
+		sig;							\
+	})
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
+
+#endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -30,18 +77,35 @@ do {									\
 #include "rseq-skip.h"
 #else /* !RSEQ_SKIP_FASTPATH */
 
-#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,		\
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
 				post_commit_offset, abort_ip)		\
-		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
 		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"					\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".word " __rseq_str(label) "b, 0x0\n\t"			\
 		".popsection\n\t"
 
-#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip)	\
-	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,			\
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"adr r0, " __rseq_str(cs_label) "\n\t"			\
@@ -61,7 +125,8 @@ do {									\
 		__rseq_str(table_label) ":\n\t"				\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
-		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
+		".arm\n\t"						\
+		".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"		\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
 		"b %l[" __rseq_str(abort_label) "]\n\t"
@@ -86,7 +151,12 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -148,7 +218,12 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -214,7 +289,10 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -266,7 +344,12 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -336,7 +419,12 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -407,7 +495,13 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -485,7 +579,12 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"str %[src], %[rseq_scratch0]\n\t"
 		"str %[dst], %[rseq_scratch1]\n\t"
 		"str %[len], %[rseq_scratch2]\n\t"
@@ -604,7 +703,12 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"str %[src], %[rseq_scratch0]\n\t"
 		"str %[dst], %[rseq_scratch1]\n\t"
 		"str %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 954f34671ca6..200dae9e4208 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -6,7 +6,20 @@
  * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
  */
 
-#define RSEQ_SIG	0xd428bc00	/* BRK #0x45E0 */
+/*
+ * aarch64 -mbig-endian generates mixed endianness code vs data:
+ * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
+ * matches code endianness.
+ */
+#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
+#else
+#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb ish" ::: "memory")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb ishld" ::: "memory")
@@ -82,19 +95,35 @@ do {										\
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
 				post_commit_offset, abort_ip)			\
-	"	.pushsection	__rseq_table, \"aw\"\n"				\
+	"	.pushsection	__rseq_cs, \"aw\"\n"				\
 	"	.balign	32\n"							\
 	__rseq_str(label) ":\n"							\
 	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
 	"	.quad	" __rseq_str(start_ip) ", "				\
 			  __rseq_str(post_commit_offset) ", "			\
 			  __rseq_str(abort_ip) "\n"				\
+	"	.popsection\n\t"						\
+	"	.pushsection __rseq_cs_ptr_array, \"aw\"\n"				\
+	"	.quad " __rseq_str(label) "b\n"					\
 	"	.popsection\n"
 
 #define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+	"	.pushsection __rseq_exit_point_array, \"aw\"\n"			\
+	"	.quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
+	"	.popsection\n"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
 	RSEQ_INJECT_ASM(1)							\
 	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
@@ -105,7 +134,7 @@ do {										\
 
 #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
 	"	b	222f\n"							\
-	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
+	"	.inst 	"	__rseq_str(RSEQ_SIG_CODE) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
 	"222:\n"
@@ -182,6 +211,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -231,6 +265,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -282,6 +321,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -325,6 +367,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -379,6 +426,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -433,6 +485,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -490,6 +548,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -545,6 +608,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 7f48ecf46994..e989e7c14b09 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -7,7 +7,39 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the break instruction. The instruction pattern is:
+ *
+ * On MIPS:
+ *	0350000d        break     0x350
+ *
+ * On nanoMIPS:
+ *      00100350        break     0x350
+ *
+ * On microMIPS:
+ *      0000d407        break     0x350
+ *
+ * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-bit
+ * halfwords, so the signature halfwords need to be swapped accordingly for
+ * little-endian.
+ */
+#if defined(__nanomips__)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0x03500010
+# else
+#  define RSEQ_SIG	0x00100350
+# endif
+#elif defined(__mips_micromips)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0xd4070000
+# else
+#  define RSEQ_SIG	0x0000d407
+# endif
+#elif defined(__mips__)
+# define RSEQ_SIG	0x0350000d
+#else
+/* Unknown MIPS architecture. */
+#endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("sync" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
@@ -54,20 +86,38 @@ do {									\
 # error unsupported _MIPS_SZLONG
 #endif
 
-#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip, \
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip, \
 				post_commit_offset, abort_ip) \
-		".pushsection __rseq_table, \"aw\"\n\t" \
+		".pushsection __rseq_cs, \"aw\"\n\t" \
 		".balign 32\n\t" \
+		__rseq_str(label) ":\n\t"					\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
 		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
 		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
+		".popsection\n\t" \
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(label) "b") "\n\t" \
 		".popsection\n\t"
 
-#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip) \
-	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip, \
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip, \
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip) \
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(exit_ip)) "\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs) \
 		RSEQ_INJECT_ASM(1) \
 		LONG_LA " $4, " __rseq_str(cs_label) "\n\t" \
@@ -113,7 +163,12 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -173,7 +228,12 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -237,7 +297,10 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -289,7 +352,12 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -357,7 +425,12 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -426,7 +499,13 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -500,7 +579,12 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
@@ -616,7 +700,12 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S " %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 52630c9f42be..76be90196fe4 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -6,7 +6,15 @@
  * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG is used with the following trap instruction:
+ *
+ * powerpc-be:    0f e5 00 0b           twui   r5,11
+ * powerpc64-le:  0b 00 e5 0f           twui   r5,11
+ * powerpc64-be:  0f e5 00 0b           twui   r5,11
+ */
+
+#define RSEQ_SIG	0x0fe5000b
 
 #define rseq_smp_mb()		__asm__ __volatile__ ("sync"	::: "memory", "cc")
 #define rseq_smp_lwsync()	__asm__ __volatile__ ("lwsync"	::: "memory", "cc")
@@ -33,8 +41,8 @@ do {									\
 #else /* !RSEQ_SKIP_FASTPATH */
 
 /*
- * The __rseq_table section can be used by debuggers to better handle
- * single-stepping through the restartable critical sections.
+ * The __rseq_cs_ptr_array and __rseq_cs sections can be used by debuggers to
+ * better handle single-stepping through the restartable critical sections.
  */
 
 #ifdef __PPC64__
@@ -46,11 +54,14 @@ do {									\
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
-		".pushsection __rseq_table, \"aw\"\n\t"				\
+		".pushsection __rseq_cs, \"aw\"\n\t"				\
 		".balign 32\n\t"						\
 		__rseq_str(label) ":\n\t"					\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
 		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"						\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"			\
+		".quad " __rseq_str(label) "b\n\t"				\
 		".popsection\n\t"
 
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
@@ -63,6 +74,19 @@ do {									\
 		"std %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
 		__rseq_str(label) ":\n\t"
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #else /* #ifdef __PPC64__ */
 
 #define STORE_WORD	"stw "
@@ -72,12 +96,29 @@ do {									\
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
-		".pushsection __rseq_table, \"aw\"\n\t"				\
+		".pushsection __rseq_cs, \"aw\"\n\t"				\
 		".balign 32\n\t"						\
 		__rseq_str(label) ":\n\t"					\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
 		/* 32-bit only supported on BE */				\
 		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long 0x0, " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"		\
+		/* 32-bit only supported on BE */				\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t"	\
 		".popsection\n\t"
 
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
@@ -169,6 +210,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -224,6 +270,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -286,6 +337,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -337,6 +391,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -400,6 +459,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -465,6 +529,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -532,6 +602,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* setup for mempcy */
 		"mr %%r19, %[len]\n\t"
 		"mr %%r20, %[src]\n\t"
@@ -601,6 +676,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* setup for mempcy */
 		"mr %%r19, %[len]\n\t"
 		"mr %%r20, %[src]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 1069e85258ce..1d05c5187ae6 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+ * access-register mode nor the linkage stack this instruction will always
+ * cause a special-operation exception (the trap-enabled bit in the DUCT
+ * is and will stay 0). The instruction pattern is
+ *	b2 ff 0f ff	trap4   4095(%r0)
+ */
+#define RSEQ_SIG	0xB2FF0FFF
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
@@ -37,22 +44,54 @@ do {									\
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
-		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
 		".balign 32\n\t"					\
 		__rseq_str(label) ":\n\t"				\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".quad " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
 		".popsection\n\t"
 
 #elif __s390__
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
-		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
 		".balign 32\n\t"					\
 		__rseq_str(label) ":\n\t"				\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long 0x0, " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t" \
 		".popsection\n\t"
 
 #define LONG_L			"l"
@@ -85,14 +124,14 @@ do {									\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
-		"j %l[" __rseq_str(abort_label) "]\n\t"			\
+		"jg %l[" __rseq_str(abort_label) "]\n\t"		\
 		".popsection\n\t"
 
 #define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
-		"j %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		"jg %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
 static inline __attribute__((always_inline))
@@ -102,6 +141,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -160,6 +204,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -220,6 +269,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -268,6 +320,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -339,6 +396,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -407,6 +470,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S " %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 089410a314e9..b2da6004fe30 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -7,8 +7,25 @@
 
 #include <stdint.h>
 
+/*
+ * RSEQ_SIG is used with the following reserved undefined instructions, which
+ * trap in user-space:
+ *
+ * x86-32:    0f b9 3d 53 30 05 53      ud1    0x53053053,%edi
+ * x86-64:    0f b9 3d 53 30 05 53      ud1    0x53053053(%rip),%edi
+ */
 #define RSEQ_SIG	0x53053053
 
+/*
+ * Due to a compiler optimization bug in gcc-8 with asm goto and TLS asm input
+ * operands, we cannot use "m" input operands, and rather pass the __rseq_abi
+ * address through a "r" input operand.
+ */
+
+/* Offset of cpu_id and rseq_cs fields in struct rseq. */
+#define RSEQ_CPU_ID_OFFSET	4
+#define RSEQ_CS_OFFSET		8
+
 #ifdef __x86_64__
 
 #define rseq_smp_mb()	\
@@ -37,32 +54,49 @@ do {									\
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
-		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
 		".balign 32\n\t"					\
 		__rseq_str(label) ":\n\t"				\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".quad " __rseq_str(label) "b\n\t"			\
 		".popsection\n\t"
 
+
 #define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
-		"movq %%rax, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		"movq %%rax, " __rseq_str(rseq_cs) "\n\t"		\
 		__rseq_str(label) ":\n\t"
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
 		RSEQ_INJECT_ASM(2)					\
-		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
 		"jnz " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
-		/* Disassembler-friendly signature: nopl <sig>(%rip). */\
-		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		/* Disassembler-friendly signature: ud1 <sig>(%rip),%edi. */ \
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
@@ -83,15 +117,20 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -102,8 +141,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -140,16 +178,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movq %[v], %%rbx\n\t"
 		"cmpq %%rbx, %[expectnot]\n\t"
 		"je %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movq %[v], %%rbx\n\t"
 		"cmpq %%rbx, %[expectnot]\n\t"
 		"je %l[error2]\n\t"
@@ -164,8 +207,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -199,12 +241,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 #endif
 		/* final store */
 		"addq %[count], %[v]\n\t"
@@ -213,8 +258,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"er" (count)
@@ -244,15 +288,20 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -266,8 +315,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -314,9 +362,15 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
@@ -325,7 +379,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(5)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 		"cmpq %[v2], %[expect2]\n\t"
@@ -338,8 +392,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -381,18 +434,23 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movq %[src], %[rseq_scratch0]\n\t"
 		"movq %[dst], %[rseq_scratch1]\n\t"
 		"movq %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz 7f\n\t"
 #endif
@@ -440,8 +498,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -520,31 +577,47 @@ do {									\
  */
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
-		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
 		".balign 32\n\t"					\
 		__rseq_str(label) ":\n\t"				\
 		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long " __rseq_str(label) "b, 0x0\n\t"			\
 		".popsection\n\t"
 
 #define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
-		"movl $" __rseq_str(cs_label) ", %[rseq_cs]\n\t"	\
+		"movl $" __rseq_str(cs_label) ", " __rseq_str(rseq_cs) "\n\t"	\
 		__rseq_str(label) ":\n\t"
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
 		RSEQ_INJECT_ASM(2)					\
-		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
 		"jnz " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
-		/* Disassembler-friendly signature: nopl <sig>. */	\
-		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		/* Disassembler-friendly signature: ud1 <sig>,%edi. */	\
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
@@ -565,15 +638,20 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -584,8 +662,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -622,16 +699,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[error2]\n\t"
@@ -646,8 +728,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -681,12 +762,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 #endif
 		/* final store */
 		"addl %[count], %[v]\n\t"
@@ -695,8 +779,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"ir" (count)
@@ -726,15 +809,20 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -749,8 +837,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"m" (newv2),
@@ -788,16 +875,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[error2]\n\t"
@@ -813,8 +905,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -853,9 +944,15 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
@@ -864,7 +961,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(5)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 		"cmpl %[expect2], %[v2]\n\t"
@@ -878,8 +975,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -922,19 +1018,24 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movl %[src], %[rseq_scratch0]\n\t"
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -984,8 +1085,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
@@ -1030,19 +1130,24 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movl %[src], %[rseq_scratch0]\n\t"
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -1093,8 +1198,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..7159eb777fd3 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -25,18 +25,27 @@
 #include <syscall.h>
 #include <assert.h>
 #include <signal.h>
+#include <limits.h>
 
 #include "rseq.h"
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__attribute__((tls_model("initial-exec"))) __thread
-volatile struct rseq __rseq_abi = {
+__thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
-static __attribute__((tls_model("initial-exec"))) __thread
-volatile int refcount;
+/*
+ * Shared with other libraries. This library may take rseq ownership if it is
+ * still 0 when executing the library constructor. Set to 1 by library
+ * constructor when handling rseq. Set to 0 in destructor if handling rseq.
+ */
+int __rseq_handled;
+
+/* Whether this library have ownership of rseq registration. */
+static int rseq_ownership;
+
+static __thread volatile uint32_t __rseq_refcount;
 
 static void signal_off_save(sigset_t *oldset)
 {
@@ -69,8 +78,14 @@ int rseq_register_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (refcount++)
+	if (__rseq_refcount == UINT_MAX) {
+		ret = -1;
+		goto end;
+	}
+	if (__rseq_refcount++)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
@@ -78,9 +93,9 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = -2;
+		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
-	refcount--;
+	__rseq_refcount--;
 end:
 	signal_restore(oldset);
 	return ret;
@@ -91,13 +106,20 @@ int rseq_unregister_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (--refcount)
+	if (!__rseq_refcount) {
+		ret = -1;
+		goto end;
+	}
+	if (--__rseq_refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
+	__rseq_refcount = 1;
 	ret = -1;
 end:
 	signal_restore(oldset);
@@ -115,3 +137,20 @@ int32_t rseq_fallback_current_cpu(void)
 	}
 	return cpu;
 }
+
+void __attribute__((constructor)) rseq_init(void)
+{
+	/* Check whether rseq is handled by another library. */
+	if (__rseq_handled)
+		return;
+	__rseq_handled = 1;
+	rseq_ownership = 1;
+}
+
+void __attribute__((destructor)) rseq_fini(void)
+{
+	if (!rseq_ownership)
+		return;
+	__rseq_handled = 0;
+	rseq_ownership = 0;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6c1126e7f685..d40d60e7499e 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -44,6 +44,7 @@
 #endif
 
 extern __thread volatile struct rseq __rseq_abi;
+extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
 #define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 228c2ae47687..ad0f8df2ca0a 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -109,6 +109,7 @@ int main(void)
 	int err;
 
 	ksft_print_header();
+	ksft_set_plan(3);
 
 	sigemptyset(&act.sa_mask);
 	act.sa_flags = SA_ONSTACK | SA_SIGINFO;
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 7f7938263c5c..3824b66f41a0 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -86,6 +86,7 @@ int main(void)
 	int err;
 
 	ksft_print_header();
+	ksft_set_plan(3 + 7);
 
 	sync_api_supported();
 

--------------1A24A026F2D70035F17A721C--
