Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48362A9BAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 19:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKFSQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgKFSQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 13:16:10 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A57C0613D2
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 10:16:09 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h62so2054065oth.9
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=I6lsiPR7NrwkKREXwF3CoBbsdPuT7veqaaaqNRXVT0k=;
        b=CUWeOvTOvRb1jUxJVJcgYXxVwu8BPnP3jLOaaXpKpe82DbMREcbAGIMGVd2KurVRYd
         iW40DRzORzyf8gRw5t3MvoI+6Zo8q1/IyE/ZowI43NWWMTMIvaHeRd8nU0W38X6djLYK
         hh57th3xti5Z4l2TQguuB34XlQCAC+1k2G8Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=I6lsiPR7NrwkKREXwF3CoBbsdPuT7veqaaaqNRXVT0k=;
        b=dhzlMZkjPMO1GDGKKaHH+0z4ohQ00H5h2DTqq+e88WfXPys60rIchLSHkmctP1uybM
         mO5B0IINdDEuZr4rAryOP0rqbgdAiZjeYn3VA2V1+2F9dP7+reXwJIXnuN6bazlt3hjs
         /S2JV3MK/fQ9fJIjcQGkhoN2hBR/v2cB4ouQci+CQEvAwd+ILyDkj0yCi5mVtM6Biz+K
         6rPB21xde1JPOmw/8cXws979epB9wy78iy3H4M7vvZDyhNbWcmcbB+0vFNOZYGa+VPhR
         vgy1id/oKG3DidBFfDQRXp5EnkBqoQWAYv0NkzwOK81NiJb2HNz7CUfk6umszydFk9em
         HZww==
X-Gm-Message-State: AOAM5327KLeTcnISK4BTKUX9fmPIrwsapk/QZAOAGgVAIukoV3tTwXKx
        G4NKrODZHQaSnkld3JE9VXgonA==
X-Google-Smtp-Source: ABdhPJzqzyWLWAmbDUCk5xHAjn+3VutksRu8dLJjoig+FPwxKSOgsughVRomIeN5IVjFjRl+29iQ8Q==
X-Received: by 2002:a9d:7313:: with SMTP id e19mr1795049otk.97.1604686569026;
        Fri, 06 Nov 2020 10:16:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm467278oof.43.2020.11.06.10.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 10:16:08 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.10-rc3
Message-ID: <cfea14f7-30aa-33ee-308f-36660272735e@linuxfoundation.org>
Date:   Fri, 6 Nov 2020 11:16:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------31E7584300410662DFB92EFC"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------31E7584300410662DFB92EFC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.10-rc3.

This Kselftest fixes update for Linux 5.10-rc3 consists of fixes to
ftrace test and several fixes from Tommi Rantala for several tests.

Please note that these fixes have been in next for a while. I dropped
a minor fix for soon to be removed staging ion driver selftest yesterday
to make the merge easier so it doesn't conflict with the staging pull
request.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.10-rc3

