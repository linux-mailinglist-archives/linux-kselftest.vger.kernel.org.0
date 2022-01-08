Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DD487FD9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jan 2022 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiAHAJE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jan 2022 19:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAHAJD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jan 2022 19:09:03 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DEFC061574
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jan 2022 16:09:03 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so9190510iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jan 2022 16:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=b2zr8dMgJYDD03vbsbiodlnJA7EEOcDbEZwhm5+GlYM=;
        b=UKB8C/McAj314Zgt7mIVAfD8sx1bwY37r/WFNtgVQLsnoJNR37Gtv33/QlWy1oe0Xv
         BB2YfcQv2gtQuGl8hBUQopMg8ZI0L428ubGLN+TqrEoT7tIUzUEFW0wnm8XQ9KOB0m46
         I3GBTX7dzQwG10WkllvD801IrNW2Jka1jvy2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=b2zr8dMgJYDD03vbsbiodlnJA7EEOcDbEZwhm5+GlYM=;
        b=fE2y/V+2qmOGBCyKlIxLQwFpjXLCZKhx2RylkOUvsKgh9mFvLJfNcgFgdmri0KumLP
         mpFU6duEp5BSqw+1tCbGzmcq5DLCgRG7K9cOdBlyOfFvaZQrwWJ80ZIJNvBwJ2ZPfE0a
         Ld22MHuptyFfLNSn3rOdYtYJdmeaIRI3Eb/3vN9FXgOj9dCnfp+FW4Gqv7BvBgcrSvM3
         g2/z18M/WFTJ7VuGNQcO3z668AxS7VNTDIl8u+Gu2vhyWxSbV6pyM9SKfVUKIhqUP3yZ
         cV/OKbMPmBJ9vgBh3U85wCENZHlDOVWpbGCN++IjLRQFPXm0M55tCIsB8Vbs80+MbNgs
         BJ0A==
X-Gm-Message-State: AOAM531G3qAY6+hRgtnR198t0c0KAOSW9ilINxyvDOX23PnsiyqdJklp
        R+qP/2wkvoTObCkqrQhAyqtq1A==
X-Google-Smtp-Source: ABdhPJyOTR7L2921ZlLkm2ehw+sTlzVOncmm13TbkspUHTvTQjZf61G8O1W3V+coEwK60cBbe1bEeQ==
X-Received: by 2002:a05:6602:214a:: with SMTP id y10mr30338097ioy.121.1641600542885;
        Fri, 07 Jan 2022 16:09:02 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m14sm60100iow.54.2022.01.07.16.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 16:09:02 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.17-rc1
Message-ID: <ccdfab91-3c7a-546e-8e44-9fbd5117ec6b@linuxfoundation.org>
Date:   Fri, 7 Jan 2022 17:08:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------07F15015FD03AE844E58D685"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------07F15015FD03AE844E58D685
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.17-rc1

This Kselftest update for Linux 5.17-rc1 consists of fixes to build
errors, false negatives, and several code cleanups, including the
ARRAY_SIZE cleanup that removes 25+ duplicates ARRAY_SIZE defines
from individual tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

   Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.17-rc1

for you to fetch changes up to e89908201e2509354c40158b517945bf3d645812:

   selftests/vm: remove ARRAY_SIZE define from individual tests (2021-12-10 17:51:25 -0700)

----------------------------------------------------------------
linux-kselftest-next-5.17-rc1

This Kselftest update for Linux 5.17-rc1 consists of fixes to build
errors, false negatives, and several code cleanups, including the
ARRAY_SIZE cleanup that removes 25+ duplicates ARRAY_SIZE defines
from individual tests.

----------------------------------------------------------------
Anders Roxell (2):
       selftests: clone3: clone3: add case CLONE3_ARGS_NO_TEST
       selftests: cgroup: build error multiple outpt files

Heiko Carstens (1):
       selftests/ftrace: make kprobe profile testcase description unique

Jakub Kicinski (1):
       selftests: harness: avoid false negatives if test has no ASSERTs

