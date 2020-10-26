Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D42997D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 21:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgJZUUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 16:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbgJZUUg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 16:20:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E062074B;
        Mon, 26 Oct 2020 20:20:34 +0000 (UTC)
Date:   Mon, 26 Oct 2020 16:20:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] selftests/ftrace: Use $FUNCTION_FORK to reference kernel
 fork function
Message-ID: <20201026162032.124c728d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit cad6967ac108 ("fork: introduce kernel_clone()") replaced "_do_fork()"
with "kernel_clone()". The ftrace selftests reference the fork function in
several of the tests. The rename will make the tests break, but if those
names are changed in the tests, they would then break on older kernels. The
same set of tests should pass older kernels if they have previously passed.
Obviously, a new test may not work on older kernels if the test was added
due to a bug or a new feature.

The setup of ftracetest will now create a $FUNCTION_FORK bash variable
that will contain "_do_fork" for older kernels and "kernel_clone" for newer
ones. It figures out the proper name by examining /proc/kallsyms.

Note, available_filter_functions could also be used, but because some tests
should be able to pass without function tracing enabled, it could not be
used.

Fixes: eea11285dab3 ("tracing: switch to kernel_clone()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  2 +-
 .../ftrace/test.d/dynevent/clear_select_events.tc  |  2 +-
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |  2 +-
 .../test.d/ftrace/func-filter-notrace-pid.tc       |  2 +-
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |  2 +-
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  4 ++--
 tools/testing/selftests/ftrace/test.d/functions    |  7 +++++++
 .../ftrace/test.d/kprobe/add_and_remove.tc         |  2 +-
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  2 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  4 ++--
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  4 ++--
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     | 10 +++++-----
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          | 14 +++++++-------
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 12 ++++++------
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |  4 ++--
 .../selftests/ftrace/test.d/kprobe/profile.tc      |  2 +-
 19 files changed, 44 insertions(+), 37 deletions(-)

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
-- 
2.25.4