for you to fetch changes up to 7d764b685ee1bc73a9fa2b6cb4d42fa72b943145:

   selftests: binderfs: use SKIP instead of XFAIL (2020-11-05 10:08:15 
-0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.10-rc3

This Kselftest fixes update for Linux 5.10-rc3 consists of fixes to
ftrace test and several fixes from Tommi Rantala for several tests.

----------------------------------------------------------------
Colin Ian King (1):
       selftests/ftrace: check for do_sys_openat2 in user-memory test

Steven Rostedt (VMware) (1):
       selftests/ftrace: Use $FUNCTION_FORK to reference kernel fork 
function

Tommi Rantala (11):
       selftests: filter kselftest headers from command in lib.mk
       selftests: pidfd: fix compilation errors due to wait.h
       selftests/harness: prettify SKIP message whitespace again
       selftests: pidfd: use ksft_test_result_skip() when skipping test
       selftests: pidfd: skip test on kcmp() ENOSYS
       selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
       selftests: pidfd: drop needless linux/kcmp.h inclusion in 
pidfd_setns_test.c
       selftests: proc: fix warning: _GNU_SOURCE redefined
       selftests: core: use SKIP instead of XFAIL in close_range_test.c
       selftests: clone3: use SKIP instead of XFAIL
       selftests: binderfs: use SKIP instead of XFAIL

  .../selftests/clone3/clone3_cap_checkpoint_restore.c       |  2 +-
  tools/testing/selftests/core/close_range_test.c            |  8 ++++----
  .../testing/selftests/filesystems/binderfs/binderfs_test.c |  8 ++++----
  .../selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc  |  2 +-
  .../ftrace/test.d/dynevent/clear_select_events.tc          |  2 +-
  .../ftrace/test.d/dynevent/generic_clear_event.tc          |  2 +-
  .../ftrace/test.d/ftrace/func-filter-notrace-pid.tc        |  2 +-
  .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc      |  2 +-
  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc         |  4 ++--
  tools/testing/selftests/ftrace/test.d/functions            |  7 +++++++
  .../selftests/ftrace/test.d/kprobe/add_and_remove.tc       |  2 +-
  tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc |  2 +-
  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  4 ++--
  .../selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc     |  2 +-
  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc   |  4 ++--
  .../selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc   | 10 +++++-----
  .../selftests/ftrace/test.d/kprobe/kprobe_args_type.tc     |  2 +-
  .../selftests/ftrace/test.d/kprobe/kprobe_args_user.tc     |  4 ++++
  .../selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc        | 14 
+++++++-------
  .../selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc    |  2 +-
.../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 12 ++++++------
  .../selftests/ftrace/test.d/kprobe/kretprobe_args.tc       |  4 ++--
  tools/testing/selftests/ftrace/test.d/kprobe/profile.tc    |  2 +-
  tools/testing/selftests/kselftest_harness.h                |  2 +-
  tools/testing/selftests/lib.mk                             |  2 +-
  tools/testing/selftests/pidfd/config                       |  1 +
  tools/testing/selftests/pidfd/pidfd_getfd_test.c           |  5 ++++-
  tools/testing/selftests/pidfd/pidfd_open_test.c            |  1 -
  tools/testing/selftests/pidfd/pidfd_poll_test.c            |  1 -
  tools/testing/selftests/pidfd/pidfd_setns_test.c           |  1 -
  tools/testing/selftests/pidfd/pidfd_test.c                 |  2 +-
  tools/testing/selftests/proc/proc-loadavg-001.c            |  1 -
  tools/testing/selftests/proc/proc-self-syscall.c           |  1 -
  tools/testing/selftests/proc/proc-uptime-002.c             |  1 -

----------------------------------------------------------------

--------------31E7584300410662DFB92EFC
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.10-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.10-rc3.diff"

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 55bd387ce7ec..52d3f0364bda 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -145,7 +145,7 @@ TEST(clone3_cap_checkpoint_restore)
 	test_clone3_supported();
 
 	EXPECT_EQ(getuid(), 0)
-		XFAIL(return, "Skipping all tests as non-root\n");
+		SKIP(return, "Skipping all tests as non-root");
 
 	memset(&set_tid, 0, sizeof(set_tid));
 
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c99b98b0d461..575b391ddc78 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -44,7 +44,7 @@ TEST(close_range)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -52,7 +52,7 @@ TEST(close_range)
 
 	EXPECT_EQ(-1, sys_close_range(open_fds[0], open_fds[100], -1)) {
 		if (errno == ENOSYS)
-			XFAIL(return, "close_range() syscall not supported");
+			SKIP(return, "close_range() syscall not supported");
 	}
 
 	EXPECT_EQ(0, sys_close_range(open_fds[0], open_fds[50], 0));
@@ -108,7 +108,7 @@ TEST(close_range_unshare)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -197,7 +197,7 @@ TEST(close_range_unshare_capped)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 1d27f52c61e6..477cbb042f5b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -74,7 +74,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
 	EXPECT_EQ(ret, 0) {
 		if (errno == ENODEV)
-			XFAIL(goto out, "binderfs missing");
+			SKIP(goto out, "binderfs missing");
 		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
 		goto rmdir;
 	}
@@ -475,10 +475,10 @@ TEST(binderfs_stress)
 TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
-		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
+		SKIP(return, "Tests are not run as root. Skipping privileged tests");
 
 	if (__do_binderfs_test(_metadata))
-		XFAIL(return, "The Android binderfs filesystem is not available");
+		SKIP(return, "The Android binderfs filesystem is not available");
 }
 
 TEST(binderfs_test_unprivileged)
