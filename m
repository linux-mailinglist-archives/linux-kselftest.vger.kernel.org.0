Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7575A400626
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Sep 2021 21:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhICTwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Sep 2021 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbhICTwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Sep 2021 15:52:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72575C061757
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Sep 2021 12:51:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y18so104937ioc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Sep 2021 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=T4M41o7R+NPHXHtGvgcTjKHXooQ85i1IRNZYaa19YyU=;
        b=fP2Q5Z9q5+MaBs8o4Uwnp2O+qFhF+fi4FZ1D4dX4A081zPvW1FIQAOFC1fsuWOViQ6
         W/ge91mqjYcOcLlFvOKJBvadQw1HDjOsMnz3kXhgtmhklj6BoLUP2H/jT/6tD91aD8C7
         /hD78UfmAvBFWbYGzxYhEj7epaRgo42OntOBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=T4M41o7R+NPHXHtGvgcTjKHXooQ85i1IRNZYaa19YyU=;
        b=AHhl9gkG+qh9uzdkU0Z80y6yCvbHPLS3EkoiMS8atmHarW5eK4Z7r2A8xcse5tBNi8
         kVP5Ck2qZUOff+dhNKx/5wVh8jjHrP8kufteiEFZiRZBDbWR23Xmt8n2rfOFzg/VrDIK
         S0lyMHmEcXgrRdpxNUjH3pmOzfngNSpwAd4z36lTrSDtnu4qjdSuUt6AJ7CZKZdPCvOW
         250WiANbmo9adGl9PKcxoH7rXST8WKesk3p6w9mwkcTO5jruTv28VsdJdv/z9TmLpgEg
         badDr+MWx2hD3XskmoAb9JKKGpQ0mxUxNetgXWJc7GReJ8gBkx2QNknP2uH1cqSPtgnw
         FBxg==
X-Gm-Message-State: AOAM530AUSF3XURERTawQNB5VrFc8W9LfHN4yPfp2UiQQ6s+BC2L73yE
        N+UoWzrD3QUTEf8zlvicGty+x0MhCeapGA==
X-Google-Smtp-Source: ABdhPJwq1VJkG6OskkVR1lXqa4pDggBHxuQbNv7A99TsTjGtgwzLosHmCx9+pVUdcd7IojvrdvJ6Nw==
X-Received: by 2002:a02:5286:: with SMTP id d128mr592035jab.147.1630698669645;
        Fri, 03 Sep 2021 12:51:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k21sm121554ioh.38.2021.09.03.12.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 12:51:09 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.15-rc1
Message-ID: <81223355-a515-b5c7-ed54-bb65482aec9f@linuxfoundation.org>
Date:   Fri, 3 Sep 2021 13:51:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------95FE26A3C2B138AEAEE2F5BC"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------95FE26A3C2B138AEAEE2F5BC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.15-rc1.

This Kselftest update for Linux 5.15-rc1 consists of fixes to build
and test failures.

-- openat2 test failure for O_LARGEFILE flag on ARM64
-- x86 test build failures related to glibc 2.34 adding
    support for variable sized MINSIGSTKSZ and SIGSTKSZ
-- removing obsolete configs in sync and cpufreq config files
-- minor spelling and duplicate header include cleanups

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

   Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.15-rc1

for you to fetch changes up to 67d6d80d90fb27b3cc7659f464fa3b87fd67bc14:

   selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST (2021-08-31 11:00:02 -0600)

----------------------------------------------------------------
linux-kselftest-next-5.15-rc1

This Kselftest update for Linux 5.15-rc1 consists of fixes to build
and test failures.

-- openat2 test failure for O_LARGEFILE flag on ARM64
-- x86 test build failures related to glibc 2.34 adding
    support for variable sized MINSIGSTKSZ and SIGSTKSZ
-- removing obsolete configs in sync and cpufreq config files
-- minor spelling and duplicate header include cleanups

----------------------------------------------------------------
Baolin Wang (1):
       selftests: openat2: Fix testing failure for O_LARGEFILE flag

Changcheng Deng (1):
       kselftest:sched: remove duplicate include in cs_prctl_test.c

Colin Ian King (1):
       selftests: safesetid: Fix spelling mistake "cant" -> "can't"

Jun Miao (1):
       selftests/x86: Fix error: variably modified 'altstack_data' at file scope

Li Zhijian (2):
       selftests/sync: Remove the deprecated config SYNC
       selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST

  tools/testing/selftests/cpufreq/config             | 2 +-
  tools/testing/selftests/openat2/openat2_test.c     | 4 ++++
  tools/testing/selftests/safesetid/safesetid-test.c | 2 +-
  tools/testing/selftests/sched/cs_prctl_test.c      | 2 --
  tools/testing/selftests/sync/config                | 1 -
  tools/testing/selftests/x86/mov_ss_trap.c          | 4 ++--
  tools/testing/selftests/x86/sigreturn.c            | 7 +++----
  tools/testing/selftests/x86/single_step_syscall.c  | 4 ++--
  tools/testing/selftests/x86/syscall_arg_fault.c    | 7 +++----
  9 files changed, 16 insertions(+), 17 deletions(-)
----------------------------------------------------------------

