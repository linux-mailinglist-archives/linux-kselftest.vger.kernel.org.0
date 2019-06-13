Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B161843BA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfFMPag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfFMLOX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:14:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D758367;
        Thu, 13 Jun 2019 04:14:22 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CF53F694;
        Thu, 13 Jun 2019 04:16:04 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH 02/13] kselftest: arm64: adds arm64/signal support code
Date:   Thu, 13 Jun 2019 12:13:24 +0100
Message-Id: <20190613111335.7645-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613111335.7645-1-cristian.marussi@arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added some arm64/signal specific boilerplate and utility code to help
further testcase development. Still no test case code included though.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 .../testing/selftests/arm64/signal/.gitignore |   5 +
 tools/testing/selftests/arm64/signal/Makefile |  86 ++++++
 tools/testing/selftests/arm64/signal/README   |  56 ++++
 .../testing/selftests/arm64/signal/signals.S  |  64 +++++
 .../arm64/signal/test_arm64_signals.sh        |  44 +++
 .../selftests/arm64/signal/test_signals.c     |  30 ++
 .../selftests/arm64/signal/test_signals.h     | 136 ++++++++++
 .../arm64/signal/test_signals_utils.c         | 256 ++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         | 110 ++++++++
 .../arm64/signal/testcases/testcases.c        | 123 +++++++++
 .../arm64/signal/testcases/testcases.h        |  85 ++++++
 12 files changed, 996 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/signal/.gitignore
 create mode 100644 tools/testing/selftests/arm64/signal/Makefile
 create mode 100644 tools/testing/selftests/arm64/signal/README
 create mode 100644 tools/testing/selftests/arm64/signal/signals.S
 create mode 100755 tools/testing/selftests/arm64/signal/test_arm64_signals.sh
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.h

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 03a0d4f71218..af59dc74e0dc 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -6,7 +6,7 @@ ARCH ?= $(shell uname -m)
 ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
 
 ifeq ("x$(ARCH)", "xarm64")
-SUBDIRS :=
+SUBDIRS := signal
 else
 SUBDIRS :=
 endif
diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
new file mode 100644
index 000000000000..7234ebd99363
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -0,0 +1,5 @@
+# Helper script's internal testcases list (TPROGS) is regenerated
+# each time by Makefile on standalone (non KSFT driven) runs.
+# Committing such list creates a dependency between testcases
+# patches such that they are no more easily revertable. Just ignore.
+test_arm64_signals.sh
diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
new file mode 100644
index 000000000000..9518841124a3
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 ARM Limited
+
+# Supports also standalone invokation out of KSFT-tree.
+#
+# Build standalone with (issued from within the dir containing this makefile):
+#
+# 	host:~$ make clean && make INSTALL_PATH=<your-device-instdir> install
+#
+# Run standalone on device with:
+# 	device:~# <your-device-instdir>/test_arm64_signals.sh [-k|-v]
+#
+
+# A proper top_srcdir is needed both by KSFT(lib.mk)
+# and standalone builds
+top_srcdir = ../../../../..
+
+CFLAGS += -std=gnu99 -I. -I$(top_srcdir)/tools/testing/selftests/
+SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
+PROGS := $(patsubst %.c,%,$(SRCS))
+
+# Guessing as best as we can where the Kernel headers
+# could have been installed depending on ENV config and
+# type of invocation.
+ifeq ($(KBUILD_OUTPUT),)
+khdr_dir = $(top_srcdir)/usr/include
+else
+ifeq (0,$(MAKELEVEL))
+khdr_dir = $(KBUILD_OUTPUT)/usr/include
+else
+# the KSFT preferred location when KBUILD_OUTPUT is set
+khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
+endif
+endif
+
+CFLAGS += -I$(khdr_dir)
+
+# Standalone run
+ifeq (0,$(MAKELEVEL))
+CC := $(CROSS_COMPILE)gcc
+RUNNER = test_arm64_signals.sh
+INSTALL_PATH ?= install/
+
+all: $(RUNNER)
+
+$(RUNNER): $(PROGS)
+	sed -i -e 's#PROGS=.*#PROGS="$(PROGS)"#' $@
+
+install: all
+	mkdir -p $(INSTALL_PATH)/testcases
+	cp $(PROGS) $(INSTALL_PATH)/testcases
+	cp $(RUNNER) $(INSTALL_PATH)/
+
+.PHONY clean:
+	rm -f $(PROGS)
+# KSFT run
+else
+# Generated binaries to be installed by top KSFT script
+TEST_GEN_PROGS := $(notdir $(PROGS))
+
+# Get Kernel headers installed and use them.
+KSFT_KHDR_INSTALL := 1
+
+# This include mk will also mangle the TEST_GEN_PROGS list
+# to account for any OUTPUT target-dirs optionally provided
+# by the toplevel makefile
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): $(PROGS)
+	-mkdir -p $(OUTPUT)
+	-cp $(PROGS) $(OUTPUT)/
+
+clean:
+	$(CLEAN)
+	rm -f $(PROGS)
+endif
+
+# Common test-unit targets to build common-layout test-cases executables
+# Needs secondary expansion to properly include the testcase c-file in pre-reqs
+.SECONDEXPANSION:
+$(PROGS): test_signals.c test_signals_utils.c signals.S testcases/testcases.c $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
+	@if [ ! -d $(khdr_dir) ]; then \
+		echo -n "\n!!! WARNING: $(khdr_dir) NOT FOUND."; \
+		echo "===>  Are you sure Kernel Headers have been installed properly ?\n"; \
+	fi
+	$(CC) $(CFLAGS) $^ -o $@
diff --git a/tools/testing/selftests/arm64/signal/README b/tools/testing/selftests/arm64/signal/README
new file mode 100644
index 000000000000..315d77558e14
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/README
@@ -0,0 +1,56 @@
+KSelfTest arm64/signal/
+=======================
+
+Signals Tests
++++++++++++++
+
+- Tests are built around a common main compilation unit: such shared main
+  enforces a standard sequence of operations needed to perform a single
+  signal-test (setup/trigger/run/result/cleanup)
+
+- The above mentioned ops are configurable on a test-by-test basis: each test
+  is described (and configured) using the descriptor signals.h::struct tdescr
+
+- Each signal testcase is compiled into its own executable: a separate
+  executable is used for each test since many tests complete successfully
+  by receiving some kind of 'Term' signal from the Kernel, so it's safer
+  to run each test unit in its own standalone process, so as to start each
+  test from a clean-slate.
+
+- New tests can be simply defined in testcases/ dir providing a proper struct
+  tdescr overriding all the defaults we wish to change (as of now providing a
+  custom run method is mandatory though)
+
+- Signals' test-cases hereafter defined belong currently to two
+  principal families:
+
+  - 'mangle_' tests: a real signal (SIGUSR1) is raised and used as a trigger
+    and then the test case code messes-up with the sigframe ucontext_t from
+    inside the sighandler itself.
+
+  - 'fake_sigreturn_' tests: a brand new custom artificial sigframe structure
+    is placed on the stack and a sigreturn syscall is called to simulate a
+    real signal return. This kind of tests does not use a trigger usually and
+    they are just fired using some simple included assembly trampoline code.
+
+ - Most of these tests are successfully passing if the process gets killed by
+   some 'Term' signal: usually SIGSEGV or SIGBUS. Since, while writing this
+   kind of tests, it is extremely easy in fact to end-up injecting other
+   unrelated SEGV bugs in the testcases, it becomes extremely tricky to
+   be really sure that the tests are really addressing what they are meant
+   to address and they are not instead falling apart due to unplanned bugs.
+   In order to alleviate the misery of the life of such test-developer, a few
+   helpers are provided:
+
+   - a couple of ASSERT_BAD/GOOD_CONTEXT() macros to easily parse a ucontext_t
+     and verify if it is indeed GOOD or BAD (depending on what we were
+     expecting), using the same logic/perspective as in the arm64 Kernel signals
+     routines.
+
+   - a sanity mechanism to be used in 'fake_sigreturn_'-alike tests: enabled by
+     default it takes care to verify that the test-execution had at least
+     successfully progressed upto the stage of triggering the fake sigreturn
+     call.
+
+  In both cases test results are expected in terms of some 'Term' signal sent
+  by the Kernel to the test process, or analyzing some final regs state.
diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
new file mode 100644
index 000000000000..4f510b3a3b4b
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/signals.S
@@ -0,0 +1,64 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2019 ARM Limited
+ */
+
+#include <asm/unistd.h>
+
+.section	.rodata
+call_fmt:
+	.asciz "Calling sigreturn with fake sigframe sized:%zd at calculated SP @%08lX\n"
+
+.text
+
+.extern current
+
+.globl fake_sigreturn
+
+/*	fake_sigreturn	x0:&sigframe  x1:sigframe_size  x2:alignment_SP */
+fake_sigreturn:
+	stp x20, x21, [sp, #-16]!
+	stp x22, x23, [sp, #-16]!
+
+	mov x20, x0
+	mov x21, x1
+	mov x22, x2
+	mov x23, sp
+
+	/* create space on the stack for fake sigframe..."x22"-aligned */
+	mov x0, #0
+	add x0, x21, x22
+	sub x22, x22, #1
+	bic x0, x0, x22
+	sub x23, x23, x0
+
+	ldr x0, =call_fmt
+	mov x1, x21
+	mov x2, x23
+	bl printf
+
+	mov sp, x23
+
+	/* now fill it with the provided content... */
+	mov x0, sp
+	mov x1, x20
+	mov x2, x21
+	bl memcpy
+
+	/*
+	 * Here saving a last minute SP to current->token acts as a marker:
+	 * if we got here, we are successfully faking a sigreturn; in other
+	 * words we are reasonably sure no bad Term signal has been raised
+	 * till now for unrelated reasons, so we should consider the possibly
+	 * observed SEGV coming from Kernel restore_sigframe() and triggered
+	 * as expected from our test-case.
+	 * For simplicity field 'token' is laid out as first in struct tdescr
+	 */
+	ldr x0, current
+	str x23, [x0, #0]
+	/* SP is already pointing back to the just built fake sigframe here */
+	mov x8, #__NR_rt_sigreturn
+	svc #0
+
+	/* This should not return here...looping lead to a timeout */
+	b .
diff --git a/tools/testing/selftests/arm64/signal/test_arm64_signals.sh b/tools/testing/selftests/arm64/signal/test_arm64_signals.sh
new file mode 100755
index 000000000000..ecaa5a67d3ca
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/test_arm64_signals.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 ARM Limited
+
+ret=0
+keep_on_fail=0
+err_out="2> /dev/null"
+
+# avoiding getopt
+while [ $# -gt 0 ]
+do
+	case $1 in
+		"-k")
+			keep_on_fail=1
+			shift
+			;;
+		"-v")
+			err_out=""
+			shift
+			;;
+		*)
+			shift
+			;;
+	esac
+done
+
+TPROGS=
+
+i=0
+tot=$(echo $TPROGS | wc -w)
+
+for test in $TPROGS
+do
+	eval ./$test $err_out
+	if [ $? != 0 ]; then
+		[ $keep_on_fail = 0 ] && echo "===>>> FAILED:: $test <<<===" && ret=1 && break
+	else
+		i=$((i + 1))
+	fi
+done
+
+echo "==>> PASSED: $i/$tot"
+
+exit $ret
diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
new file mode 100644
index 000000000000..afadb8ae33e4
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stddef.h>
+
+#include <kselftest.h>
+
+#include "test_signals.h"
+#include "test_signals_utils.h"
+
+struct tdescr *current;
+extern struct tdescr tde;
+
+int main(int argc, char *argv[])
+{
+	current = &tde;
+
+	ksft_print_msg("%s :: %s - SIG_TRIG:%d  SIG_OK:%d -- current:%p\n",
+		       current->name, current->descr, current->sig_trig,
+		       current->sig_ok, current);
+	if (test_setup(current)) {
+		if (test_run(current))
+			test_result(current);
+		test_cleanup(current);
+	}
+
+	return !current->pass;
+}
diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
new file mode 100644
index 000000000000..49536326db04
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#ifndef __TEST_SIGNALS_H__
+#define __TEST_SIGNALS_H__
+
+#include <assert.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <ucontext.h>
+#include <stdint.h>
+
+/*
+ * Using ARCH specific and sanitized Kernel headers installed by KSFT
+ * framework since we asked for it by setting flag KSFT_KHDR_INSTALL
+ * in our Makefile.
+ */
+#include <asm/ptrace.h>
+#include <asm/hwcap.h>
+
+/* pasted from include/linux/stringify.h */
+#define __stringify_1(x...)	#x
+#define __stringify(x...)	__stringify_1(x)
+
+#define FEAT_SSBS		(1 << 0)
+#define FEAT_PAN		(1 << 1)
+#define FEAT_UAO		(1 << 2)
+
+ /*
+  * Reads a sysreg using the, possibly provided, S3_ encoding in order to
+  * avoid inject any dependency on the used toolchain regarding possibly
+  * still unsupported ARMv8 extensions.
+  *
+  * Using a standard mnemonic here to indicate the specific sysreg (like SSBS)
+  * would introduce a compile-time dependency on possibly unsupported ARMv8
+  * Extensions: you could end-up failing to build the test depending on the
+  * available toolchain.
+  * This is undesirable since some tests, even if specifically targeted at some
+  * ARMv8 Extensions, can be plausibly run even on hardware lacking the above
+  * optional ARM features. (SSBS bit preservation is an example: Kernel handles
+  * it transparently not caring at all about the effective set of supported
+  * features).
+  * On the other side we will expect to observe different behaviours if the
+  * feature is supported or not: usually getting a SIGILL when trying to use
+  * unsupported features. For this reason we have anyway in place some
+  * preliminary run-time checks about the cpu effectively supported features.
+  *
+  * This helper macro is meant to be used for regs readable at EL0, BUT some
+  * EL1 sysregs are indeed readable too through MRS emulation Kernel-mechanism
+  * if the required reg is included in the supported encoding space:
+  *
+  *  Documentation/arm64/cpu-feature-regsiters.txt
+  *
+  *  "The infrastructure emulates only the following system register space:
+  *   	Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7
+  */
+#define get_regval(regname, out) \
+	asm volatile("mrs %0, " __stringify(regname) : "=r" (out) :: "memory")
+
+/* Regs encoding and masks naming copied in from sysreg.h */
+#define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
+#define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
+#define ID_AA64MMFR1_PAN_SHIFT	20
+#define ID_AA64MMFR2_UAO_SHIFT	4
+
+/* Local Helpers */
+#define IS_PAN_SUPPORTED(val) \
+	(!!((val) & (0xf << ID_AA64MMFR1_PAN_SHIFT)))
+#define IS_UAO_SUPPORTED(val) \
+	(!!((val) & (0xf << ID_AA64MMFR2_UAO_SHIFT)))
+
+#define MRS_SSBS_SYSREG		S3_3_C4_C2_6	/* EL0 supported */
+#define MRS_SSBS_BIT		(1 << 12)
+
+/*
+ * A descriptor used to describe and configure a test case.
+ * Fields with a non-trivial meaning are described inline in the following.
+ */
+struct tdescr {
+	/* KEEP THIS FIELD FIRST for easier lookup from assembly */
+	void		*token;
+	/* when disabled token based sanity checking is skipped in handler */
+	bool		sanity_disabled;
+	/* just a name for the test-case; manadatory field */
+	char		*name;
+	char		*descr;
+	unsigned long	feats_required;
+	/* bitmask of effectively supported feats: populated at run-time */
+	unsigned long	feats_supported;
+	bool		feats_ok;
+	bool		initialized;
+	unsigned int	minsigstksz;
+	/* signum used as a test trigger. Zero if no trigger-signal is used */
+	int		sig_trig;
+	/*
+	 * signum considered as a successfull test completion.
+	 * Zero when no signal is expected on success
+	 */
+	int		sig_ok;
+	/* signum expected on unsupported CPU features. */
+	int		sig_unsupp;
+	/*
+	 * used to grab a sigcontext from a signal handler
+	 * automatically set to SIGUSR2 if not configured
+	 */
+	int		sig_copyctx;
+	/* a timeout in second for test completion */
+	unsigned int	timeout;
+	bool		triggered;
+	unsigned int	handled;
+	bool		pass;
+	/* optional sa_flags for the installed handler */
+	int		sa_flags;
+	ucontext_t	saved_uc;
+	/* used by copy_ctx */
+	ucontext_t	*live_uc;
+	size_t		live_sz;
+
+	/* a setup function to be called before test starts */
+	int (*setup)(struct tdescr *td);
+	int (*cleanup)(struct tdescr *td);
+
+	/* an optional function to be used as a trigger for test starting */
+	int (*trigger)(struct tdescr *td);
+	/*
+	 * the actual test-core: invoked differently depending on the
+	 * presence of the trigger function above; this is mandatory
+	 */
+	int (*run)(struct tdescr *td, siginfo_t *si, ucontext_t *uc);
+
+	/* an optional function for custom results' processing */
+	int (*check_result)(struct tdescr *td);
+
+	void *priv;
+};
+#endif
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
new file mode 100644
index 000000000000..c00ba355dc1b
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <assert.h>
+#include <sys/auxv.h>
+#include <linux/auxvec.h>
+
+#include "test_signals.h"
+#include "test_signals_utils.h"
+#include "testcases/testcases.h"
+
+extern struct tdescr *current;
+
+void dump_uc(const char *prefix, ucontext_t *uc, int filter)
+{
+	int i;
+
+	if (prefix)
+		fprintf(stderr, "%s", prefix);
+	if (filter & DUMP_REGS)
+		for (i = 0; i < 29; i++)
+			fprintf(stderr, "x%02d:%016llX\n",
+				i, uc->uc_mcontext.regs[i]);
+	if (filter & DUMP_FP)
+		fprintf(stderr, "x%02d(fp):%016llX\n",
+			i, uc->uc_mcontext.regs[i]);
+	i++;
+	if (filter & DUMP_LR)
+		fprintf(stderr, "x%02d(lr):%016llX\n",
+			i, uc->uc_mcontext.regs[i]);
+	if (filter & DUMP_SP)
+		fprintf(stderr, "sp:%016llX\n", uc->uc_mcontext.sp);
+	if (filter & DUMP_PC)
+		fprintf(stderr, "pc:%016llX\n", uc->uc_mcontext.pc);
+	if (filter & DUMP_PSTATE)
+		fprintf(stderr, "pstate:%016llX\n", uc->uc_mcontext.pstate);
+	if (filter & DUMP_FAULT)
+		fprintf(stderr, "fault_address:%016llX\n",
+			uc->uc_mcontext.fault_address);
+}
+
+static void unblock_signal(int signum)
+{
+	sigset_t sset;
+
+	sigemptyset(&sset);
+	sigaddset(&sset, signum);
+	sigprocmask(SIG_UNBLOCK, &sset, NULL);
+}
+
+static int default_result(struct tdescr *td, int force_exit);
+
+static void default_handler(int signum, siginfo_t *si, void *uc)
+{
+	if (signum == current->sig_trig) {
+		SAFE_WRITE(2, "Handling SIG_TRIG\n");
+		current->triggered = 1;
+		/* ->run was asserted NON-NULL in test_setup() already */
+		current->run(current, si, uc);
+	} else if (signum == SIGILL && !current->initialized) {
+		/*
+		 * A SIGILL here while still not initialized means we fail
+		 * to even asses the existence of feature
+		 */
+		SAFE_WRITE(1, "Marking UNSUPPORTED features.\n");
+	} else if (current->sig_ok && signum == current->sig_ok) {
+		/* it's a bug in the test code when this assert fail */
+		assert(!current->sig_trig || current->triggered);
+		if (!current->sanity_disabled) {
+			fprintf(stderr,
+				"SIG_OK -- si_addr@:0x%p  token@:0x%p\n",
+				si->si_addr, current->token);
+			assert(current->token);
+		}
+		SAFE_WRITE(2, "Handling SIG_OK\n");
+		current->pass = 1;
+		current->handled++;
+		/*
+		 * Some tests can lead to SEGV loops: in such a case we want
+		 * to terminate immediately exiting straight away
+		 */
+		default_result(current, 1);
+	} else if (current->sig_copyctx && signum == current->sig_copyctx) {
+		memcpy(current->live_uc, uc, current->live_sz);
+		ASSERT_GOOD_CONTEXT(current->live_uc);
+		SAFE_WRITE(2,
+			   "GOOD CONTEXT grabbed from sig_copyctx handler\n");
+	} else {
+		if (signum == current->sig_unsupp && !current->feats_ok) {
+			SAFE_WRITE(2, "-- RX SIG_UNSUPP on unsupported feature...OK\n");
+			current->pass = 1;
+		} else if (signum == SIGALRM && current->timeout) {
+			SAFE_WRITE(2, "-- Timeout !\n");
+		} else {
+			SAFE_WRITE(2, "-- UNEXPECTED SIGNAL\n");
+		}
+		default_result(current, 1);
+	}
+}
+
+static int default_setup(struct tdescr *td)
+{
+	struct sigaction sa;
+
+	sa.sa_sigaction = default_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (td->sa_flags)
+		sa.sa_flags |= td->sa_flags;
+	sigemptyset(&sa.sa_mask);
+	/* uncatchable signals naturally skipped ... */
+	for (int sig = 1; sig < 32; sig++)
+		sigaction(sig, &sa, NULL);
+	/*
+	 * RT Signals default disposition is Term but they cannot be
+	 * generated by the Kernel in response to our tests; so just catch
+	 * them all and report them as UNEXPECTED signals.
+	 */
+	for (int sig = SIGRTMIN; sig <= SIGRTMAX; sig++)
+		sigaction(sig, &sa, NULL);
+
+	/* just in case...unblock explicitly all we need */
+	if (td->sig_trig)
+		unblock_signal(td->sig_trig);
+	if (td->sig_ok)
+		unblock_signal(td->sig_ok);
+	if (td->sig_unsupp)
+		unblock_signal(td->sig_unsupp);
+
+	if (td->timeout) {
+		unblock_signal(SIGALRM);
+		alarm(td->timeout);
+	}
+	fprintf(stderr, "Registered handlers for all signals.\n");
+
+	return 1;
+}
+
+static inline int default_trigger(struct tdescr *td)
+{
+	return !raise(td->sig_trig);
+}
+
+static int default_result(struct tdescr *td, int force_exit)
+{
+	if (td->pass)
+		SAFE_WRITE(2, "==>> completed. PASS(1)\n");
+	else
+		SAFE_WRITE(1, "==>> completed. FAIL(0)\n");
+	if (!force_exit)
+		return td->pass;
+	else
+		exit(td->pass ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+
+static int test_init(struct tdescr *td)
+{
+	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
+	if (!td->minsigstksz)
+		td->minsigstksz = MINSIGSTKSZ;
+	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
+
+	if (td->feats_required) {
+		td->feats_supported = 0;
+		/*
+		 * Checking for CPU required features using both the
+		 * auxval and the arm64 MRS Emulation to read sysregs.
+		 */
+		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
+			uint64_t val = 0;
+
+			if (td->feats_required & FEAT_SSBS) {
+				if (getauxval(AT_HWCAP) & HWCAP_SSBS)
+					td->feats_supported |= FEAT_SSBS;
+			}
+			if (td->feats_required & FEAT_PAN) {
+				get_regval(SYS_ID_AA64MMFR1_EL1, val);
+				if (IS_PAN_SUPPORTED(val))
+					td->feats_supported |= FEAT_PAN;
+			}
+			if (td->feats_required & FEAT_UAO) {
+				get_regval(SYS_ID_AA64MMFR2_EL1 , val);
+				if (IS_UAO_SUPPORTED(val))
+					td->feats_supported |= FEAT_UAO;
+			}
+		} else {
+			fprintf(stderr,
+				"CPUID regs NOT available. Marking features unsupported\n");
+		}
+		td->feats_ok = td->feats_required == td->feats_supported;
+		fprintf(stderr, "Required Features %08lX are %ssupported\n",
+		       td->feats_required, !td->feats_ok ? "NOT " : "");
+	}
+
+	if (!td->sig_copyctx) {
+		if (td->sig_trig != SIGUSR2)
+			td->sig_copyctx = SIGUSR2;
+		else if (td->sig_trig != SIGUSR1)
+			td->sig_copyctx = SIGUSR1;
+		else
+			td->sig_copyctx = 0;
+	}
+
+	if (td->sig_copyctx)
+		unblock_signal(td->sig_copyctx);
+
+	td->initialized = 1;
+	return 1;
+}
+
+int test_setup(struct tdescr *td)
+{
+	/* assert core invariants symptom of a rotten testcase */
+	assert(current);
+	assert(td);
+	assert(td->name);
+	assert(td->run);
+
+	if (!test_init(td))
+		return 0;
+
+	if (td->setup)
+		return td->setup(td);
+	else
+		return default_setup(td);
+}
+
+int test_run(struct tdescr *td)
+{
+	if (td->sig_trig) {
+		if (td->trigger)
+			return td->trigger(td);
+		else
+			return default_trigger(td);
+	} else {
+		return td->run(td, NULL, NULL);
+	}
+}
+
+int test_result(struct tdescr *td)
+{
+	if (td->check_result)
+		td->check_result(td);
+	return default_result(td, 0);
+}
+
+int test_cleanup(struct tdescr *td)
+{
+	if (td->cleanup)
+		return td->cleanup(td);
+	else
+		return 1;
+}
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
new file mode 100644
index 000000000000..e7ebae8e8077
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#ifndef __TEST_SIGNALS_UTILS_H__
+#define __TEST_SIGNALS_UTILS_H__
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <ucontext.h>
+#include <string.h>
+
+#include <asm/unistd.h>
+
+#include "test_signals.h"
+
+#define DUMP_REGS	(1 << 0)
+#define DUMP_FP		(1 << 1)
+#define DUMP_LR		(1 << 2)
+#define DUMP_SP		(1 << 3)
+#define DUMP_PC		(1 << 4)
+#define DUMP_PSTATE	(1 << 5)
+#define DUMP_FAULT	(1 << 6)
+#define DUMP_ALL	0xffffffff
+
+/* Using a signal-safe function to write something out */
+#define SAFE_WRITE(fd, str) \
+	do { \
+		int bytes = 0; \
+		bytes = write((fd), (str) + bytes, sizeof(str) - bytes); \
+		if (bytes < 0 || bytes == sizeof(str)) \
+			break; \
+	} while(1)
+
+/* Be careful this helper is NOT signal-safe */
+void dump_uc(const char *prefix, ucontext_t *uc, int filter);
+
+int test_setup(struct tdescr *td);
+int test_cleanup(struct tdescr *td);
+int test_run(struct tdescr *td);
+int test_result(struct tdescr *td);
+int fake_sigreturn(void *sigframe, size_t sz, int alignment);
+
+/*
+ * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
+ * libc getcontext does() not save all the regs and messes with some of
+ * them (pstate value in particular is not reliable).
+ * Here we use a service signal to grab the ucontext_t from inside a
+ * dedicated signal handler, since there, it is populated by Kernel
+ * itself in setup_sigframe(). The grabbed context is then stored and
+ * made available in td->live_uc.
+ *
+ * Anyway this function really serves a dual purpose:
+ *
+ * 1. grab a valid sigcontext into td->live_uc for result analysis: in
+ * such case it returns 1.
+ *
+ * 2. detect if somehow a previously grabbed live_uc context has been
+ * used actively with a sigreturn: in such a case the execution would have
+ * magically resumed in the middle of the function itself (seen_already==1):
+ * in such a case return 0, since in fact we have not just simply grabbed
+ * the context.
+ *
+ * This latter case is useful to detect when a fake_sigreturn test-case has
+ * unexpectedly survived without hittig a SEGV.
+ */
+static inline __attribute__((always_inline))
+int get_current_context(struct tdescr *td, ucontext_t *uc)
+{
+	static volatile int seen_already;
+
+	if (!td || !td->sig_copyctx || !uc) {
+		SAFE_WRITE(1, "Signal-based Context dumping NOT available\n");
+		return 0;
+	}
+
+	/* it's a genuine invokation..reinit */
+	seen_already = 0;
+	td->live_uc = uc;
+	td->live_sz = sizeof(*uc);
+	memset(td->live_uc, 0x00, td->live_sz);
+	/*
+	 * Grab ucontext_t triggering a signal...
+	 * ASM equivalent of raise(td->sig_copyctx);
+	 */
+	asm volatile ("mov x8, %0\n\t"
+		      "svc #0\n\t"
+		      "mov x1, %1\n\t"
+		      "mov x8, %2\n\t"
+		      "svc #0" :
+		      : "r" (__NR_getpid),
+		        "r" (td->sig_copyctx),
+			"r" (__NR_kill)
+		      : "memory");
+
+	/*
+	 * If we get here with seen_already==1 it implies the td->live_uc
+	 * context has been used to get back here....this probably means
+	 * a test has failed to cause a SEGV...anyway the live_uc has not
+	 * just been acquired...so return 0
+	 */
+	if (seen_already) {
+		SAFE_WRITE(1, "....and we're back....seen_already !\n");
+		return 0;
+	}
+	seen_already = 1;
+
+	return 1;
+}
+
+#endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
new file mode 100644
index 000000000000..9f83f3517325
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -0,0 +1,123 @@
+#include "testcases.h"
+
+struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
+				size_t resv_sz, size_t *offset)
+{
+	size_t offs = 0;
+
+	while (head && head->magic != magic && offs < resv_sz - HDR_SZ) {
+		offs += head->size;
+		head = GET_RESV_NEXT_HEAD(head);
+	}
+	if (!head || head->magic != magic)
+		return NULL;
+	else if (offset)
+		*offset = offs;
+
+	return head;
+}
+
+bool validate_extra_context(struct extra_context *extra, char **err)
+{
+	struct _aarch64_ctx *term;
+
+	if (!extra || !err)
+		return false;
+
+	fprintf(stderr, "Validating EXTRA...\n");
+	term = GET_RESV_NEXT_HEAD(extra);
+	if (!term || term->magic || term->size) {
+		SET_CTX_ERR("UN-Terminated EXTRA context");
+		return false;
+	}
+	if (extra->datap & ~0x10UL)
+		SET_CTX_ERR("Extra DATAP misaligned");
+	else if (extra->size & ~0x10UL)
+		SET_CTX_ERR("Extra SIZE misaligned");
+	else if (extra->datap != (uint64_t)term + sizeof(*term))
+		SET_CTX_ERR("Extra DATAP broken");
+	if (*err)
+		return false;
+
+	fprintf(stderr, "GOOD EXTRA CONTEXT FOUND !\n");
+
+	return true;
+}
+
+bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
+{
+	bool terminated = false;
+	size_t offs = 0;
+	int flags = 0;
+	struct extra_context *extra = NULL;
+	struct _aarch64_ctx *head =
+		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
+
+	if (!err)
+		return false;
+	/* Walk till the end terminator verifying __reserved contents */
+	while (head && !terminated && offs < resv_sz) {
+		if ((uint64_t)head & 0x0fUL) {
+			SET_CTX_ERR("Misaligned HEAD");
+			return false;
+		}
+
+		switch (head->magic) {
+			case 0:
+				if (head->size)
+					SET_CTX_ERR("Bad size for MAGIC0");
+				else
+					terminated = true;
+				break;
+			case FPSIMD_MAGIC:
+				if (flags & FPSIMD_CTX)
+					SET_CTX_ERR("Multiple FPSIMD");
+				else if (head->size !=
+					 sizeof(struct fpsimd_context))
+					SET_CTX_ERR("Bad size for FPSIMD context");
+				flags |= FPSIMD_CTX;
+				break;
+			case ESR_MAGIC:
+				if (head->size != sizeof(struct esr_context))
+					SET_CTX_ERR("Bad size for ESR context");
+				break;
+			case SVE_MAGIC:
+				if (flags & SVE_CTX)
+					SET_CTX_ERR("Multiple SVE");
+				else if (head->size !=
+					 sizeof(struct sve_context))
+					SET_CTX_ERR("Bad size for SVE context");
+				flags |= SVE_CTX;
+				break;
+			case EXTRA_MAGIC:
+				if (flags & EXTRA_CTX)
+					SET_CTX_ERR("Multiple EXTRA");
+				else if (head->size !=
+					 sizeof(struct extra_context))
+					SET_CTX_ERR("Bad size for EXTRA context");
+				flags |= EXTRA_CTX;
+				extra = (struct extra_context *)head;
+				break;
+			default:
+				SET_CTX_ERR("Unknown MAGIC !");
+				break;
+		}
+
+		if (*err)
+			return false;
+
+		offs += head->size;
+		if (resv_sz - offs < sizeof(*head)) {
+			SET_CTX_ERR("Broken HEAD");
+			return false;
+		}
+
+		if (flags & EXTRA_CTX)
+			if (!validate_extra_context(extra, err))
+				return false;
+
+		head = GET_RESV_NEXT_HEAD(head);
+	}
+
+	return true;
+}
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
new file mode 100644
index 000000000000..4f704c1501aa
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -0,0 +1,85 @@
+#ifndef __TESTCASES_H__
+#define __TESTCASES_H__
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <ucontext.h>
+
+#include <asm/sigcontext.h>
+
+#define FPSIMD_CTX	(1 << 0)
+#define SVE_CTX		(1 << 1)
+#define EXTRA_CTX	(1 << 2)
+
+#define HDR_SZ \
+	sizeof(struct _aarch64_ctx)
+
+#define GET_SF_RESV_HEAD(sf) \
+	(struct _aarch64_ctx *)(&sf.uc.uc_mcontext.__reserved)
+
+#define GET_SF_RESV_SIZE(sf) \
+	sizeof(sf.uc.uc_mcontext.__reserved)
+
+#define GET_UCP_RESV_SIZE(ucp) \
+	sizeof(((ucontext_t *)ucp)->uc_mcontext.__reserved)
+
+#define ASSERT_BAD_CONTEXT(uc) \
+	do { \
+		char *err = NULL; \
+		assert(!validate_reserved((uc), GET_UCP_RESV_SIZE((uc)), &err)); \
+		if (err) \
+			fprintf(stderr, "Using badly built context - ERR: %s\n", err);\
+	} while(0)
+
+#define ASSERT_GOOD_CONTEXT(uc) \
+	do { \
+		char *err = NULL; \
+		if (!validate_reserved((uc), GET_UCP_RESV_SIZE((uc)), &err)) { \
+			if (err) \
+				fprintf(stderr, "Detected BAD context - ERR: %s\n", err);\
+			assert(0); \
+		} else { \
+			fprintf(stderr, "uc context validated.\n"); \
+		} \
+	} while(0)
+
+/* head->size accounts both for payload and header _aarch64_ctx size ! */
+#define GET_RESV_NEXT_HEAD(h) \
+	(struct _aarch64_ctx *)((uint8_t *)(h) + (h)->size)
+
+#define SET_CTX_ERR(str) \
+	do { \
+		if (err) \
+			*err = str; \
+	} while(0)
+
+struct a_sigframe {
+	siginfo_t	info;
+	ucontext_t	uc;
+};
+
+
+bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
+
+bool validate_extra_context(struct extra_context *extra, char **err);
+
+struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
+				size_t resv_sz, size_t *offset);
+
+static inline struct _aarch64_ctx *get_terminator(struct _aarch64_ctx *head,
+						  size_t resv_sz,
+						  size_t *offset)
+{
+	return get_header(head, 0, resv_sz, offset);
+}
+
+static inline void write_terminator(struct _aarch64_ctx *tail)
+{
+	if (tail) {
+		tail->magic = 0;
+		tail->size = 0;
+	}
+}
+#endif
-- 
2.17.1