Shuah Khan (12):
       tools: fix ARRAY_SIZE defines in tools and selftests hdrs
       selftests/arm64: remove ARRAY_SIZE define from vec-syscfg.c
       selftests/cgroup: remove ARRAY_SIZE define from cgroup_util.h
       selftests/core: remove ARRAY_SIZE define from close_range_test.c
       selftests/ir: remove ARRAY_SIZE define from ir_loopback.c
       selftests/landlock: remove ARRAY_SIZE define from common.h
       selftests/net: remove ARRAY_SIZE define from individual tests
       selftests/rseq: remove ARRAY_SIZE define from individual tests
       selftests/seccomp: remove ARRAY_SIZE define from seccomp_benchmark
       selftests/sparc64: remove ARRAY_SIZE define from adi-test
       selftests/timens: remove ARRAY_SIZE define from individual tests
       selftests/vm: remove ARRAY_SIZE define from individual tests

Yang Guang (2):
       selftests/mount: remove unneeded conversion to bool
       selftests/move_mount_set_group remove unneeded conversion to bool

Zhang Mingyu (2):
       kselftests: timers:Remove unneeded semicolon
       selftests: timers: Remove unneeded semicolon

  tools/include/linux/kernel.h                                 |  2 ++
  tools/testing/selftests/arm64/fp/vec-syscfg.c                |  2 --
  tools/testing/selftests/cgroup/Makefile                      | 12 +++++++-----
  tools/testing/selftests/cgroup/cgroup_util.h                 |  4 ++--
  tools/testing/selftests/clone3/clone3.c                      |  6 ++++++
  tools/testing/selftests/core/close_range_test.c              |  4 ----
  tools/testing/selftests/ftrace/test.d/kprobe/profile.tc      |  2 +-
  tools/testing/selftests/ir/ir_loopback.c                     |  1 -
  tools/testing/selftests/kselftest.h                          |  4 ++++
  tools/testing/selftests/kselftest_harness.h                  |  4 +++-
  tools/testing/selftests/landlock/common.h                    |  4 ----
  tools/testing/selftests/lib.mk                               |  2 +-
  tools/testing/selftests/mount/unprivileged-remount-test.c    |  4 ++--
  .../move_mount_set_group/move_mount_set_group_test.c         | 10 +++++-----
  tools/testing/selftests/net/gro.c                            |  3 ++-
  tools/testing/selftests/net/ipsec.c                          |  1 -
  tools/testing/selftests/net/reuseport_bpf.c                  |  4 +---
  tools/testing/selftests/net/rxtimestamp.c                    |  2 +-
  tools/testing/selftests/net/socket.c                         |  3 ++-
  tools/testing/selftests/net/tcp_fastopen_backup_key.c        |  6 ++----
  tools/testing/selftests/rseq/basic_percpu_ops_test.c         |  3 +--
  tools/testing/selftests/rseq/rseq.c                          |  3 +--
  tools/testing/selftests/seccomp/seccomp_benchmark.c          |  2 +-
  tools/testing/selftests/sparc64/drivers/adi-test.c           |  4 ----
  tools/testing/selftests/timens/procfs.c                      |  2 --
  tools/testing/selftests/timens/timens.c                      |  2 --
  tools/testing/selftests/timers/alarmtimer-suspend.c          |  2 +-
  tools/testing/selftests/timers/inconsistency-check.c         |  2 +-
  tools/testing/selftests/vm/mremap_test.c                     |  1 -
  tools/testing/selftests/vm/pkey-helpers.h                    |  3 ++-
  tools/testing/selftests/vm/va_128TBswitch.c                  |  2 +-
  31 files changed, 49 insertions(+), 57 deletions(-)
----------------------------------------------------------------

--------------07F15015FD03AE844E58D685
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.17-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.17-rc1.diff"

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 3e8df500cfbd..9701e8307db0 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -92,7 +92,9 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 int scnprintf(char * buf, size_t size, const char * fmt, ...);
 int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 
+#ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+#endif
 
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 272b888e018e..c90658811a83 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -21,8 +21,6 @@
 #include "../../kselftest.h"
 #include "rdvl.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