--------------95FE26A3C2B138AEAEE2F5BC
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.15-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.15-rc1.diff"

diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
index 27ff72ebd0f5..75e900793e8a 100644
--- a/tools/testing/selftests/cpufreq/config
+++ b/tools/testing/selftests/cpufreq/config
@@ -6,7 +6,7 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_PI_LIST=y
+CONFIG_DEBUG_PLIST=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_LOCK_ALLOC=y
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index d7ec1e7da0d0..1bddbe934204 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -22,7 +22,11 @@
  * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
  */
 #undef	O_LARGEFILE
+#ifdef __aarch64__
+#define	O_LARGEFILE 0x20000
+#else
 #define	O_LARGEFILE 0x8000
+#endif
 
 struct open_how_ext {
 	struct open_how inner;
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 0c4d50644c13..4b809c93ba36 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -152,7 +152,7 @@ static void write_policies(void)
 
 	fd = open(add_whitelist_policy_file, O_WRONLY);
 	if (fd < 0)
-		die("cant open add_whitelist_policy file\n");
+		die("can't open add_whitelist_policy file\n");
 	written = write(fd, policy_str, strlen(policy_str));
 	if (written != strlen(policy_str)) {
 		if (written >= 0) {
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 63fe6521c56d..7db9cf822dc7 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -25,8 +25,6 @@
 #include <sys/types.h>
 #include <sched.h>
 #include <sys/prctl.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <unistd.h>
 #include <time.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/sync/config b/tools/testing/selftests/sync/config
index 1ab7e8130db2..47ff5afc3727 100644
--- a/tools/testing/selftests/sync/config
+++ b/tools/testing/selftests/sync/config
@@ -1,4 +1,3 @@
 CONFIG_STAGING=y
 CONFIG_ANDROID=y
-CONFIG_SYNC=y
 CONFIG_SW_SYNC=y
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 6da0ac3f0135..cc3de6ff9fba 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -47,7 +47,6 @@
 unsigned short ss;
 extern unsigned char breakpoint_insn[];
 sigjmp_buf jmpbuf;
-static unsigned char altstack_data[SIGSTKSZ];
 
 static void enable_watchpoint(void)
 {
@@ -250,13 +249,14 @@ int main()
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		printf("[RUN]\tMOV SS; SYSENTER\n");
 		stack_t stack = {
-			.ss_sp = altstack_data,
+			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 			.ss_size = SIGSTKSZ,
 		};
 		if (sigaltstack(&stack, NULL) != 0)
 			err(1, "sigaltstack");
 		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
 		nr = SYS_getpid;
+		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
 			      : [ss] "m" (ss) : "flags", "rcx"
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 57c4f67f16ef..5d7961a5f7f6 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -138,9 +138,6 @@ static unsigned short LDT3(int idx)
 	return (idx << 3) | 7;
 }
 
-/* Our sigaltstack scratch space. */
-static char altstack_data[SIGSTKSZ];
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -771,7 +768,8 @@ int main()
 	setup_ldt();
 
 	stack_t stack = {
-		.ss_sp = altstack_data,
+		/* Our sigaltstack scratch space. */
+		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 		.ss_size = SIGSTKSZ,
 	};
 	if (sigaltstack(&stack, NULL) != 0)
@@ -872,5 +870,6 @@ int main()
 	total_nerrs += test_nonstrict_ss();
 #endif
 
+	free(stack.ss_sp);
 	return total_nerrs ? 1 : 0;
 }
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 120ac741fe44..9a30f443e928 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -57,7 +57,6 @@ static void clearhandler(int sig)
 
 static volatile sig_atomic_t sig_traps, sig_eflags;
 sigjmp_buf jmpbuf;
-static unsigned char altstack_data[SIGSTKSZ];
 
 #ifdef __x86_64__
 # define REG_IP REG_RIP
@@ -210,7 +209,7 @@ int main()
 		unsigned long nr = SYS_getpid;
 		printf("[RUN]\tSet TF and check SYSENTER\n");
 		stack_t stack = {
-			.ss_sp = altstack_data,
+			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 			.ss_size = SIGSTKSZ,
 		};
 		if (sigaltstack(&stack, NULL) != 0)
@@ -219,6 +218,7 @@ int main()
 			   SA_RESETHAND | SA_ONSTACK);
 		sethandler(SIGILL, print_and_longjmp, SA_RESETHAND);
 		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; SYSENTER" : "+a" (nr) :: "flags", "rcx"
 #ifdef __x86_64__
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bff474b5efc6..461fa41a4d02 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -17,9 +17,6 @@
 
 #include "helpers.h"
 
-/* Our sigaltstack scratch space. */
-static unsigned char altstack_data[SIGSTKSZ];
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -104,7 +101,8 @@ static void sigill(int sig, siginfo_t *info, void *ctx_void)
 int main()
 {
 	stack_t stack = {
-		.ss_sp = altstack_data,
+		/* Our sigaltstack scratch space. */
+		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 		.ss_size = SIGSTKSZ,
 	};
 	if (sigaltstack(&stack, NULL) != 0)
@@ -233,5 +231,6 @@ int main()
 	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 #endif
 
+	free(stack.ss_sp);
 	return 0;
 }

--------------95FE26A3C2B138AEAEE2F5BC--
