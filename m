Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8619B309
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbgDAQs5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 12:48:57 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34550 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389197AbgDAQpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 12:45:05 -0400
Received: by mail-il1-f193.google.com with SMTP id t11so635338ils.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Apr 2020 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=GzC8rYXGYzGqzM0/qOgYjHU8XCBLMmZxnUS2AONxro0=;
        b=eDI+izdoJRLiSaXoPSyU8javBDdLe5Ub5E1JQFmW2GvemAvWXFE5c2JI7lw+6117Fj
         GxTK5QOrBge4tHg6u7fRMyAIF7ZYKmRH2Lniyd4JUco7qQRyO1uS4VwuJoOhaybua/sW
         YVVGKUmztWUD4geenVzZBjeg13+G7KIC1IDYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=GzC8rYXGYzGqzM0/qOgYjHU8XCBLMmZxnUS2AONxro0=;
        b=LnE07zoW54Ia4MBvCdi2DmlMIks3XfJRcxtAzU4AWAr9/jNGkn1Jfy4L/ITIYOC4vu
         SfEvCt7i/J4ujN8h/MDHYAE3p0LGC7r3lmi3V33Sfz8SLY7xcXhy/pfKsg+tHPgo8PRX
         pU2tQXq4hUWvsV0yZXmN4I3vPxowwW8yU+rsxnM5n0eL1RzbSVm/BkQRt1VqC+Emfxfz
         KfA1Klh/xBIYhlmM5+fc/xVZHIaUqcIxcc7gwp43Rz6aRaYVvgaaei5QYcJl13vKXy6k
         sjTKb7rX2BjOWq3Yxz4O5eSro7hTCdrp0to9DWg9fusnp8H9GMbhsCHludva3e9P3Hz2
         hjFA==
X-Gm-Message-State: ANhLgQ3D/bgR23K26JmTbJwocMWAv37uv2Y1DdMWFBRYVlgfKNh4TvNl
        uPOAShOH+GyKbwxzz8Lw6IacYg==
X-Google-Smtp-Source: ADFU+vtlxu1n1WRpVgN1kSjHdHqW/PmUw2MLbOx1LjQTD+oaEbSh1DP5jeNMZipD17GWwJnp4g34zA==
X-Received: by 2002:a92:ce06:: with SMTP id b6mr24058006ilo.102.1585759501374;
        Wed, 01 Apr 2020 09:45:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z16sm704595iog.26.2020.04.01.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 09:45:00 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.7-rc1
Message-ID: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
Date:   Wed, 1 Apr 2020 10:44:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EAECAB088049D0AF82A13C3A"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------EAECAB088049D0AF82A13C3A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.7-rc1.

This kselftest update Linux 5.7-rc1 consists of:

- resctrl_tests for resctrl file system. resctrl isn't included in the
   default TARGETS list in kselftest Makefile. It can be run manually.

- Kselftest harness improvements.

- Kselftest framework and individual test fixes to support runs on
   Kernel CI rings and other environments that use relocatable build
   and install features.

- Minor cleanups and typo fixes.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.7-rc1

for you to fetch changes up to 1056d3d2c97e47397d0037cbbdf24235ae8f88cb:

   selftests: enforce local header dependency in lib.mk (2020-03-26 
15:29:55 -0600)

----------------------------------------------------------------
linux-kselftest-5.7-rc1

This kselftest update Linux 5.7-rc1 consists of:

- resctrl_tests for resctrl file system. resctrl isn't included in the
   default TARGETS list in kselftest Makefile. It can be run manually.

- Kselftest harness improvements.

- Kselftest framework and individual test fixes to support runs on
   Kernel CI rings and other environments that use relocatable build
   and install features.

- Minor cleanups and typo fixes.

----------------------------------------------------------------
Babu Moger (3):
       selftests/resctrl: Add vendor detection mechanism
       selftests/resctrl: Use cache index3 id for AMD schemata masks
       selftests/resctrl: Disable MBA and MBM tests for AMD

Colin Ian King (1):
       selftests/resctrl: fix spelling mistake "Errror" -> "Error"

Fenghua Yu (6):
       selftests/resctrl: Add README for resctrl tests
       selftests/resctrl: Add MBM test
       selftests/resctrl: Add MBA test
       selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
       selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
       selftests/resctrl: Add the test in MAINTAINERS

Kees Cook (3):
       selftests/seccomp: Adjust test fixture counts
       selftests/harness: Move test child waiting logic
       selftests/harness: Handle timeouts cleanly

Masanari Iida (1):
       selftests/ftrace: Fix typo in trigger-multihist.tc

Sai Praneeth Prakhya (4):
       selftests/resctrl: Add basic resctrl file system operations and data
       selftests/resctrl: Read memory bandwidth from perf IMC counter 
and from resctrl file system
       selftests/resctrl: Add callback to start a benchmark
       selftests/resctrl: Add built in benchmark

Shuah Khan (6):
       selftests: Fix kselftest O=objdir build from cluttering top level 
objdir
       selftests: android: ion: Fix ionmap_test compile error
       selftests: android: Fix custom install from skipping test progs
       selftests: Fix seccomp to support relocatable build (O=objdir)
       selftests: Fix memfd to support relocatable build (O=objdir)
       selftests: enforce local header dependency in lib.mk

YueHaibing (1):
       selftests/timens: Remove duplicated include <time.h>

  MAINTAINERS                                        |   1 +
  tools/testing/selftests/Makefile                   |   4 +-
  tools/testing/selftests/android/Makefile           |   2 +-
  tools/testing/selftests/android/ion/Makefile       |   2 +-
  .../ftrace/test.d/trigger/trigger-multihist.tc     |   2 +-
  tools/testing/selftests/kselftest_harness.h        | 144 ++--
  tools/testing/selftests/lib.mk                     |   3 +-
  tools/testing/selftests/memfd/Makefile             |   9 +-
  tools/testing/selftests/resctrl/Makefile           |  17 +
  tools/testing/selftests/resctrl/README             |  53 ++
  tools/testing/selftests/resctrl/cache.c            | 272 ++++++++
  tools/testing/selftests/resctrl/cat_test.c         | 250 +++++++
  tools/testing/selftests/resctrl/cqm_test.c         | 176 +++++
  tools/testing/selftests/resctrl/fill_buf.c         | 213 ++++++
  tools/testing/selftests/resctrl/mba_test.c         | 171 +++++
  tools/testing/selftests/resctrl/mbm_test.c         | 145 ++++
  tools/testing/selftests/resctrl/resctrl.h          | 107 +++
  tools/testing/selftests/resctrl/resctrl_tests.c    | 202 ++++++
  tools/testing/selftests/resctrl/resctrl_val.c      | 744 
+++++++++++++++++++++
  tools/testing/selftests/resctrl/resctrlfs.c        | 722 
++++++++++++++++++++
  tools/testing/selftests/seccomp/Makefile           |  17 +-
  tools/testing/selftests/seccomp/seccomp_bpf.c      |  10 +-
  tools/testing/selftests/timens/exec.c              |   1 -
  tools/testing/selftests/timens/procfs.c            |   1 -
  tools/testing/selftests/timens/timens.c            |   1 -
  tools/testing/selftests/timens/timer.c             |   1 -
  26 files changed, 3191 insertions(+), 79 deletions(-)
  create mode 100644 tools/testing/selftests/resctrl/Makefile
  create mode 100644 tools/testing/selftests/resctrl/README
  create mode 100644 tools/testing/selftests/resctrl/cache.c
  create mode 100644 tools/testing/selftests/resctrl/cat_test.c
  create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
  create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
  create mode 100644 tools/testing/selftests/resctrl/mba_test.c
  create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
  create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
  create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

----------------------------------------------------------------

--------------EAECAB088049D0AF82A13C3A
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.7-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.7-rc1.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..b3eefdbc2edd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14073,6 +14073,7 @@ S:	Supported
 F:	arch/x86/kernel/cpu/resctrl/
 F:	arch/x86/include/asm/resctrl_sched.h
 F:	Documentation/x86/resctrl*
+F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 63430e2664c2..be22dbe94a4c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -85,7 +85,7 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
-# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
 # KBUILD_OUTPUT with selftest objects and headers installed
 # by selftests Makefile or lib.mk.
 ifdef building_out_of_srctree
@@ -93,7 +93,7 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(O)/kselftest
 else
 	ifneq ($(KBUILD_OUTPUT),)
 		BUILD := $(KBUILD_OUTPUT)/kselftest
diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 7c462714b418..9258306cafe9 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -21,7 +21,7 @@ all:
 
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
-	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
+install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)  $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 	@for SUBDIR in $(SUBDIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$SUBDIR;	\
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index 0eb7ab626e1c..42b71f005332 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -17,4 +17,4 @@ include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
-$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
+$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c ipcsocket.c
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index 18fdaab9f570..68ff3f45c720 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-echo "Test histogram multiple tiggers"
+echo "Test histogram multiple triggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
 echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..2902f6a78f8a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -635,10 +635,12 @@
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
+	pid_t pid;	/* pid of test when being run */
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
-	int timeout;
+	int timeout;	/* seconds to wait for test timeout */
+	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	struct __test_metadata *prev, *next;
@@ -695,64 +697,116 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+struct __test_metadata *__active_test;
+static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 {
-	pid_t child_pid;
+	struct __test_metadata *t = __active_test;
+
+	/* Sanity check handler execution environment. */
+	if (!t) {
+		fprintf(TH_LOG_STREAM,
+			"no active test in SIGARLM handler!?\n");
+		abort();
+	}
+	if (sig != SIGALRM || sig != info->si_signo) {
+		fprintf(TH_LOG_STREAM,
+			"%s: SIGALRM handler caught signal %d!?\n",
+			t->name, sig != SIGALRM ? sig : info->si_signo);
+		abort();
+	}
+
+	t->timed_out = true;
+	kill(t->pid, SIGKILL);
+}
+
+void __wait_for_test(struct __test_metadata *t)
+{
+	struct sigaction action = {
+		.sa_sigaction = __timeout_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+	struct sigaction saved_action;
 	int status;
 
+	if (sigaction(SIGALRM, &action, &saved_action)) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: unable to install SIGARLM handler\n",
+			t->name);
+		return;
+	}
+	__active_test = t;
+	t->timed_out = false;
+	alarm(t->timeout);
+	waitpid(t->pid, &status, 0);
+	alarm(0);
+	if (sigaction(SIGALRM, &saved_action, NULL)) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: unable to uninstall SIGARLM handler\n",
+			t->name);
+		return;
+	}
+	__active_test = NULL;
+
+	if (t->timed_out) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: Test terminated by timeout\n", t->name);
+	} else if (WIFEXITED(status)) {
+		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
+		if (t->termsig != -1) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test exited normally "
+				"instead of by signal (code: %d)\n",
+				t->name,
+				WEXITSTATUS(status));
+		} else if (!t->passed) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test failed at step #%d\n",
+				t->name,
+				WEXITSTATUS(status));
+		}
+	} else if (WIFSIGNALED(status)) {
+		t->passed = 0;
+		if (WTERMSIG(status) == SIGABRT) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated by assertion\n",
+				t->name);
+		} else if (WTERMSIG(status) == t->termsig) {
+			t->passed = 1;
+		} else {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated unexpectedly "
+				"by signal %d\n",
+				t->name,
+				WTERMSIG(status));
+		}
+	} else {
+		fprintf(TH_LOG_STREAM,
+			"%s: Test ended in some other way [%u]\n",
+			t->name,
+			status);
+	}
+}
+
+void __run_test(struct __test_metadata *t)
+{
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
-	alarm(t->timeout);
-	child_pid = fork();
-	if (child_pid < 0) {
+	t->pid = fork();
+	if (t->pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
-	} else if (child_pid == 0) {
+	} else if (t->pid == 0) {
 		t->fn(t);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
-		/* TODO(wad) add timeout support. */
-		waitpid(child_pid, &status, 0);
-		if (WIFEXITED(status)) {
-			t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
-			if (t->termsig != -1) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test exited normally "
-					"instead of by signal (code: %d)\n",
-					t->name,
-					WEXITSTATUS(status));
-			} else if (!t->passed) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test failed at step #%d\n",
-					t->name,
-					WEXITSTATUS(status));
-			}
-		} else if (WIFSIGNALED(status)) {
-			t->passed = 0;
-			if (WTERMSIG(status) == SIGABRT) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated by assertion\n",
-					t->name);
-			} else if (WTERMSIG(status) == t->termsig) {
-				t->passed = 1;
-			} else {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated unexpectedly "
-					"by signal %d\n",
-					t->name,
-					WTERMSIG(status));
-			}
-		} else {
-			fprintf(TH_LOG_STREAM,
-				"%s: Test ended in some other way [%u]\n",
-				t->name,
-				status);
-		}
+		__wait_for_test(t);
 	}
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
-	alarm(0);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..70f03dff5479 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -134,7 +134,8 @@ endif
 # Selftest makefiles can override those targets by setting
 # OVERRIDE_TARGETS = 1.
 ifeq ($(OVERRIDE_TARGETS),)
-$(OUTPUT)/%:%.c
+LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
+$(OUTPUT)/%:%.c $(LOCAL_HDRS)
 	$(LINK.c) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 53a848109f7b..0a15f9e23431 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,9 +4,8 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
-TEST_GEN_FILES := fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
@@ -14,7 +13,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
 
-$(OUTPUT)/memfd_test: memfd_test.c common.o
-$(OUTPUT)/fuse_test: fuse_test.c common.o
+$(OUTPUT)/memfd_test: memfd_test.c common.c
+$(OUTPUT)/fuse_test: fuse_test.c common.c
 
