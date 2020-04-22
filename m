Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946621B4B1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDVQ5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgDVQ5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 12:57:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0395C03C1AA
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 09:57:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i3so3111112ioo.13
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=MrTLB042d8ow8cXeAt38M16cngvyRktM3oRMp1lzHpY=;
        b=IVHSLCOkvWTBPnq2OLacMnkRmhRZKTnMtoYkAU9OzJ5OnSnUq/etB6/zhQXdYd6I/w
         GhZ5KNeHMHfBvokJua/SZVRehakp1n+FcUx6mXiXb829lMRRRQSkdaFVSCW4TzmPMYVX
         I3t7jwzfAfD7pKSPwOiUobJbxZU71A2o4XPGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=MrTLB042d8ow8cXeAt38M16cngvyRktM3oRMp1lzHpY=;
        b=EazCwRMFrWCoIeal/AeLhPyZzwv29SrRRzALoxsfXQRUBQSmbzYJDmqaS7hf5u7w01
         raGPcez77Rh/pr1ef98jkQCTHcwVCY+aYOniRyOqDIKggGQ9TEvQq3YiJbmYdKfZzvmr
         S0PJ56v5gDS7yHue8Tm8RbTX/6DvtpLBt7Kw/GoMb3SpfVqmbYiqgBRRRf2TvAklH8AZ
         4HuEnIVpG9Tvde57uqu742EbY+Pe2MpapN3x6dEgz5jTRlOdrqzRQDp+M3g/ujyUMLn/
         jmltv/7R0mnuuV5jkhVi+t9c3i3xKIgitbWDAV6iJPROPdjWZwKcbFzRechAK4DIVqov
         saBw==
X-Gm-Message-State: AGi0PuYyqmFmLmrjoRsOKHunvVFUoScNd9EzYggiNFtrIwZnMnq2W0hC
        roJqpS96zMkaZZSAbBMqiPGhRg==
X-Google-Smtp-Source: APiQypKcQE0Pv0sf0RsJOPcH3h8muNJdDT7xF2ZZfMQPqBb/GeXyV2Xjy2xa1INywnFU0M1GNmSoTQ==
X-Received: by 2002:a02:415:: with SMTP id 21mr26748637jab.126.1587574652803;
        Wed, 22 Apr 2020 09:57:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k18sm2218329ili.77.2020.04.22.09.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:57:32 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.7-rc3
Message-ID: <853c91e8-83ba-3d37-7601-803485dbc8ed@linuxfoundation.org>
Date:   Wed, 22 Apr 2020 10:57:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------49CF7118CB8C27F8EA3839BE"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------49CF7118CB8C27F8EA3839BE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.7-rc3.

This kselftest update for Linux 5.7-rc3 consists of fixes to runner
scripts and individual test run-time bugs. Includes fixes to tpm2
and memfd test run-time regressions.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.7-rc3

for you to fetch changes up to b87080eab4c1377706c113fc9c0157f19ea8fed1:

   selftests/ipc: Fix test failure seen after initial test run 
(2020-04-14 10:24:28 -0600)

----------------------------------------------------------------
linux-kselftest-5.7-rc3

This kselftest update for Linux 5.7-rc3 consists of fixes to runner
scripts and individual test run-time bugs. Includes fixes to tpm2
and memfd test run-time regressions.

----------------------------------------------------------------
Andrea Righi (1):
       kselftest/runner: allow to properly deliver signals to tests

Colin Ian King (1):
       selftests/harness: fix spelling mistake "SIGARLM" -> "SIGALRM"

Jarkko Sakkinen (1):
       Revert "Kernel selftests: tpm2: check for tpm support"

Sandipan Das (2):
       selftests: vm: Do not override definition of ARCH
       selftests: vm: Fix 64-bit test builds for powerpc64le

Shuah Khan (1):
       selftests: Fix memfd test run-time regression

Thadeu Lima de Souza Cascardo (1):
       selftests/seccomp: allow clock_nanosleep instead of nanosleep

Tyler Hicks (1):
       selftests/ipc: Fix test failure seen after initial test run

Xiao Yang (1):
       selftests/ftrace: Add CONFIG_SAMPLE_FTRACE_DIRECT=m kconfig

  tools/testing/selftests/ftrace/config         |  1 +
  tools/testing/selftests/ipc/msgque.c          |  2 +-
  tools/testing/selftests/kselftest/runner.sh   |  2 +-
  tools/testing/selftests/kselftest_harness.h   |  6 +++---
  tools/testing/selftests/memfd/Makefile        |  3 ++-
  tools/testing/selftests/seccomp/seccomp_bpf.c | 14 ++++++++------
  tools/testing/selftests/tpm2/test_smoke.sh    | 13 ++-----------
  tools/testing/selftests/tpm2/test_space.sh    |  9 +--------
  tools/testing/selftests/vm/Makefile           |  4 ++--
  tools/testing/selftests/vm/run_vmtests        |  2 +-
  10 files changed, 22 insertions(+), 34 deletions(-)