@@ -511,7 +511,7 @@ TEST(binderfs_test_unprivileged)
 	ret = wait_for_pid(pid);
 	if (ret) {
 		if (ret == 2)
-			XFAIL(return, "The Android binderfs filesystem is not available");
+			SKIP(return, "The Android binderfs filesystem is not available");
 		ASSERT_EQ(ret, 0) {
 			TH_LOG("wait_for_pid() failed");
 		}
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index 3bcd4c3624ee..b4da41d126d5 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=kernel_clone
+PLACE=$FUNCTION_FORK
 
 echo "p:myevent1 $PLACE" >> dynamic_events
 echo "r:myevent2 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
index 438961971b7e..3a0e2885fff5 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=kernel_clone
+PLACE=$FUNCTION_FORK
 
 setup_events() {
 echo "p:myevent1 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
index a8603bd23e0d..d3e138e8377f 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=kernel_clone
+PLACE=$FUNCTION_FORK
 
 setup_events() {
 echo "p:myevent1 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index acb17ce543d2..80541964b927 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -39,7 +39,7 @@ do_test() {
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
-    echo *do_fork >> set_ftrace_filter
+    echo $FUNCTION_FORK >> set_ftrace_filter
 
     echo $PID > set_ftrace_notrace_pid
     echo function > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 9f0a9687c773..2f7211254529 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -39,7 +39,7 @@ do_test() {
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
-    echo *do_fork >> set_ftrace_filter
+    echo $FUNCTION_FORK >> set_ftrace_filter
 
     echo $PID > set_ftrace_pid
     echo function > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 98305d76bd04..191d116b7883 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -4,9 +4,9 @@
 # requires: set_ftrace_filter
 # flags: instance
 
-echo kernel_clone:stacktrace >> set_ftrace_filter
+echo $FUNCTION_FORK:stacktrace >> set_ftrace_filter
 
-grep -q "kernel_clone:stacktrace:unlimited" set_ftrace_filter
+grep -q "$FUNCTION_FORK:stacktrace:unlimited" set_ftrace_filter
 
 (echo "forked"; sleep 1)
 
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index c5dec55b7d95..a6fac927ee82 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -133,6 +133,13 @@ yield() {
     ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
+# The fork function in the kernel was renamed from "_do_fork" to
+# "kernel_fork". As older tests should still work with older kernels
+# as well as newer kernels, check which version of fork is used on this
+# kernel so that the tests can use the fork function for the running kernel.
+FUNCTION_FORK=`(if grep '\bkernel_clone\b' /proc/kallsyms > /dev/null; then
+                echo kernel_clone; else echo '_do_fork'; fi)`
+
 # Since probe event command may include backslash, explicitly use printf "%s"
 # to NOT interpret it.
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
index 9737cd0578a7..2428a3ed78c9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event - adding and removing
 # requires: kprobe_events
 
-echo p:myevent kernel_clone > kprobe_events
+echo p:myevent $FUNCTION_FORK > kprobe_events
 grep myevent kprobe_events
 test -d events/kprobes/myevent
 echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
index f9a40af76888..010a8b1d6c1d 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event - busy event check
 # requires: kprobe_events
 
-echo p:myevent kernel_clone > kprobe_events
+echo p:myevent $FUNCTION_FORK > kprobe_events
 test -d events/kprobes/myevent
 echo 1 > events/kprobes/myevent/enable
 echo > kprobe_events && exit_fail # this must fail
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index eb543d3cfe5f..a96a1dc7014f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -3,13 +3,13 @@
 # description: Kprobe dynamic event with arguments
 # requires: kprobe_events
 
-echo 'p:testprobe kernel_clone $stack $stack0 +0($stack)' > kprobe_events
+echo "p:testprobe $FUNCTION_FORK \$stack \$stack0 +0(\$stack)" > kprobe_events
 grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
 test -d events/kprobes/testprobe
 
 echo 1 > events/kprobes/testprobe/enable
 ( echo "forked")
-grep testprobe trace | grep 'kernel_clone' | \
+grep testprobe trace | grep "$FUNCTION_FORK" | \
   grep -q 'arg1=0x[[:xdigit:]]* arg2=0x[[:xdigit:]]* arg3=0x[[:xdigit:]]*$'
 
 echo 0 > events/kprobes/testprobe/enable
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
index 4e5b63be51c9..a053ee2e7d77 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -5,7 +5,7 @@
 
 grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
 
-echo 'p:testprobe kernel_clone comm=$comm ' > kprobe_events
+echo "p:testprobe $FUNCTION_FORK comm=\$comm " > kprobe_events
 grep testprobe kprobe_events | grep -q 'comm=$comm'
 test -d events/kprobes/testprobe
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a1d70588ab21..84285a6f60b0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -30,13 +30,13 @@ esac
 : "Test get argument (1)"
 echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-echo "p:test kernel_clone" >> kprobe_events
+echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
 echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-echo "p:test kernel_clone" >> kprobe_events
+echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
index bd25dd0ba0d0..717130ed4feb 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -14,12 +14,12 @@ elif ! grep "$SYMBOL\$" /proc/kallsyms; then
 fi
 
 : "Test get basic types symbol argument"
-echo "p:testprobe_u kernel_clone arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
-echo "p:testprobe_s kernel_clone arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
+echo "p:testprobe_u $FUNCTION_FORK arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
+echo "p:testprobe_s $FUNCTION_FORK arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
 if grep -q "x8/16/32/64" README; then
-  echo "p:testprobe_x kernel_clone arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
+  echo "p:testprobe_x $FUNCTION_FORK arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
 fi
-echo "p:testprobe_bf kernel_clone arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
+echo "p:testprobe_bf $FUNCTION_FORK arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
 echo 1 > events/kprobes/enable
 (echo "forked")
 echo 0 > events/kprobes/enable
@@ -27,7 +27,7 @@ grep "testprobe_[usx]:.* arg1=.* arg2=.* arg3=.* arg4=.*" trace
 grep "testprobe_bf:.* arg1=.*" trace
 
 : "Test get string symbol argument"
-echo "p:testprobe_str kernel_clone arg1=@linux_proc_banner:string" > kprobe_events
+echo "p:testprobe_str $FUNCTION_FORK arg1=@linux_proc_banner:string" > kprobe_events
 echo 1 > events/kprobes/enable
 (echo "forked")
 echo 0 > events/kprobes/enable
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 91fcce1c241c..25b7708eb559 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events "x8/16/32/64":README
 
 gen_event() { # Bitsize
-  echo "p:testprobe kernel_clone \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
+  echo "p:testprobe $FUNCTION_FORK \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
 }
 
 check_types() { # s-type u-type x-type bf-type width
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index a30a9c07290d..d25d01a19778 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -9,12 +9,16 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 :;: "user-memory access syntax and ustring working on user memory";:
 echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
 	> kprobe_events
+echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
+	>> kprobe_events
 
 grep myevent kprobe_events | \
 	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
 echo 1 > events/kprobes/myevent/enable
+echo 1 > events/kprobes/myevent2/enable
 echo > /dev/null
 echo 0 > events/kprobes/myevent/enable
+echo 0 > events/kprobes/myevent2/enable
 
 grep myevent trace | grep -q 'path="/dev/null" path2="/dev/null"'
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 0d179094191f..5556292601a4 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -5,29 +5,29 @@
 
 # prepare
 echo nop > current_tracer
-echo kernel_clone > set_ftrace_filter
-echo 'p:testprobe kernel_clone' > kprobe_events
+echo $FUNCTION_FORK > set_ftrace_filter
+echo "p:testprobe $FUNCTION_FORK" > kprobe_events
 
 # kprobe on / ftrace off
 echo 1 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep 'kernel_clone <-' trace
+! grep "$FUNCTION_FORK <-" trace
 
 # kprobe on / ftrace on
 echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep 'kernel_clone <-' trace
+grep "$FUNCTION_FORK <-" trace
 
 # kprobe off / ftrace on
 echo 0 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 ! grep testprobe trace
-grep 'kernel_clone <-' trace
+grep "$FUNCTION_FORK <-" trace
 
 # kprobe on / ftrace on
 echo 1 > events/kprobes/testprobe/enable
@@ -35,11 +35,11 @@ echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep 'kernel_clone <-' trace
+grep "$FUNCTION_FORK <-" trace
 
 # kprobe on / ftrace off
 echo nop > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep 'kernel_clone <-' trace
+! grep "$FUNCTION_FORK <-" trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index 45d90b6c763d..f0d5b7777ed7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events "Create/append/":README
 
 # Choose 2 symbols for target
-SYM1=kernel_clone
+SYM1=$FUNCTION_FORK
 SYM2=do_exit
 EVENT_NAME=kprobes/testevent
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 1b5550ef8a9b..fa928b431555 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -86,15 +86,15 @@ esac
 
 # multiprobe errors
 if grep -q "Create/append/" README && grep -q "imm-value" README; then
-echo 'p:kprobes/testevent kernel_clone' > kprobe_events
+echo "p:kprobes/testevent $FUNCTION_FORK" > kprobe_events
 check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
 
 # Explicitly use printf "%s" to not interpret \1
-printf "%s" 'p:kprobes/testevent kernel_clone abcd=\1' > kprobe_events
-check_error 'p:kprobes/testevent kernel_clone ^bcd=\1'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent kernel_clone ^abcd=\1:u8'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent kernel_clone ^abcd=\"foo"'	# DIFF_ARG_TYPE
-check_error '^p:kprobes/testevent kernel_clone abcd=\1'	# SAME_PROBE
+printf "%s" "p:kprobes/testevent $FUNCTION_FORK abcd=\\1" > kprobe_events
+check_error "p:kprobes/testevent $FUNCTION_FORK ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "p:kprobes/testevent $FUNCTION_FORK ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "p:kprobes/testevent $FUNCTION_FORK ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^p:kprobes/testevent $FUNCTION_FORK abcd=\\1"	# SAME_PROBE
 fi
 
 # %return suffix errors
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 7ae492c204a4..197cc2afd404 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -4,14 +4,14 @@
 # requires: kprobe_events
 
 # Add new kretprobe event
-echo 'r:testprobe2 kernel_clone $retval' > kprobe_events
+echo "r:testprobe2 $FUNCTION_FORK \$retval" > kprobe_events
 grep testprobe2 kprobe_events | grep -q 'arg1=\$retval'
 test -d events/kprobes/testprobe2
 
 echo 1 > events/kprobes/testprobe2/enable
 ( echo "forked")
 
-cat trace | grep testprobe2 | grep -q '<- kernel_clone'
+cat trace | grep testprobe2 | grep -q "<- $FUNCTION_FORK"
 
 echo 0 > events/kprobes/testprobe2/enable
 echo '-:testprobe2' >> kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index c4093fc1a773..98166fa3eb91 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
-echo p:myevent kernel_clone > kprobe_events
+echo "p:myevent $FUNCTION_FORK" > kprobe_events
 grep -q 'myevent[[:space:]]*0[[:space:]]*0$' kprobe_profile
 echo 1 > events/kprobes/myevent/enable
 ( echo "forked" )
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f19804df244c..d2cba10acc6d 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -126,7 +126,7 @@
 	snprintf(_metadata->results->reason, \
 		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "#      SKIP     %s\n", \
+		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
 	_metadata->passed = 1; \
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 30848ca36555..a5ce26d548e4 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -136,7 +136,7 @@ endif
 ifeq ($(OVERRIDE_TARGETS),)
 LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
-	$(LINK.c) $^ $(LDLIBS) -o $@
+	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(COMPILE.S) $^ -o $@
diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/pidfd/config
index bb11de90c0c9..f6f2965e17af 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -4,3 +4,4 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_CGROUPS=y
+CONFIG_CHECKPOINT_RESTORE=y
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 7758c98be015..0930e2411dfb 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -204,7 +204,10 @@ TEST_F(child, fetch_fd)
 	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
 	ASSERT_GE(fd, 0);
 
-	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));
+	ret = sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd);
+	if (ret < 0 && errno == ENOSYS)
+		SKIP(return, "kcmp() syscall not supported");
+	EXPECT_EQ(ret, 0);
 
 	ret = fcntl(fd, F_GETFD);
 	ASSERT_GE(ret, 0);
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index b9fe75fc3e51..8a59438ccc78 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 4b115444dfe9..610811275357 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 1f085b922c6e..6e2f2cd400ca 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,7 +16,6 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <linux/kcmp.h>
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index c585aaa2acd8..529eb700ac26 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -330,7 +330,7 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
 		ksft_exit_fail_msg("%s test: Failed to recycle pid %d\n",
 				   test_name, PID_RECYCLE);
 	case PIDFD_SKIP:
-		ksft_print_msg("%s test: Skipping test\n", test_name);
+		ksft_test_result_skip("%s test: Skipping test\n", test_name);
 		ret = 0;
 		break;
 	case PIDFD_XFAIL:
diff --git a/tools/testing/selftests/proc/proc-loadavg-001.c b/tools/testing/selftests/proc/proc-loadavg-001.c
index 471e2aa28077..fb4fe9188806 100644
--- a/tools/testing/selftests/proc/proc-loadavg-001.c
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -14,7 +14,6 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 /* Test that /proc/loadavg correctly reports last pid in pid namespace. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 9f6d000c0245..8511dcfe67c7 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -13,7 +13,6 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
index 30e2b7849089..e7ceabed7f51 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -15,7 +15,6 @@
  */
 // Test that values in /proc/uptime increment monotonically
 // while shifting across CPUs.
-#define _GNU_SOURCE
 #undef NDEBUG
 #include <assert.h>
 #include <unistd.h>

--------------31E7584300410662DFB92EFC--