-EXTRA_CLEAN = common.o
+EXTRA_CLEAN = $(OUTPUT)/common.o
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
new file mode 100644
index 000000000000..d585cc1948cc
--- /dev/null
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -0,0 +1,17 @@
+CC = $(CROSS_COMPILE)gcc
+CFLAGS = -g -Wall
+SRCS=$(wildcard *.c)
+OBJS=$(SRCS:.c=.o)
+
+all: resctrl_tests
+
+$(OBJS): $(SRCS)
+	$(CC) $(CFLAGS) -c $(SRCS)
+
+resctrl_tests: $(OBJS)
+	$(CC) $(CFLAGS) -o $@ $^
+
+.PHONY: clean
+
+clean:
+	$(RM) $(OBJS) resctrl_tests
diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
new file mode 100644
index 000000000000..6e5a0ffa18e8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,53 @@
+resctrl_tests - resctrl file system test suit
+
+Authors:
+	Fenghua Yu <fenghua.yu@intel.com>
+	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+
+resctrl_tests tests various resctrl functionalities and interfaces including
+both software and hardware.
+
+Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidth
+Allocation test on Intel RDT hardware. More tests will be added in the future.
+And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
+as well.
+
+BUILD
+-----
+
+Run "make" to build executable file "resctrl_tests".
+
+RUN
+---
+
+To use resctrl_tests, root or sudoer privileges are required. This is because
+the test needs to mount resctrl file system and change contents in the file
+system.
+
+Executing the test without any parameter will run all supported tests:
+
+	sudo ./resctrl_tests
+
+OVERVIEW OF EXECUTION
+---------------------
+
+A test case has four stages:
+
+  - setup: mount resctrl file system, create group, setup schemata, move test
+    process pids to tasks, start benchmark.
+  - execute: let benchmark run
+  - verify: get resctrl data and verify the data with another source, e.g.
+    perf event.
+  - teardown: umount resctrl and clear temporary files.
+
+ARGUMENTS
+---------
+
+Parameter '-h' shows usage information.
+
+usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
+        -n no_of_bits: run cache tests using specified no of bits in cache bit mask
+        -p cpu_no: specify CPU number to run the test. 1 is default
+        -h: help
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
new file mode 100644
index 000000000000..38dbf4962e33
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdint.h>
+#include "resctrl.h"
+
+struct read_format {
+	__u64 nr;			/* The number of events */
+	struct {
+		__u64 value;		/* The value of the event */
+	} values[2];
+};
+
+static struct perf_event_attr pea_llc_miss;
+static struct read_format rf_cqm;
+static int fd_lm;
+char llc_occup_path[1024];
+
+static void initialize_perf_event_attr(void)
+{
+	pea_llc_miss.type = PERF_TYPE_HARDWARE;
+	pea_llc_miss.size = sizeof(struct perf_event_attr);
+	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
+	pea_llc_miss.exclude_kernel = 1;
+	pea_llc_miss.exclude_hv = 1;
+	pea_llc_miss.exclude_idle = 1;
+	pea_llc_miss.exclude_callchain_kernel = 1;
+	pea_llc_miss.inherit = 1;
+	pea_llc_miss.exclude_guest = 1;
+	pea_llc_miss.disabled = 1;
+}
+
+static void ioctl_perf_event_ioc_reset_enable(void)
+{
+	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
+{
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		perror("Error opening leader");
+		ctrlc_handler(0, NULL, NULL);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int initialize_llc_perf(void)
+{
+	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
+	memset(&rf_cqm, 0, sizeof(struct read_format));
+
+	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
+	initialize_perf_event_attr();
+
+	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
+
+	rf_cqm.nr = 1;
+
+	return 0;
+}
+
+static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+{
+	int ret = 0;
+
+	ret = perf_event_open_llc_miss(pid, cpu_no);
+	if (ret < 0)
+		return ret;
+
+	/* Start counters to log values */
+	ioctl_perf_event_ioc_reset_enable();
+
+	return 0;
+}
+
+/*
+ * get_llc_perf:	llc cache miss through perf events
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ *
+ * Perf events like HW_CACHE_MISSES could be used to validate number of
+ * cache lines allocated.
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
+static int get_llc_perf(unsigned long *llc_perf_miss)
+{
+	__u64 total_misses;
+
+	/* Stop counters after one span to get miss rate */
+
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+
+	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+		perror("Could not get llc misses through perf");
+
+		return -1;
+	}
+
+	total_misses = rf_cqm.values[0].value;
+
+	close(fd_lm);
+
+	*llc_perf_miss = total_misses;
+
+	return 0;
+}
+
+/*
+ * Get LLC Occupancy as reported by RESCTRL FS
+ * For CQM,
+ * 1. If con_mon grp and mon grp given, then read from mon grp in
+ * con_mon grp
+ * 2. If only con_mon grp given, then read from con_mon grp
+ * 3. If both not given, then read from root con_mon grp
+ * For CAT,
+ * 1. If con_mon grp given, then read from it
+ * 2. If con_mon grp not given, then read from root con_mon grp
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
+static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
+{
+	FILE *fp;
+
+	fp = fopen(llc_occup_path, "r");
+	if (!fp) {
+		perror("Failed to open results file");
+
+		return errno;
+	}
+	if (fscanf(fp, "%lu", llc_occupancy) <= 0) {
+		perror("Could not get llc occupancy");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * print_results_cache:	the cache results are stored in a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @llc_value:		perf miss value /
+ *			llc occupancy value reported by resctrl FS
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+static int print_results_cache(char *filename, int bm_pid,
+			       unsigned long llc_value)
+{
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t LLC_value: %lu\n", bm_pid,
+		       llc_value);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid, llc_value);
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
+{
+	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
+	int ret;
+
+	/*
+	 * Measure cache miss from perf.
+	 */
+	if (!strcmp(param->resctrl_val, "cat")) {
+		ret = get_llc_perf(&llc_perf_miss);
+		if (ret < 0)
+			return ret;
+		llc_value = llc_perf_miss;
+	}
+
+	/*
+	 * Measure llc occupancy from resctrl.
+	 */
+	if (!strcmp(param->resctrl_val, "cqm")) {
+		ret = get_llc_occu_resctrl(&llc_occu_resc);
+		if (ret < 0)
+			return ret;
+		llc_value = llc_occu_resc;
+	}
+	ret = print_results_cache(param->filename, bm_pid, llc_value);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * cache_val:		execute benchmark and measure LLC occupancy resctrl
+ * and perf cache miss for the benchmark
+ * @param:		parameters passed to cache_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int cat_val(struct resctrl_val_param *param)
+{
+	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	pid_t bm_pid;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid = getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "cat") == 0)) {
+		ret = initialize_llc_perf();
+		if (ret)
+			return ret;
+	}
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "cat") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+			if (ret)
+				break;
+
+			if (run_fill_buf(param->span, malloc_and_init_memory,
+					 memflush, operation, resctrl_val)) {
+				fprintf(stderr, "Error-running fill buffer\n");
+				ret = -1;
+				break;
+			}
+
+			sleep(1);
+			ret = measure_cache_vals(param, bm_pid);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
new file mode 100644
index 000000000000..5da43767b973
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Allocation Technology (CAT) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+#include <unistd.h>
+
+#define RESULT_FILE_NAME1	"result_cat1"
+#define RESULT_FILE_NAME2	"result_cat2"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF_PERCENT	4
+#define MAX_DIFF		1000000
+
+int count_of_bits;
+char cbm_mask[256];
+unsigned long long_mask;
+unsigned long cache_size;
+
+/*
+ * Change schemata. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * Run 5 times in order to get average values.
+ */
+static int cat_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	char schemata[64];
+	va_list param;
+	int ret = 0;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	if (p->num_of_runs == 0) {
+		sprintf(schemata, "%lx", p->mask);
+		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
+				     p->resctrl_val);
+	}
+	p->num_of_runs++;
+
+	return ret;
+}
+
+static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
+			    unsigned long span)
+{
+	unsigned long allocated_cache_lines = span / 64;
+	unsigned long avg_llc_perf_miss = 0;
+	float diff_percent;
+
+	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
+	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
+				allocated_cache_lines * 100;
+
+	printf("%sok CAT: cache miss rate within %d%%\n",
+	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
+	       "not " : "", MAX_DIFF_PERCENT);
+	tests_run++;
+	printf("# Percent diff=%d\n", abs((int)diff_percent));
+	printf("# Number of bits: %d\n", no_of_bits);
+	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
+	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
+}
+
+static int check_results(struct resctrl_val_param *param)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_perf_miss = 0;
+	int runs = 0, no_of_bits = 0;
+	FILE *fp;
+
+	printf("# Checking for pass/fail\n");
+	fp = fopen(param->filename, "r");
+	if (!fp) {
+		perror("# Cannot open file");
+
+		return errno;
+	}
+
+	while (fgets(temp, sizeof(temp), fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+		/*
+		 * Discard the first value which is inaccurate due to monitoring
+		 * setup transition phase.
+		 */
+		if (runs > 0)
+			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+	no_of_bits = count_bits(param->mask);
+
+	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
+
+	return 0;
+}
+
+void cat_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME1);
+	remove(RESULT_FILE_NAME2);
+}
+
+int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
+{
+	unsigned long l_mask, l_mask_1;
+	int ret, pipefd[2], sibling_cpu_no;
+	char pipe_message;
+	pid_t bm_pid;
+
+	cache_size = 0;
+
+	ret = remount_resctrlfs(true);
+	if (ret)
+		return ret;
+
+	if (!validate_resctrl_feature_request("cat"))
+		return -1;
+
+	/* Get default cbm mask for L3/L2 cache */
+	ret = get_cbm_mask(cache_type);
+	if (ret)
+		return ret;
+
+	long_mask = strtoul(cbm_mask, NULL, 16);
+
+	/* Get L3/L2 cache size */
+	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	if (ret)
+		return ret;
+	printf("cache size :%lu\n", cache_size);
+
+	/* Get max number of bits from default-cabm mask */
+	count_of_bits = count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits - 1) {
+		printf("Invalid input value for no_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n",
+		       count_of_bits - 1);
+		return -1;
+	}
+
+	/* Get core id from same socket for running another thread */
+	sibling_cpu_no = get_core_sibling(cpu_no);
+	if (sibling_cpu_no < 0)
+		return -1;
+
+	struct resctrl_val_param param = {
+		.resctrl_val	= "cat",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 0,
+		.setup		= cat_setup,
+	};
+
+	l_mask = long_mask >> n;
+	l_mask_1 = ~l_mask & long_mask;
+
+	/* Set param values for parent thread which will be allocated bitmask
+	 * with (max_bits - n) bits
+	 */
+	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	strcpy(param.ctrlgrp, "c2");
+	strcpy(param.mongrp, "m2");
+	strcpy(param.filename, RESULT_FILE_NAME2);
+	param.mask = l_mask;
+	param.num_of_runs = 0;
+
+	if (pipe(pipefd)) {
+		perror("# Unable to create pipe");
+		return errno;
+	}
+
+	bm_pid = fork();
+
+	/* Set param values for child thread which will be allocated bitmask
+	 * with n bits
+	 */
+	if (bm_pid == 0) {
+		param.mask = l_mask_1;
+		strcpy(param.ctrlgrp, "c1");
+		strcpy(param.mongrp, "m1");
+		param.span = cache_size * n / count_of_bits;
+		strcpy(param.filename, RESULT_FILE_NAME1);
+		param.num_of_runs = 0;
+		param.cpu_no = sibling_cpu_no;
+	}
+
+	remove(param.filename);
+
+	ret = cat_val(&param);
+	if (ret)
+		return ret;
+
+	ret = check_results(&param);
+	if (ret)
+		return ret;
+
+	if (bm_pid == 0) {
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			close(pipefd[1]);
+			perror("# failed signaling parent process");
+			return errno;
+		}
+
+		close(pipefd[1]);
+		while (1)
+			;
+	} else {
+		/* Parent waits for child to be ready. */
+		close(pipefd[1]);
+		pipe_message = 0;
+		while (pipe_message != 1) {
+			if (read(pipefd[0], &pipe_message,
+				 sizeof(pipe_message)) < sizeof(pipe_message)) {
+				perror("# failed reading from child process");
+				break;
+			}
+		}
+		close(pipefd[0]);
+		kill(bm_pid, SIGKILL);
+	}
+
+	cat_test_cleanup();
+	if (bm_pid)
+		umount_resctrlfs();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
new file mode 100644
index 000000000000..c8756152bd61
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Monitoring Technology (CQM) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+#include <unistd.h>
+
+#define RESULT_FILE_NAME	"result_cqm"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF		2000000
+#define MAX_DIFF_PERCENT	15
+
+int count_of_bits;
+char cbm_mask[256];
+unsigned long long_mask;
+unsigned long cache_size;
+
+static int cqm_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	va_list param;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	p->num_of_runs++;
+
+	return 0;
+}
+
+static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
+			    unsigned long span)
+{
+	unsigned long avg_llc_occu_resc = 0;
+	float diff_percent;
+	long avg_diff = 0;
+	bool res;
+
+	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
+	avg_diff = (long)abs(span - avg_llc_occu_resc);
+
+	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
+
+	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
+	    (abs(avg_diff) <= MAX_DIFF))
+		res = true;
+	else
+		res = false;
+
+	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
+	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
+
+	printf("# diff: %ld\n", avg_diff);
+	printf("# percent diff=%d\n", abs((int)diff_percent));
+	printf("# Results are displayed in (Bytes)\n");
+	printf("# Number of bits: %d\n", no_of_bits);
+	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
+	printf("# llc_occu_exp (span): %lu\n", span);
+
+	tests_run++;
+}
+
+static int check_results(struct resctrl_val_param *param, int no_of_bits)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_occu_resc = 0;
+	int runs = 0;
+	FILE *fp;
+
+	printf("# checking for pass/fail\n");
+	fp = fopen(param->filename, "r");
+	if (!fp) {
+		perror("# Error in opening file\n");
+
+		return errno;
+	}
+
+	while (fgets(temp, 1024, fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is llc occ resc value */
+		if (runs > 0)
+			sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+	fclose(fp);
+	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
+
+	return 0;
+}
+
+void cqm_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+{
+	int ret, mum_resctrlfs;
+
+	cache_size = 0;
+	mum_resctrlfs = 1;
+
+	ret = remount_resctrlfs(mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	if (!validate_resctrl_feature_request("cqm"))
+		return -1;
+
+	ret = get_cbm_mask("L3");
+	if (ret)
+		return ret;
+
+	long_mask = strtoul(cbm_mask, NULL, 16);
+
+	ret = get_cache_size(cpu_no, "L3", &cache_size);
+	if (ret)
+		return ret;
+	printf("cache size :%lu\n", cache_size);
+
+	count_of_bits = count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits) {
+		printf("Invalid input value for numbr_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n", count_of_bits);
+		return -1;
+	}
+
+	struct resctrl_val_param param = {
+		.resctrl_val	= "cqm",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 0,
+		.filename	= RESULT_FILE_NAME,
+		.mask		= ~(long_mask << n) & long_mask,
+		.span		= cache_size * n / count_of_bits,
+		.num_of_runs	= 0,
+		.setup		= cqm_setup,
+	};
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
+		sprintf(benchmark_cmd[1], "%lu", param.span);
+
+	remove(RESULT_FILE_NAME);
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results(&param, n);
+	if (ret)
+		return ret;
+
+	cqm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
new file mode 100644
index 000000000000..79c611c99a3d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fill_buf benchmark
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <string.h>
+
+#include "resctrl.h"
+
+#define CL_SIZE			(64)
+#define PAGE_SIZE		(4 * 1024)
+#define MB			(1024 * 1024)
+
+static unsigned char *startptr;
+
+static void sb(void)
+{
+#if defined(__i386) || defined(__x86_64)
+	asm volatile("sfence\n\t"
+		     : : : "memory");
+#endif
+}
+
+static void ctrl_handler(int signo)
+{
+	free(startptr);
+	printf("\nEnding\n");
+	sb();
+	exit(EXIT_SUCCESS);
+}
+
+static void cl_flush(void *p)
+{
+#if defined(__i386) || defined(__x86_64)
+	asm volatile("clflush (%0)\n\t"
+		     : : "r"(p) : "memory");
+#endif
+}
+
+static void mem_flush(void *p, size_t s)
+{
+	char *cp = (char *)p;
+	size_t i = 0;
+
+	s = s / CL_SIZE; /* mem size in cache llines */
+
+	for (i = 0; i < s; i++)
+		cl_flush(&cp[i * CL_SIZE]);
+
+	sb();
+}
+
+static void *malloc_and_init_memory(size_t s)
+{
+	uint64_t *p64;
+	size_t s64;
+
+	void *p = memalign(PAGE_SIZE, s);
+
+	p64 = (uint64_t *)p;
+	s64 = s / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 = (uint64_t)rand();
+		p64 += (CL_SIZE / sizeof(uint64_t));
+		s64 -= (CL_SIZE / sizeof(uint64_t));
+	}
+
+	return p;
+}
+
+static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	unsigned char sum, *p;
+
+	sum = 0;
+	p = start_ptr;
+	while (p < end_ptr) {
+		sum += *p;
+		p += (CL_SIZE / 2);
+	}
+
+	return sum;
+}
+
+static
+void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	unsigned char *p;
+
+	p = start_ptr;
+	while (p < end_ptr) {
+		*p = '1';
+		p += (CL_SIZE / 2);
+	}
+}
+
+static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
+			   char *resctrl_val)
+{
+	int ret = 0;
+	FILE *fp;
+
+	while (1) {
+		ret = fill_one_span_read(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
+
+	/* Consume read result so that reading memory is not optimized out. */
+	fp = fopen("/dev/null", "w");
+	if (!fp)
+		perror("Unable to write to /dev/null");
+	fprintf(fp, "Sum: %d ", ret);
+	fclose(fp);
+
+	return 0;
+}
+
+static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
+			    char *resctrl_val)
+{
+	while (1) {
+		fill_one_span_write(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
+
+	return 0;
+}
+
+static int
+fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
+	   int op, char *resctrl_val)
+{
+	unsigned char *start_ptr, *end_ptr;
+	unsigned long long i;
+	int ret;
+
+	if (malloc_and_init)
+		start_ptr = malloc_and_init_memory(buf_size);
+	else
+		start_ptr = malloc(buf_size);
+
+	if (!start_ptr)
+		return -1;
+
+	startptr = start_ptr;
+	end_ptr = start_ptr + buf_size;
+
+	/*
+	 * It's better to touch the memory once to avoid any compiler
+	 * optimizations
+	 */
+	if (!malloc_and_init) {
+		for (i = 0; i < buf_size; i++)
+			*start_ptr++ = (unsigned char)rand();
+	}
+
+	start_ptr = startptr;
+
+	/* Flush the memory before using to avoid "cache hot pages" effect */
+	if (memflush)
+		mem_flush(start_ptr, buf_size);
+
+	if (op == 0)
+		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
+	else
+		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
+
+	if (ret) {
+		printf("\n Error in fill cache read/write...\n");
+		return -1;
+	}
+
+	free(startptr);
+
+	return 0;
+}
+
+int run_fill_buf(unsigned long span, int malloc_and_init_memory,
+		 int memflush, int op, char *resctrl_val)
+{
+	unsigned long long cache_size = span;
+	int ret;
+
+	/* set up ctrl-c handler */
+	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGINT!\n");
+	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGHUP!\n");
+
+	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
+			 resctrl_val);
+	if (ret) {
+		printf("\n Error in fill cache\n");
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
new file mode 100644
index 000000000000..7bf8eaa6204b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Allocation (MBA) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define RESULT_FILE_NAME	"result_mba"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF		300
+#define ALLOCATION_MAX		100
+#define ALLOCATION_MIN		10
+#define ALLOCATION_STEP		10
+
+/*
+ * Change schemata percentage from 100 to 10%. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * For each allocation, run 5 times in order to get average values.
+ */
+static int mba_setup(int num, ...)
+{
+	static int runs_per_allocation, allocation = 100;
+	struct resctrl_val_param *p;
+	char allocation_str[64];
+	va_list param;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	if (runs_per_allocation >= NUM_OF_RUNS)
+		runs_per_allocation = 0;
+
+	/* Only set up schemata once every NUM_OF_RUNS of allocations */
+	if (runs_per_allocation++ != 0)
+		return 0;
+
+	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+		return -1;
+
+	sprintf(allocation_str, "%d", allocation);
+
+	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	allocation -= ALLOCATION_STEP;
+
+	return 0;
+}
+
+static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+{
+	int allocation, runs;
+	bool failed = false;
+
+	printf("# Results are displayed in (MB)\n");
+	/* Memory bandwidth from 100% down to 10% */
+	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
+	     allocation++) {
+		unsigned long avg_bw_imc, avg_bw_resc;
+		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+		unsigned long avg_diff;
+
+		/*
+		 * The first run is discarded due to inaccurate value from
+		 * phase transition.
+		 */
+		for (runs = NUM_OF_RUNS * allocation + 1;
+		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
+			sum_bw_imc += bw_imc[runs];
+			sum_bw_resc += bw_resc[runs];
+		}
+
+		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+
+		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
+		       avg_diff > MAX_DIFF ? "not " : "",
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
+		       MAX_DIFF);
+		tests_run++;
+		printf("# avg_diff: %lu\n", avg_diff);
+		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
+		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+		if (avg_diff > MAX_DIFF)
+			failed = true;
+	}
+
+	printf("%sok schemata change using MBA%s\n", failed ? "not " : "",
+	       failed ? " # at least one test failed" : "");
+	tests_run++;
+}
+
+static int check_results(void)
+{
+	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
+	unsigned long bw_imc[1024], bw_resc[1024];
+	int runs;
+	FILE *fp;
+
+	fp = fopen(output, "r");
+	if (!fp) {
+		perror(output);
+
+		return errno;
+	}
+
+	runs = 0;
+	while (fgets(temp, sizeof(temp), fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is perf imc value */
+		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		/* Field 5 is resctrl value */
+		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+
+	show_mba_info(bw_imc, bw_resc);
+
+	return 0;
+}
+
+void mba_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mba",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	= bw_report,
+		.setup		= mba_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	if (!validate_resctrl_feature_request("mba"))
+		return -1;
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results();
+	if (ret)
+		return ret;
+
+	mba_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
new file mode 100644
index 000000000000..4700f7453f81
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Monitoring (MBM) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define RESULT_FILE_NAME	"result_mbm"
+#define MAX_DIFF		300
+#define NUM_OF_RUNS		5
+
+static void
+show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
+{
+	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+	long avg_diff = 0;
+	int runs;
+
+	/*
+	 * Discard the first value which is inaccurate due to monitoring setup
+	 * transition phase.
+	 */
+	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
+		sum_bw_imc += bw_imc[runs];
+		sum_bw_resc += bw_resc[runs];
+	}
+
+	avg_bw_imc = sum_bw_imc / 4;
+	avg_bw_resc = sum_bw_resc / 4;
+	avg_diff = avg_bw_resc - avg_bw_imc;
+
+	printf("%sok MBM: diff within %d%%\n",
+	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
+	tests_run++;
+	printf("# avg_diff: %lu\n", labs(avg_diff));
+	printf("# Span (MB): %d\n", span);
+	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
+	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+}
+
+static int check_results(int span)
+{
+	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
+	char temp[1024], *token_array[8];
+	char output[] = RESULT_FILE_NAME;
+	int runs;
+	FILE *fp;
+
+	printf("# Checking for pass/fail\n");
+
+	fp = fopen(output, "r");
+	if (!fp) {
+		perror(output);
+
+		return errno;
+	}
+
+	runs = 0;
+	while (fgets(temp, sizeof(temp), fp)) {
+		char *token = strtok(temp, ":\t");
+		int i = 0;
+
+		while (token) {
+			token_array[i++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
+		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+
+	show_bw_info(bw_imc, bw_resc, span);
+
+	fclose(fp);
+
+	return 0;
+}
+
+static int mbm_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	static int num_of_runs;
+	va_list param;
+	int ret = 0;
+
+	/* Run NUM_OF_RUNS times */
+	if (num_of_runs++ >= NUM_OF_RUNS)
+		return -1;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Set up shemata with 100% allocation on the first run. */
+	if (num_of_runs == 0)
+		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
+				     p->resctrl_val);
+
+	return ret;
+}
+
+void mbm_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mbm",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.span		= span,
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	=  bw_report,
+		.setup		= mbm_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	if (!validate_resctrl_feature_request("mbm"))
+		return -1;
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results(span);
+	if (ret)
+		return ret;
+
+	mbm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
new file mode 100644
index 000000000000..39bf59c6b9c5
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#ifndef RESCTRL_H
+#define RESCTRL_H
+#include <stdio.h>
+#include <stdarg.h>
+#include <math.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <sys/eventfd.h>
+#include <asm/unistd.h>
+#include <linux/perf_event.h>
+
+#define MB			(1024 * 1024)
+#define RESCTRL_PATH		"/sys/fs/resctrl"
+#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
+#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+
+#define PARENT_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		kill(ppid, SIGKILL);		\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+/*
+ * resctrl_val_param:	resctrl test parameters
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @cpu_no:		CPU number to which the benchmark would be binded
+ * @span:		Memory bytes accessed in each benchmark iteration
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * @filename:		Name of file to which the o/p should be written
+ * @bw_report:		Bandwidth report type (reads vs writes)
+ * @setup:		Call back function to setup test environment
+ */
+struct resctrl_val_param {
+	char		*resctrl_val;
+	char		ctrlgrp[64];
+	char		mongrp[64];
+	int		cpu_no;
+	unsigned long	span;
+	int		mum_resctrlfs;
+	char		filename[64];
+	char		*bw_report;
+	unsigned long	mask;
+	int		num_of_runs;
+	int		(*setup)(int num, ...);
+};
+
+pid_t bm_pid, ppid;
+int tests_run;
+
+char llc_occup_path[1024];
+bool is_amd;
+
+bool check_resctrlfs_support(void);
+int filter_dmesg(void);
+int remount_resctrlfs(bool mum_resctrlfs);
+int get_resource_id(int cpu_no, int *resource_id);
+int umount_resctrlfs(void);
+int validate_bw_report_request(char *bw_report);
+bool validate_resctrl_feature_request(char *resctrl_val);
+char *fgrep(FILE *inf, const char *str);
+int taskset_benchmark(pid_t bm_pid, int cpu_no);
+void run_benchmark(int signum, siginfo_t *info, void *ucontext);
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
+		   char *resctrl_val);
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val);
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags);
+int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
+		 int op, char *resctrl_va);
+int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
+int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
+void tests_cleanup(void);
+void mbm_test_cleanup(void);
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
+void mba_test_cleanup(void);
+int get_cbm_mask(char *cache_type);
+int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int cat_val(struct resctrl_val_param *param);
+void cat_test_cleanup(void);
+int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
+int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+unsigned int count_bits(unsigned long n);
+void cqm_test_cleanup(void);
+int get_core_sibling(int cpu_no);
+int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+
+#endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
new file mode 100644
index 000000000000..425cc85ac883
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resctrl tests
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define BENCHMARK_ARGS		64
+#define BENCHMARK_ARG_SIZE	64
+
+bool is_amd;
+
+void detect_amd(void)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	char *res;
+
+	if (!inf)
+		return;
+
+	res = fgrep(inf, "vendor_id");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
+		free(res);
+	}
+	fclose(inf);
+}
+
+static void cmd_help(void)
+{
+	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
+	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-t test list: run tests specified in the test list, ");
+	printf("e.g. -t mbm, mba, cqm, cat\n");
+	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
+	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
+	printf("\t-h: help\n");
+}
+
+void tests_cleanup(void)
+{
+	mbm_test_cleanup();
+	mba_test_cleanup();
+	cqm_test_cleanup();
+	cat_test_cleanup();
+}
+
+int main(int argc, char **argv)
+{
+	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
+	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
+	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
+	int ben_ind, ben_count;
+	bool cat_test = true;
+
+	for (i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "-b") == 0) {
+			ben_ind = i + 1;
+			ben_count = argc - ben_ind;
+			argc_new = ben_ind - 1;
+			has_ben = true;
+			break;
+		}
+	}
+
+	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+		char *token;
+
+		switch (c) {
+		case 't':
+			token = strtok(optarg, ",");
+
+			mbm_test = false;
+			mba_test = false;
+			cqm_test = false;
+			cat_test = false;
+			while (token) {
+				if (!strcmp(token, "mbm")) {
+					mbm_test = true;
+				} else if (!strcmp(token, "mba")) {
+					mba_test = true;
+				} else if (!strcmp(token, "cqm")) {
+					cqm_test = true;
+				} else if (!strcmp(token, "cat")) {
+					cat_test = true;
+				} else {
+					printf("invalid argument\n");
+
+					return -1;
+				}
+				token = strtok(NULL, ":\t");
+			}
+			break;
+		case 'p':
+			cpu_no = atoi(optarg);
+			break;
+		case 'n':
+			no_of_bits = atoi(optarg);
+			break;
+		case 'h':
+			cmd_help();
+
+			return 0;
+		default:
+			printf("invalid argument\n");
+
+			return -1;
+		}
+	}
+
+	printf("TAP version 13\n");
+
+	/*
+	 * Typically we need root privileges, because:
+	 * 1. We write to resctrl FS
+	 * 2. We execute perf commands
+	 */
+	if (geteuid() != 0)
+		printf("# WARNING: not running as root, tests may fail.\n");
+
+	/* Detect AMD vendor */
+	detect_amd();
+
+	if (has_ben) {
+		/* Extract benchmark command from command line. */
+		for (i = ben_ind; i < argc; i++) {
+			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
+			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
+		}
+		benchmark_cmd[ben_count] = NULL;
+	} else {
+		/* If no benchmark is given by "-b" argument, use fill_buf. */
+		for (i = 0; i < 6; i++)
+			benchmark_cmd[i] = benchmark_cmd_area[i];
+
+		strcpy(benchmark_cmd[0], "fill_buf");
+		sprintf(benchmark_cmd[1], "%d", span);
+		strcpy(benchmark_cmd[2], "1");
+		strcpy(benchmark_cmd[3], "1");
+		strcpy(benchmark_cmd[4], "0");
+		strcpy(benchmark_cmd[5], "");
+		benchmark_cmd[6] = NULL;
+	}
+
+	sprintf(bw_report, "reads");
+	sprintf(bm_type, "fill_buf");
+
+	check_resctrlfs_support();
+	filter_dmesg();
+
+	if (!is_amd && mbm_test) {
+		printf("# Starting MBM BW change ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[5], "%s", "mba");
+		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+		printf("%sok MBM: bw change\n", res ? "not " : "");
+		mbm_test_cleanup();
+		tests_run++;
+	}
+
+	if (!is_amd && mba_test) {
+		printf("# Starting MBA Schemata change ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[1], "%d", span);
+		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+		printf("%sok MBA: schemata change\n", res ? "not " : "");
+		mba_test_cleanup();
+		tests_run++;
+	}
+
+	if (cqm_test) {
+		printf("# Starting CQM test ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[5], "%s", "cqm");
+		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		printf("%sok CQM: test\n", res ? "not " : "");
+		cqm_test_cleanup();
+		tests_run++;
+	}
+
+	if (cat_test) {
+		printf("# Starting CAT test ...\n");
+		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+		printf("%sok CAT: test\n", res ? "not " : "");
+		tests_run++;
+		cat_test_cleanup();
+	}
+
+	printf("1..%d\n", tests_run);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
new file mode 100644
index 000000000000..520fea3606d1
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory bandwidth monitoring and allocation library
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define UNCORE_IMC		"uncore_imc"
+#define READ_FILE_NAME		"events/cas_count_read"
+#define WRITE_FILE_NAME		"events/cas_count_write"
+#define DYN_PMU_PATH		"/sys/bus/event_source/devices"
+#define SCALE			0.00006103515625
+#define MAX_IMCS		20
+#define MAX_TOKENS		5
+#define READ			0
+#define WRITE			1
+#define CON_MON_MBM_LOCAL_BYTES_PATH				\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define CON_MBM_LOCAL_BYTES_PATH		\
+	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MON_MBM_LOCAL_BYTES_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MBM_LOCAL_BYTES_PATH			\
+	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define CON_MON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define CON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define MON_LCC_OCCUP_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define LCC_OCCUP_PATH			\
+	"%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+struct membw_read_format {
+	__u64 value;         /* The value of the event */
+	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+	__u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+	__u64 id;            /* if PERF_FORMAT_ID */
+};
+
+struct imc_counter_config {
+	__u32 type;
+	__u64 event;
+	__u64 umask;
+	struct perf_event_attr pe;
+	struct membw_read_format return_value;
+	int fd;
+};
+
+static char mbm_total_path[1024];
+static int imcs;
+static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+
+void membw_initialize_perf_event_attr(int i, int j)
+{
+	memset(&imc_counters_config[i][j].pe, 0,
+	       sizeof(struct perf_event_attr));
+	imc_counters_config[i][j].pe.type = imc_counters_config[i][j].type;
+	imc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
+	imc_counters_config[i][j].pe.disabled = 1;
+	imc_counters_config[i][j].pe.inherit = 1;
+	imc_counters_config[i][j].pe.exclude_guest = 0;
+	imc_counters_config[i][j].pe.config =
+		imc_counters_config[i][j].umask << 8 |
+		imc_counters_config[i][j].event;
+	imc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
+	imc_counters_config[i][j].pe.read_format =
+		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
+}
+
+void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+void membw_ioctl_perf_event_ioc_disable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
+}
+
+/*
+ * get_event_and_umask:	Parse config into event and umask
+ * @cas_count_cfg:	Config
+ * @count:		iMC number
+ * @op:			Operation (read/write)
+ */
+void get_event_and_umask(char *cas_count_cfg, int count, bool op)
+{
+	char *token[MAX_TOKENS];
+	int i = 0;
+
+	strcat(cas_count_cfg, ",");
+	token[0] = strtok(cas_count_cfg, "=,");
+
+	for (i = 1; i < MAX_TOKENS; i++)
+		token[i] = strtok(NULL, "=,");
+
+	for (i = 0; i < MAX_TOKENS; i++) {
+		if (!token[i])
+			break;
+		if (strcmp(token[i], "event") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].event =
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].event =
+				strtol(token[i + 1], NULL, 16);
+		}
+		if (strcmp(token[i], "umask") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].umask =
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].umask =
+				strtol(token[i + 1], NULL, 16);
+		}
+	}
+}
+
+static int open_perf_event(int i, int cpu_no, int j)
+{
+	imc_counters_config[i][j].fd =
+		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+
+	if (imc_counters_config[i][j].fd == -1) {
+		fprintf(stderr, "Error opening leader %llx\n",
+			imc_counters_config[i][j].pe.config);
+
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Get type and config (read and write) of an iMC counter */
+static int read_from_imc_dir(char *imc_dir, int count)
+{
+	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
+	fp = fopen(imc_counter_type, "r");
+	if (!fp) {
+		perror("Failed to open imc counter type file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
+		perror("Could not get imc type");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	imc_counters_config[count][WRITE].type =
+				imc_counters_config[count][READ].type;
+
+	/* Get read config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+		perror("Could not get imc cas count read");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, READ);
+
+	/* Get write config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+		perror("Could not get imc cas count write");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, WRITE);
+
+	return 0;
+}
+
+/*
+ * A system can have 'n' number of iMC (Integrated Memory Controller)
+ * counters, get that 'n'. For each iMC counter get it's type and config.
+ * Also, each counter has two configs, one for read and the other for write.
+ * A config again has two parts, event and umask.
+ * Enumerate all these details into an array of structures.
+ *
+ * Return: >= 0 on success. < 0 on failure.
+ */
+static int num_of_imcs(void)
+{
+	unsigned int count = 0;
+	char imc_dir[512];
+	struct dirent *ep;
+	int ret;
+	DIR *dp;
+
+	dp = opendir(DYN_PMU_PATH);
+	if (dp) {
+		while ((ep = readdir(dp))) {
+			if (strstr(ep->d_name, UNCORE_IMC)) {
+				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
+					ep->d_name);
+				ret = read_from_imc_dir(imc_dir, count);
+				if (ret) {
+					closedir(dp);
+
+					return ret;
+				}
+				count++;
+			}
+		}
+		closedir(dp);
+		if (count == 0) {
+			perror("Unable find iMC counters!\n");
+
+			return -1;
+		}
+	} else {
+		perror("Unable to open PMU directory!\n");
+
+		return -1;
+	}
+
+	return count;
+}
+
+static int initialize_mem_bw_imc(void)
+{
+	int imc, j;
+
+	imcs = num_of_imcs();
+	if (imcs <= 0)
+		return imcs;
+
+	/* Initialize perf_event_attr structures for all iMC's */
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++)
+			membw_initialize_perf_event_attr(imc, j);
+	}
+
+	return 0;
+}
+
+/*
+ * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @bw_report:		Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ *
+ * Return: >= 0 on success. < 0 on failure.
+ */
+static float get_mem_bw_imc(int cpu_no, char *bw_report)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc, j, ret;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++) {
+			ret = open_perf_event(imc, cpu_no, j);
+			if (ret)
+				return -1;
+		}
+		for (j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+	}
+
+	sleep(1);
+
+	/* Stop counters after a second to get results (both read and write) */
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_disable(imc, j);
+	}
+
+	/*
+	 * Get results which are stored in struct type imc_counter_config
+	 * Take over flow into consideration before calculating total b/w
+	 */
+	for (imc = 0; imc < imcs; imc++) {
+		struct imc_counter_config *r =
+			&imc_counters_config[imc][READ];
+		struct imc_counter_config *w =
+			&imc_counters_config[imc][WRITE];
+
+		if (read(r->fd, &r->return_value,
+			 sizeof(struct membw_read_format)) == -1) {
+			perror("Couldn't get read b/w through iMC");
+
+			return -1;
+		}
+
+		if (read(w->fd, &w->return_value,
+			 sizeof(struct membw_read_format)) == -1) {
+			perror("Couldn't get write bw through iMC");
+
+			return -1;
+		}
+
+		__u64 r_time_enabled = r->return_value.time_enabled;
+		__u64 r_time_running = r->return_value.time_running;
+
+		if (r_time_enabled != r_time_running)
+			of_mul_read = (float)r_time_enabled /
+					(float)r_time_running;
+
+		__u64 w_time_enabled = w->return_value.time_enabled;
+		__u64 w_time_running = w->return_value.time_running;
+
+		if (w_time_enabled != w_time_running)
+			of_mul_write = (float)w_time_enabled /
+					(float)w_time_running;
+		reads += r->return_value.value * of_mul_read * SCALE;
+		writes += w->return_value.value * of_mul_write * SCALE;
+	}
+
+	for (imc = 0; imc < imcs; imc++) {
+		close(imc_counters_config[imc][READ].fd);
+		close(imc_counters_config[imc][WRITE].fd);
+	}
+
+	if (strcmp(bw_report, "reads") == 0)
+		return reads;
+
+	if (strcmp(bw_report, "writes") == 0)
+		return writes;
+
+	return (reads + writes);
+}
+
+void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
+{
+	if (ctrlgrp && mongrp)
+		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
+			RESCTRL_PATH, ctrlgrp, mongrp, resource_id);
+	else if (!ctrlgrp && mongrp)
+		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			mongrp, resource_id);
+	else if (ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			ctrlgrp, resource_id);
+	else if (!ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			resource_id);
+}
+
+/*
+ * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
+ */
+static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
+				      int cpu_no, char *resctrl_val)
+{
+	int resource_id;
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		perror("Could not get resource_id");
+		return;
+	}
+
+	if (strcmp(resctrl_val, "mbm") == 0)
+		set_mbm_path(ctrlgrp, mongrp, resource_id);
+
+	if ((strcmp(resctrl_val, "mba") == 0)) {
+		if (ctrlgrp)
+			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, ctrlgrp, resource_id);
+		else
+			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, resource_id);
+	}
+}
+
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ * For MBM,
+ * 1. If con_mon grp and mon grp are given, then read from con_mon grp's mon grp
+ * 2. If only con_mon grp is given, then read from con_mon grp
+ * 3. If both are not given, then read from root con_mon grp
+ * For MBA,
+ * 1. If con_mon grp is given, then read from it
+ * 2. If con_mon grp is not given, then read from root con_mon grp
+ */
+static unsigned long get_mem_bw_resctrl(void)
+{
+	unsigned long mbm_total = 0;
+	FILE *fp;
+
+	fp = fopen(mbm_total_path, "r");
+	if (!fp) {
+		perror("Failed to open total bw file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%lu", &mbm_total) <= 0) {
+		perror("Could not get mbm local bytes");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return mbm_total;
+}
+
+pid_t bm_pid, ppid;
+
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
+{
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+	tests_cleanup();
+	printf("Ending\n\n");
+
+	exit(EXIT_SUCCESS);
+}
+
+/*
+ * print_results_bw:	the memory bandwidth results are stored in a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @bw_imc:		perf imc counter value
+ * @bw_resc:		memory bandwidth value
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
+			    unsigned long bw_resc)
+{
+	unsigned long diff = fabs(bw_imc - bw_resc);
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
+			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			fclose(fp);
+			perror("Could not log results.");
+
+			return errno;
+		}
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+{
+	if (strlen(ctrlgrp) && strlen(mongrp))
+		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
+			ctrlgrp, mongrp, sock_num);
+	else if (!strlen(ctrlgrp) && strlen(mongrp))
+		sprintf(llc_occup_path,	MON_LCC_OCCUP_PATH, RESCTRL_PATH,
+			mongrp, sock_num);
+	else if (strlen(ctrlgrp) && !strlen(mongrp))
+		sprintf(llc_occup_path,	CON_LCC_OCCUP_PATH, RESCTRL_PATH,
+			ctrlgrp, sock_num);
+	else if (!strlen(ctrlgrp) && !strlen(mongrp))
+		sprintf(llc_occup_path, LCC_OCCUP_PATH,	RESCTRL_PATH, sock_num);
+}
+
+/*
+ * initialize_llc_occu_resctrl:	Appropriately populate "llc_occup_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
+ */
+static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
+					int cpu_no, char *resctrl_val)
+{
+	int resource_id;
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		perror("# Unable to resource_id");
+		return;
+	}
+
+	if (strcmp(resctrl_val, "cqm") == 0)
+		set_cqm_path(ctrlgrp, mongrp, resource_id);
+}
+
+static int
+measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
+{
+	unsigned long bw_imc, bw_resc, bw_resc_end;
+	int ret;
+
+	/*
+	 * Measure memory bandwidth from resctrl and from
+	 * another source which is perf imc value or could
+	 * be something else if perf imc event is not available.
+	 * Compare the two values to validate resctrl value.
+	 * It takes 1sec to measure the data.
+	 */
+	bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
+	if (bw_imc <= 0)
+		return bw_imc;
+
+	bw_resc_end = get_mem_bw_resctrl();
+	if (bw_resc_end <= 0)
+		return bw_resc_end;
+
+	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
+	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	if (ret)
+		return ret;
+
+	*bw_resc_start = bw_resc_end;
+
+	return 0;
+}
+
+/*
+ * resctrl_val:	execute benchmark and measure memory bandwidth on
+ *			the benchmark
+ * @benchmark_cmd:	benchmark command and its arguments
+ * @param:		parameters passed to resctrl_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
+{
+	char *resctrl_val = param->resctrl_val;
+	unsigned long bw_resc_start = 0;
+	struct sigaction sigact;
+	int ret = 0, pipefd[2];
+	char pipe_message = 0;
+	union sigval value;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	if ((strcmp(resctrl_val, "mba")) == 0 ||
+	    (strcmp(resctrl_val, "mbm")) == 0) {
+		ret = validate_bw_report_request(param->bw_report);
+		if (ret)
+			return ret;
+	}
+
+	ret = remount_resctrlfs(param->mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	/*
+	 * If benchmark wasn't successfully started by child, then child should
+	 * kill parent, so save parent's pid
+	 */
+	ppid = getpid();
+
+	if (pipe(pipefd)) {
+		perror("# Unable to create pipe");
+
+		return -1;
+	}
+
+	/*
+	 * Fork to start benchmark, save child's pid so that it can be killed
+	 * when needed
+	 */
+	bm_pid = fork();
+	if (bm_pid == -1) {
+		perror("# Unable to fork");
+
+		return -1;
+	}
+
+	if (bm_pid == 0) {
+		/*
+		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
+		 * start benchmark
+		 */
+		sigfillset(&sigact.sa_mask);
+		sigdelset(&sigact.sa_mask, SIGUSR1);
+
+		sigact.sa_sigaction = run_benchmark;
+		sigact.sa_flags = SA_SIGINFO;
+
+		/* Register for "SIGUSR1" signal from parent */
+		if (sigaction(SIGUSR1, &sigact, NULL))
+			PARENT_EXIT("Can't register child for signal");
+
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			perror("# failed signaling parent process");
+			close(pipefd[1]);
+			return -1;
+		}
+		close(pipefd[1]);
+
+		/* Suspend child until delivery of "SIGUSR1" from parent */
+		sigsuspend(&sigact.sa_mask);
+
+		PARENT_EXIT("Child is done");
+	}
+
+	printf("# benchmark PID: %d\n", bm_pid);
+
+	/*
+	 * Register CTRL-C handler for parent, as it has to kill benchmark
+	 * before exiting
+	 */
+	sigact.sa_sigaction = ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+		ret = errno;
+		goto out;
+	}
+
+	value.sival_ptr = benchmark_cmd;
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		goto out;
+
+	/* Write benchmark to specified control&monitoring grp in resctrl FS */
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		goto out;
+
+	if ((strcmp(resctrl_val, "mbm") == 0) ||
+	    (strcmp(resctrl_val, "mba") == 0)) {
+		ret = initialize_mem_bw_imc();
+		if (ret)
+			goto out;
+
+		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
+					  param->cpu_no, resctrl_val);
+	} else if (strcmp(resctrl_val, "cqm") == 0)
+		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
+					    param->cpu_no, resctrl_val);
+
+	/* Parent waits for child to be ready. */
+	close(pipefd[1]);
+	while (pipe_message != 1) {
+		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			perror("# failed reading message from child process");
+			close(pipefd[0]);
+			goto out;
+		}
+	}
+	close(pipefd[0]);
+
+	/* Signal child to start benchmark */
+	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
+		perror("# sigqueue SIGUSR1 to child");
+		ret = errno;
+		goto out;
+	}
+
+	/* Give benchmark enough time to fully run */
+	sleep(1);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if ((strcmp(resctrl_val, "mbm") == 0) ||
+		    (strcmp(resctrl_val, "mba") == 0)) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+
+			ret = measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else if (strcmp(resctrl_val, "cqm") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+			sleep(1);
+			ret = measure_cache_vals(param, bm_pid);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+out:
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
new file mode 100644
index 000000000000..19c0ec4045a4
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic resctrl file system operations
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+int tests_run;
+
+static int find_resctrl_mount(char *buffer)
+{
+	FILE *mounts;
+	char line[256], *fs, *mntpoint;
+
+	mounts = fopen("/proc/mounts", "r");
+	if (!mounts) {
+		perror("/proc/mounts");
+		return -ENXIO;
+	}
+	while (!feof(mounts)) {
+		if (!fgets(line, 256, mounts))
+			break;
+		fs = strtok(line, " \t");
+		if (!fs)
+			continue;
+		mntpoint = strtok(NULL, " \t");
+		if (!mntpoint)
+			continue;
+		fs = strtok(NULL, " \t");
+		if (!fs)
+			continue;
+		if (strcmp(fs, "resctrl"))
+			continue;
+
+		fclose(mounts);
+		if (buffer)
+			strncpy(buffer, mntpoint, 256);
+
+		return 0;
+	}
+
+	fclose(mounts);
+
+	return -ENOENT;
+}
+
+char cbm_mask[256];
+
+/*
+ * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ *
+ * If not mounted, mount it.
+ * If mounted and mum_resctrlfs then remount resctrl FS.
+ * If mounted and !mum_resctrlfs then noop
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int remount_resctrlfs(bool mum_resctrlfs)
+{
+	char mountpoint[256];
+	int ret;
+
+	ret = find_resctrl_mount(mountpoint);
+	if (ret)
+		strcpy(mountpoint, RESCTRL_PATH);
+
+	if (!ret && mum_resctrlfs && umount(mountpoint)) {
+		printf("not ok unmounting \"%s\"\n", mountpoint);
+		perror("# umount");
+		tests_run++;
+	}
+
+	if (!ret && !mum_resctrlfs)
+		return 0;
+
+	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
+	printf("%sok mounting resctrl to \"%s\"\n", ret ? "not " : "",
+	       RESCTRL_PATH);
+	if (ret)
+		perror("# mount");
+
+	tests_run++;
+
+	return ret;
+}
+
+int umount_resctrlfs(void)
+{
+	if (umount(RESCTRL_PATH)) {
+		perror("# Unable to umount resctrl");
+
+		return errno;
+	}
+
+	return 0;
+}
+
+/*
+ * get_resource_id - Get socket number/l3 id for a specified CPU
+ * @cpu_no:	CPU number
+ * @resource_id: Socket number or l3_id
+ *
+ * Return: >= 0 on success, < 0 on failure.
+ */
+int get_resource_id(int cpu_no, int *resource_id)
+{
+	char phys_pkg_path[1024];
+	FILE *fp;
+
+	if (is_amd)
+		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
+			PHYS_ID_PATH, cpu_no);
+	else
+		sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
+			PHYS_ID_PATH, cpu_no);
+
+	fp = fopen(phys_pkg_path, "r");
+	if (!fp) {
+		perror("Failed to open physical_package_id");
+
+		return -1;
+	}
+	if (fscanf(fp, "%d", resource_id) <= 0) {
+		perror("Could not get socket number or l3 id");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * get_cache_size - Get cache size for a specified CPU
+ * @cpu_no:	CPU number
+ * @cache_type:	Cache level L2/L3
+ * @cache_size:	pointer to cache_size
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
+{
+	char cache_path[1024], cache_str[64];
+	int length, i, cache_num;
+	FILE *fp;
+
+	if (!strcmp(cache_type, "L3")) {
+		cache_num = 3;
+	} else if (!strcmp(cache_type, "L2")) {
+		cache_num = 2;
+	} else {
+		perror("Invalid cache level");
+		return -1;
+	}
+
+	sprintf(cache_path, "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
+		cpu_no, cache_num);
+	fp = fopen(cache_path, "r");
+	if (!fp) {
+		perror("Failed to open cache size");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cache_str) <= 0) {
+		perror("Could not get cache_size");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	length = (int)strlen(cache_str);
+
+	*cache_size = 0;
+
+	for (i = 0; i < length; i++) {
+		if ((cache_str[i] >= '0') && (cache_str[i] <= '9'))
+
+			*cache_size = *cache_size * 10 + (cache_str[i] - '0');
+
+		else if (cache_str[i] == 'K')
+
+			*cache_size = *cache_size * 1024;
+
+		else if (cache_str[i] == 'M')
+
+			*cache_size = *cache_size * 1024 * 1024;
+
+		else
+			break;
+	}
+
+	return 0;
+}
+
+#define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
+
+/*
+ * get_cbm_mask - Get cbm mask for given cache
+ * @cache_type:	Cache level L2/L3
+ *
+ * Mask is stored in cbm_mask which is global variable.
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_cbm_mask(char *cache_type)
+{
+	char cbm_mask_path[1024];
+	FILE *fp;
+
+	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
+
+	fp = fopen(cbm_mask_path, "r");
+	if (!fp) {
+		perror("Failed to open cache level");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cbm_mask) <= 0) {
+		perror("Could not get max cbm_mask");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * get_core_sibling - Get sibling core id from the same socket for given CPU
+ * @cpu_no:	CPU number
+ *
+ * Return:	> 0 on success, < 0 on failure.
+ */
+int get_core_sibling(int cpu_no)
+{
+	char core_siblings_path[1024], cpu_list_str[64];
+	int sibling_cpu_no = -1;
+	FILE *fp;
+
+	sprintf(core_siblings_path, "%s%d/topology/core_siblings_list",
+		CORE_SIBLINGS_PATH, cpu_no);
+
+	fp = fopen(core_siblings_path, "r");
+	if (!fp) {
+		perror("Failed to open core siblings path");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cpu_list_str) <= 0) {
+		perror("Could not get core_siblings list");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	char *token = strtok(cpu_list_str, "-,");
+
+	while (token) {
+		sibling_cpu_no = atoi(token);
+		/* Skipping core 0 as we don't want to run test on core 0 */
+		if (sibling_cpu_no != 0)
+			break;
+		token = strtok(NULL, "-,");
+	}
+
+	return sibling_cpu_no;
+}
+
+/*
+ * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
+ * @bm_pid:	PID that should be binded
+ * @cpu_no:	CPU number at which the PID would be binded
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int taskset_benchmark(pid_t bm_pid, int cpu_no)
+{
+	cpu_set_t my_set;
+
+	CPU_ZERO(&my_set);
+	CPU_SET(cpu_no, &my_set);
+
+	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
+		perror("Unable to taskset benchmark");
+
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ *
+ * Return: void
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	int operation, ret, malloc_and_init_memory, memflush;
+	unsigned long span, buffer_span;
+	char **benchmark_cmd;
+	char resctrl_val[64];
+	FILE *fp;
+
+	benchmark_cmd = info->si_ptr;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	fp = freopen("/dev/null", "w", stdout);
+	if (!fp)
+		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		/* Execute default fill_buf benchmark */
+		span = strtoul(benchmark_cmd[1], NULL, 10);
+		malloc_and_init_memory = atoi(benchmark_cmd[2]);
+		memflush =  atoi(benchmark_cmd[3]);
+		operation = atoi(benchmark_cmd[4]);
+		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
+
+		if (strcmp(resctrl_val, "cqm") != 0)
+			buffer_span = span * MB;
+		else
+			buffer_span = span;
+
+		if (run_fill_buf(buffer_span, malloc_and_init_memory, memflush,
+				 operation, resctrl_val))
+			fprintf(stderr, "Error in running fill buffer\n");
+	} else {
+		/* Execute specified benchmark */
+		ret = execvp(benchmark_cmd[0], benchmark_cmd);
+		if (ret)
+			perror("wrong\n");
+	}
+
+	fclose(stdout);
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
+/*
+ * create_grp - Create a group only if one doesn't exist
+ * @grp_name:	Name of the group
+ * @grp:	Full path and name of the group
+ * @parent_grp:	Full path and name of the parent group
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
+{
+	int found_grp = 0;
+	struct dirent *ep;
+	DIR *dp;
+
+	/*
+	 * At this point, we are guaranteed to have resctrl FS mounted and if
+	 * length of grp_name == 0, it means, user wants to use root con_mon
+	 * grp, so do nothing
+	 */
+	if (strlen(grp_name) == 0)
+		return 0;
+
+	/* Check if requested grp exists or not */
+	dp = opendir(parent_grp);
+	if (dp) {
+		while ((ep = readdir(dp)) != NULL) {
+			if (strcmp(ep->d_name, grp_name) == 0)
+				found_grp = 1;
+		}
+		closedir(dp);
+	} else {
+		perror("Unable to open resctrl for group");
+
+		return -1;
+	}
+
+	/* Requested grp doesn't exist, hence create it */
+	if (found_grp == 0) {
+		if (mkdir(grp, 0) == -1) {
+			perror("Unable to create group");
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int write_pid_to_tasks(char *tasks, pid_t pid)
+{
+	FILE *fp;
+
+	fp = fopen(tasks, "w");
+	if (!fp) {
+		perror("Failed to open tasks file");
+
+		return -1;
+	}
+	if (fprintf(fp, "%d\n", pid) < 0) {
+		perror("Failed to wr pid to tasks file");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * write_bm_pid_to_resctrl - Write a PID (i.e. benchmark) to resctrl FS
+ * @bm_pid:		PID that should be written
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * If a con_mon grp is requested, create it and write pid to it, otherwise
+ * write pid to root con_mon grp.
+ * If a mon grp is requested, create it and write pid to it, otherwise
+ * pid is not written, this means that pid is in con_mon grp and hence
+ * should consult con_mon grp's mon_data directory for results.
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val)
+{
+	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
+	char tasks[1024];
+	int ret = 0;
+
+	if (strlen(ctrlgrp))
+		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s", RESCTRL_PATH);
+
+	/* Create control and monitoring group and write pid into it */
+	ret = create_grp(ctrlgrp, controlgroup, RESCTRL_PATH);
+	if (ret)
+		goto out;
+	sprintf(tasks, "%s/tasks", controlgroup);
+	ret = write_pid_to_tasks(tasks, bm_pid);
+	if (ret)
+		goto out;
+
+	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
+	if ((strcmp(resctrl_val, "cqm") == 0) ||
+	    (strcmp(resctrl_val, "mbm") == 0)) {
+		if (strlen(mongrp)) {
+			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
+			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
+			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
+			if (ret)
+				goto out;
+
+			sprintf(tasks, "%s/mon_groups/%s/tasks",
+				controlgroup, mongrp);
+			ret = write_pid_to_tasks(tasks, bm_pid);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	printf("%sok writing benchmark parameters to resctrl FS\n",
+	       ret ? "not " : "");
+	if (ret)
+		perror("# writing to resctrlfs");
+
+	tests_run++;
+
+	return ret;
+}
+
+/*
+ * write_schemata - Update schemata of a con_mon grp
+ * @ctrlgrp:		Name of the con_mon grp
+ * @schemata:		Schemata that should be updated to
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * Update schemata of a con_mon grp *only* if requested resctrl feature is
+ * allocation type
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
+{
+	char controlgroup[1024], schema[1024], reason[64];
+	int resource_id, ret = 0;
+	FILE *fp;
+
+	if ((strcmp(resctrl_val, "mba") != 0) &&
+	    (strcmp(resctrl_val, "cat") != 0) &&
+	    (strcmp(resctrl_val, "cqm") != 0))
+		return -ENOENT;
+
+	if (!schemata) {
+		printf("# Skipping empty schemata update\n");
+
+		return -1;
+	}
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		sprintf(reason, "Failed to get resource id");
+		ret = -1;
+
+		goto out;
+	}
+
+	if (strlen(ctrlgrp) != 0)
+		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
+
+	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
+		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
+	if (strcmp(resctrl_val, "mba") == 0)
+		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
+
+	fp = fopen(controlgroup, "w");
+	if (!fp) {
+		sprintf(reason, "Failed to open control group");
+		ret = -1;
+
+		goto out;
+	}
+
+	if (fprintf(fp, "%s\n", schema) < 0) {
+		sprintf(reason, "Failed to write schemata in control group");
+		fclose(fp);
+		ret = -1;
+
+		goto out;
+	}
+	fclose(fp);
+
+out:
+	printf("%sok Write schema \"%s\" to resctrl FS%s%s\n",
+	       ret ? "not " : "", schema, ret ? " # " : "",
+	       ret ? reason : "");
+	tests_run++;
+
+	return ret;
+}
+
+bool check_resctrlfs_support(void)
+{
+	FILE *inf = fopen("/proc/filesystems", "r");
+	DIR *dp;
+	char *res;
+	bool ret = false;
+
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, "nodev\tresctrl\n");
+
+	if (res) {
+		ret = true;
+		free(res);
+	}
+
+	fclose(inf);
+
+	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
+	tests_run++;
+
+	dp = opendir(RESCTRL_PATH);
+	printf("%sok resctrl mountpoint \"%s\" exists\n",
+	       dp ? "" : "not ", RESCTRL_PATH);
+	if (dp)
+		closedir(dp);
+	tests_run++;
+
+	printf("# resctrl filesystem %s mounted\n",
+	       find_resctrl_mount(NULL) ? "not" : "is");
+
+	return ret;
+}
+
+char *fgrep(FILE *inf, const char *str)
+{
+	char line[256];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return strdup(line);
+	}
+
+	return NULL;
+}
+
+/*
+ * validate_resctrl_feature_request - Check if requested feature is valid.
+ * @resctrl_val:	Requested feature
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+bool validate_resctrl_feature_request(char *resctrl_val)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	bool found = false;
+	char *res;
+
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, "flags");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		found = s && !strstr(s, resctrl_val);
+		free(res);
+	}
+	fclose(inf);
+
+	return found;
+}
+
+int filter_dmesg(void)
+{
+	char line[1024];
+	FILE *fp;
+	int pipefds[2];
+	pid_t pid;
+	int ret;
+
+	ret = pipe(pipefds);
+	if (ret) {
+		perror("pipe");
+		return ret;
+	}
+	pid = fork();
+	if (pid == 0) {
+		close(pipefds[0]);
+		dup2(pipefds[1], STDOUT_FILENO);
+		execlp("dmesg", "dmesg", NULL);
+		perror("executing dmesg");
+		exit(1);
+	}
+	close(pipefds[1]);
+	fp = fdopen(pipefds[0], "r");
+	if (!fp) {
+		perror("fdopen(pipe)");
+		kill(pid, SIGTERM);
+
+		return -1;
+	}
+
+	while (fgets(line, 1024, fp)) {
+		if (strstr(line, "intel_rdt:"))
+			printf("# dmesg: %s", line);
+		if (strstr(line, "resctrl:"))
+			printf("# dmesg: %s", line);
+	}
+	fclose(fp);
+	waitpid(pid, NULL, 0);
+
+	return 0;
+}
+
+int validate_bw_report_request(char *bw_report)
+{
+	if (strcmp(bw_report, "reads") == 0)
+		return 0;
+	if (strcmp(bw_report, "writes") == 0)
+		return 0;
+	if (strcmp(bw_report, "nt-writes") == 0) {
+		strcpy(bw_report, "writes");
+		return 0;
+	}
+	if (strcmp(bw_report, "total") == 0)
+		return 0;
+
+	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
+
+	return -1;
+}
+
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
+		      group_fd, flags);
+	return ret;
+}
+
+unsigned int count_bits(unsigned long n)
+{
+	unsigned int count = 0;
+
+	while (n) {
+		count += n & 1;
+		n >>= 1;
+	}
+
+	return count;
+}
diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..0ebfe8b0e147 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
-
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
-
-all: $(BINARIES)
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
+include ../lib.mk
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ee1b727ede04..7bf82fb07f67 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -909,7 +909,7 @@ TEST(ERRNO_order)
 	EXPECT_EQ(12, errno);
 }
 
-FIXTURE_DATA(TRAP) {
+FIXTURE(TRAP) {
 	struct sock_fprog prog;
 };
 
@@ -1020,7 +1020,7 @@ TEST_F(TRAP, handler)
 	EXPECT_NE(0, (unsigned long)sigsys->_call_addr);
 }
 
-FIXTURE_DATA(precedence) {
+FIXTURE(precedence) {
 	struct sock_fprog allow;
 	struct sock_fprog log;
 	struct sock_fprog trace;
@@ -1509,7 +1509,7 @@ void tracer_poke(struct __test_metadata *_metadata, pid_t tracee, int status,
 	EXPECT_EQ(0, ret);
 }
 
-FIXTURE_DATA(TRACE_poke) {
+FIXTURE(TRACE_poke) {
 	struct sock_fprog prog;
 	pid_t tracer;
 	long poked;
@@ -1817,7 +1817,7 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
-FIXTURE_DATA(TRACE_syscall) {
+FIXTURE(TRACE_syscall) {
 	struct sock_fprog prog;
 	pid_t tracer, mytid, mypid, parent;
 };
@@ -2321,7 +2321,7 @@ struct tsync_sibling {
 		}							\
 	} while (0)
 
-FIXTURE_DATA(TSYNC) {
+FIXTURE(TSYNC) {
 	struct sock_fprog root_prog, apply_prog;
 	struct tsync_sibling sibling[TSYNC_SIBLINGS];
 	sem_t started;
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index 87b47b557a7a..e40dc5be2f66 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -11,7 +11,6 @@
 #include <sys/wait.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 #include <string.h>
 
 #include "log.h"
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 43d93f4006b9..7f14f0fdac84 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -12,7 +12,6 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 
 #include "log.h"
 #include "timens.h"
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 559d26e21ba0..098be7c83be3 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -10,7 +10,6 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 #include <string.h>
 
 #include "log.h"
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 0cca7aafc4bd..96dba11ebe44 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <signal.h>
-#include <time.h>
 
 #include "log.h"
 #include "timens.h"

--------------EAECAB088049D0AF82A13C3A--