-
 #define ARCH_MIN_VL SVE_VL_MIN
 
 struct vec_data {
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 59e222460581..745fe25fa0b9 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_kill
 
+LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
+
 include ../lib.mk
 
-$(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
-$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h ../pidfd/pidfd.h
+$(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_kmem: cgroup_util.c
+$(OUTPUT)/test_core: cgroup_util.c
+$(OUTPUT)/test_freezer: cgroup_util.c
+$(OUTPUT)/test_kill: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 82e59cdf16e7..4f66d10626d2 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -2,9 +2,9 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
-#define PAGE_SIZE 4096
+#include "../kselftest.h"
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define PAGE_SIZE 4096
 
 #define MB(x) (x << 20)
 
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 42be3b925830..076cf4325f78 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -52,6 +52,12 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 		size = sizeof(struct __clone_args);
 
 	switch (test_mode) {
+	case CLONE3_ARGS_NO_TEST:
+		/*
+		 * Uses default 'flags' and 'SIGCHLD'
+		 * assignment.
+		 */
+		break;
 	case CLONE3_ARGS_ALL_0:
 		args.flags = 0;
 		args.exit_signal = 0;
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index aa7d13d91963..749239930ca8 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -50,10 +50,6 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 	return syscall(__NR_close_range, fd, max_fd, flags);
 }
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 TEST(core_close_range)
 {
 	int i, ret;
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index 98166fa3eb91..34fb89b0c61f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Kprobe dynamic event - adding and removing
+# description: Kprobe profile
 # requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index af7f9c7d59bc..06256c96df12 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -26,7 +26,6 @@
 #include "../kselftest.h"
 
 #define TEST_SCANCODES	10
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 8d50483fe204..f1180987492c 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -48,6 +48,10 @@
 #include <stdarg.h>
 #include <stdio.h>
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
 /* define kselftest exit codes */
 #define KSFT_PASS  0
 #define KSFT_FAIL  1
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ae0f0f33b2a6..471eaa7b3a3f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -671,7 +671,9 @@
 #define EXPECT_STRNE(expected, seen) \
 	__EXPECT_STR(expected, seen, !=, 0)
 
+#ifndef ARRAY_SIZE
 #define ARRAY_SIZE(a)	(sizeof(a) / sizeof(a[0]))
+#endif
 
 /* Support an optional handler after and ASSERT_* or EXPECT_*.  The approach is
  * not thread-safe, but it should be fine in most sane test scenarios.
@@ -969,7 +971,7 @@ void __run_test(struct __fixture_metadata *f,
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
-	t->step = 0;
+	t->step = 1;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 20e2a9286d71..183b7e8e1b95 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -17,10 +17,6 @@
 
 #include "../kselftest_harness.h"
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 /*
  * TEST_F_FORK() is useful when a test drop privileges but the corresponding
  * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index fe7ee2b0f29c..a40add31a2e3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -141,7 +141,7 @@ endif
 # Selftest makefiles can override those targets by setting
 # OVERRIDE_TARGETS = 1.
 ifeq ($(OVERRIDE_TARGETS),)
-LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
+LOCAL_HDRS += $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
 	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index 584dc6bc3b06..d2917054fe3a 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	create_and_enter_userns();
@@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	orig_mnt_flags = read_mnt_flags(orig_path);
diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 860198f83a53..50ed5d475dd1 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -191,7 +191,7 @@ static bool is_shared_mount(const char *path)
 #define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
 #define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
 
-static int move_mount_set_group_supported(void)
+static bool move_mount_set_group_supported(void)
 {
 	int ret;
 
@@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
 	umount2("/tmp", MNT_DETACH);
 
-	return ret < 0 ? false : true;
+	return ret >= 0;
 }
 
 FIXTURE(move_mount_set_group) {
@@ -232,7 +232,7 @@ FIXTURE(move_mount_set_group) {
 
 FIXTURE_SETUP(move_mount_set_group)
 {
-	int ret;
+	bool ret;
 
 	ASSERT_EQ(prepare_unpriv_mountns(), 0);
 
@@ -254,7 +254,7 @@ FIXTURE_SETUP(move_mount_set_group)
 
 FIXTURE_TEARDOWN(move_mount_set_group)
 {
-	int ret;
+	bool ret;
 
 	ret = move_mount_set_group_supported();
 	ASSERT_GE(ret, 0);
@@ -348,7 +348,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
 		.shared = false,
 	};
 	pid_t pid;
-	int ret;
+	bool ret;
 
 	ret = move_mount_set_group_supported();
 	ASSERT_GE(ret, 0);
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index cf37ce86b0fd..221525ccbe1d 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -57,10 +57,11 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 #define DPORT 8000
 #define SPORT 1500
 #define PAYLOAD_LEN 100
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define NUM_PACKETS 4
 #define START_SEQ 100
 #define START_ACK 100
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 3d7dde2c321b..cc10c10c5ed9 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -41,7 +41,6 @@
 
 #define pr_err(fmt, ...)	printk(fmt ": %m", ##__VA_ARGS__)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
 #define IPV4_STR_SZ	16	/* xxx.xxx.xxx.xxx is longest + \0 */
diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
index b5277106df1f..072d709c96b4 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -24,9 +24,7 @@
 #include <sys/resource.h>
 #include <unistd.h>
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-#endif
+#include "../kselftest.h"
 
 struct test_params {
 	int recv_family;
diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index e4613ce4ed69..9eb42570294d 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -18,7 +18,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#include "../kselftest.h"
 
 struct options {
 	int so_timestamp;
diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index afca1ead677f..db1aeb8c5d1e 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -7,6 +7,8 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 
+#include "../kselftest.h"
+
 struct socket_testcase {
 	int	domain;
 	int	type;
@@ -31,7 +33,6 @@ static struct socket_testcase tests[] = {
 	{ AF_INET, SOCK_STREAM, IPPROTO_UDP, -EPROTONOSUPPORT, 1  },
 };
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define ERR_STRING_SZ	64
 
 static int run_tests(void)
diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.c b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
index 9c55ec44fc43..c1cb0c75156a 100644
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.c
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
@@ -26,6 +26,8 @@
 #include <fcntl.h>
 #include <time.h>
 
+#include "../kselftest.h"
+
 #ifndef TCP_FASTOPEN_KEY
 #define TCP_FASTOPEN_KEY 33
 #endif
@@ -34,10 +36,6 @@
 #define PROC_FASTOPEN_KEY "/proc/sys/net/ipv4/tcp_fastopen_key"
 #define KEY_LENGTH 16
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-#endif
-
 static bool do_ipv6;
 static bool do_sockopt;
 static bool do_rotate;
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index eb3f6db36d36..b953a52ff706 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -9,10 +9,9 @@
 #include <string.h>
 #include <stddef.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..fb440dfca158 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -27,10 +27,9 @@
 #include <signal.h>
 #include <limits.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 __thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 6e5102a7d7c9..5b5c9d558dee 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -18,7 +18,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#define ARRAY_SIZE(a)    (sizeof(a) / sizeof(a[0]))
+#include "../kselftest.h"
 
 unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 {
diff --git a/tools/testing/selftests/sparc64/drivers/adi-test.c b/tools/testing/selftests/sparc64/drivers/adi-test.c
index 95d93c6a88a5..84e5d9fd20b0 100644
--- a/tools/testing/selftests/sparc64/drivers/adi-test.c
+++ b/tools/testing/selftests/sparc64/drivers/adi-test.c
@@ -24,10 +24,6 @@
 #define DEBUG_LEVEL_4_BIT	(0x0008)
 #define DEBUG_TIMING_BIT	(0x1000)
 
-#ifndef ARRAY_SIZE
-# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 /* bit mask of enabled bits to print */
 #define DEBUG 0x0001
 
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index f2519154208a..1833ca97eb24 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -24,8 +24,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 static int child_ns, parent_ns;
 
 static int switch_ns(int fd)
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 52b6a1185f52..387220791a05 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -22,8 +22,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 struct test_clock {
 	clockid_t id;
 	char *name;
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 4da09dbf83ba..54da4b088f4c 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -79,7 +79,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 022d3ffe3fbf..e6756d9c60a7 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 0624d1bd71b5..7c0b0617b9f8 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -20,7 +20,6 @@
 #define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 
 struct config {
diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 622a85848f61..92f3be3dd8e5 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -13,6 +13,8 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+#include "../kselftest.h"
+
 /* Define some kernel-like types */
 #define  u8 __u8
 #define u16 __u16
@@ -175,7 +177,6 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
 }
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 #define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
 #define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
 #define ALIGN_PTR_UP(p, ptr_align_to)	\
diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
index 83acdff26a13..da6ec3b53ea8 100644
--- a/tools/testing/selftests/vm/va_128TBswitch.c
+++ b/tools/testing/selftests/vm/va_128TBswitch.c
@@ -9,7 +9,7 @@
 #include <sys/mman.h>
 #include <string.h>
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#include "../kselftest.h"
 
 #ifdef __powerpc64__
 #define PAGE_SIZE	(64 << 10)

--------------07F15015FD03AE844E58D685--