----------------------------------------------------------------

--------------49CF7118CB8C27F8EA3839BE
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.7-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.7-rc3.diff"

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index c2c8de4fafff..e59d985eeff0 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -11,5 +11,6 @@ CONFIG_PREEMPTIRQ_DELAY_TEST=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_SAMPLES=y
+CONFIG_SAMPLE_FTRACE_DIRECT=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_KALLSYMS_ALL=y
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 4c156aeab6b8..5ec4d9e18806 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -137,7 +137,7 @@ int dump_queue(struct msgque_data *msgque)
 	for (kern_id = 0; kern_id < 256; kern_id++) {
 		ret = msgctl(kern_id, MSG_STAT, &ds);
 		if (ret < 0) {
-			if (errno == -EINVAL)
+			if (errno == EINVAL)
 				continue;
 			printf("Failed to get stats for IPC queue with id %d\n",
 					kern_id);
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e84d901f8567..676b3a8b114d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,7 +33,7 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
 	else
 		"$1"
 	fi
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2902f6a78f8a..2bb8c81fc0b4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -705,7 +705,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	/* Sanity check handler execution environment. */
 	if (!t) {
 		fprintf(TH_LOG_STREAM,
-			"no active test in SIGARLM handler!?\n");
+			"no active test in SIGALRM handler!?\n");
 		abort();
 	}
 	if (sig != SIGALRM || sig != info->si_signo) {
@@ -731,7 +731,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to install SIGARLM handler\n",
+			"%s: unable to install SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -743,7 +743,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to uninstall SIGARLM handler\n",
+			"%s: unable to uninstall SIGALRM handler\n",
 			t->name);
 		return;
 	}
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 0a15f9e23431..187b14cad00c 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,8 +4,9 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
+TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
+TEST_GEN_FILES := fuse_test fuse_mnt
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 89fb3e0b552e..c0aa46ce14f6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2803,12 +2803,13 @@ TEST(syscall_restart)
 			 offsetof(struct seccomp_data, nr)),
 
 #ifdef __NR_sigreturn
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 6, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 7, 0),
 #endif
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 5, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 4, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 3, 0),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_nanosleep, 4, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 6, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 5, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 4, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_nanosleep, 5, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_clock_nanosleep, 4, 0),
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_restart_syscall, 4, 0),
 
 		/* Allow __NR_write for easy logging. */
@@ -2895,7 +2896,8 @@ TEST(syscall_restart)
 	ASSERT_EQ(PTRACE_EVENT_SECCOMP, (status >> 16));
 	ASSERT_EQ(0, ptrace(PTRACE_GETEVENTMSG, child_pid, NULL, &msg));
 	ASSERT_EQ(0x100, msg);
-	EXPECT_EQ(__NR_nanosleep, get_syscall(_metadata, child_pid));
+	ret = get_syscall(_metadata, child_pid);
+	EXPECT_TRUE(ret == __NR_nanosleep || ret == __NR_clock_nanosleep);
 
 	/* Might as well check siginfo for sanity while we're here. */
 	ASSERT_EQ(0, ptrace(PTRACE_GETSIGINFO, child_pid, NULL, &info));
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index b630c7b5950a..8155c2ea7ccb 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,17 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-self.flags = flags
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-
-if [ -f /dev/tpm0 ] ; then
-	python -m unittest -v tpm2_tests.SmokeTest
-	python -m unittest -v tpm2_tests.AsyncTest
-else
-	exit $ksft_skip
-fi
+python -m unittest -v tpm2_tests.SmokeTest
+python -m unittest -v tpm2_tests.AsyncTest
 
 CLEAR_CMD=$(which tpm2_clear)
 if [ -n $CLEAR_CMD ]; then
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 180b469c53b4..a6f5e346635e 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,11 +1,4 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if [ -f /dev/tpmrm0 ] ; then
-	python -m unittest -v tpm2_tests.SpaceTest
-else
-	exit $ksft_skip
-fi
+python -m unittest -v tpm2_tests.SpaceTest
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d31db052dff6..6998877f707e 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
+MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
@@ -20,7 +20,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
+ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 665009ebfba4..76ca5e7a3951 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -59,7 +59,7 @@ else
 fi
 
 #filter 64bit architectures
-ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64"
+ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
 if [ -z $ARCH ]; then
   ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
 fi

--------------49CF7118CB8C27F8EA3839BE--
