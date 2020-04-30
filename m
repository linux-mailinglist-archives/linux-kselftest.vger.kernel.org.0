Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25541C0440
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Apr 2020 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgD3R7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Apr 2020 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbgD3R7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Apr 2020 13:59:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7DC035495
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 10:59:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c2so2434438iow.7
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=HTBcgaOkvp3nmkXSpwi/Bpi9Dl5+hFIgSUG3YCojW2s=;
        b=bQDrrSnwvhMIhuCeSiTfa+xzMxI6s1T60QjfDaKY66u568O3ST9RHlCujIYLGOwqf6
         ju9v/xUng4U4yFrthGuMFVYie0Z4KfL/arWx/bmXGMp7TFfMQPVSSzirg85Tbjd3G5JR
         dTu7UIbVV58DxCcAQOnCTfiaBR4kWDDr9dOvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=HTBcgaOkvp3nmkXSpwi/Bpi9Dl5+hFIgSUG3YCojW2s=;
        b=aR8/cwfYn98ccTkOITgjXbiTzXXW+Xwet2g6R7S2vfDN9pkPJ1GFinKwT7JfcZvXsb
         pUbfcBKgl3cXyBf7hzqQfE906k+n941W5lcxCJPd0p2+KUmsgoE8ENtyXu7msXdIfH3N
         Yr7czHI/2InhU1gaJFMHX9LPgehh13sEm+YLmOORkWbRiNrf+kkgzfEjJ+TBTZuWRrp8
         hLm86KSr+qTPOpuiTkXzWKFMJ1pUFRYA3lyNqusRlHTR591zGpI/FJrkVT3NUebjPPg9
         0vZLnojlLUl5b4tKCqz+c5TBJMOfOnIBAVrIaDV6myf+qmSxZdRsXDin8eRLq2NCtQVo
         2Nrg==
X-Gm-Message-State: AGi0PuYCnUJQzJqhaBS3uGGAJ4Git3Ho0MfqBtwsIqNb7WEyhqJjerH8
        GWP/LKNGz6SFiqEMaudgVfGT08DS2Yo=
X-Google-Smtp-Source: APiQypJy353nQ982gT/j4YecpHxsxuPLDBjG/HkcW1zhiO7I8Lo2D9dYGiEwPcoqsaUi47CULVXv6g==
X-Received: by 2002:a02:9f13:: with SMTP id z19mr2930300jal.29.1588269542503;
        Thu, 30 Apr 2020 10:59:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x29sm173663ilk.74.2020.04.30.10.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:59:01 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     skhan@linuxfoundation.org, Steven Rostedt <rostedt@goodmis.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.7-rc4
Message-ID: <fbc67b4b-a23e-2788-da18-7bb168ba5fd6@linuxfoundation.org>
Date:   Thu, 30 Apr 2020 11:59:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AE4A2B6FF0AA988C3FC28E25"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------AE4A2B6FF0AA988C3FC28E25
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.7-rc4.

This kselftest update for Linux 5.7-rc4 consists of:

- ftrace test fixes to check for required filter files and kprobe args.

- Kselftest build/cross-build dependency check script to make it easier
   for test ring admins/users to configure build systems correctly for
   build/cross-build kselftests. Currently checks library dependencies.

     - Checks if Kselftests can be built/cross-built on a system running
       compile test on a trivial C file with LDLIBS specified for each
       individual test in their Makefiles.
     - Prints suggested target list for a system filtering out tests
       failed the build dependency check from the TARGETS in Selftests
       the main Makefile when optional -p is specified.
     - Prints pass/fail dependency check for each tests/sub-test.
     - Prints pass/fail targets and libraries.
     - Default: runs dependency checks on all tests.
     - Optional test name can be specified to check dependencies for it.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b87080eab4c1377706c113fc9c0157f19ea8fed1:

   selftests/ipc: Fix test failure seen after initial test run 
(2020-04-14 10:24:28 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.7-rc4

for you to fetch changes up to f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba:

   selftests/ftrace: Check the first record for kprobe_args_type.tc 
(2020-04-24 09:39:26 -0600)

----------------------------------------------------------------
linux-kselftest-5.7-rc4

This kselftest update for Linux 5.7-rc4 consists of:

- ftrace test fixes to check for required filter files and kprobe args.

- Kselftest build/cross-build dependency check script to make it easier
   for test ring admins/users to configure build systems correctly for
   build/cross-build kselftests. Currently checks library dependencies.

     - Checks if Kselftests can be built/cross-built on a system running
       compile test on a trivial C file with LDLIBS specified for each
       individual test in their Makefiles.
     - Prints suggested target list for a system filtering out tests
       failed the build dependency check from the TARGETS in Selftests
       the main Makefile when optional -p is specified.
     - Prints pass/fail dependency check for each tests/sub-test.
     - Prints pass/fail targets and libraries.
     - Default: runs dependency checks on all tests.
     - Optional test name can be specified to check dependencies for it.

----------------------------------------------------------------
Shuah Khan (1):
       selftests: add build/cross-build dependency check script

Xiao Yang (2):
       selftests/ftrace: Check required filter files before running test
       selftests/ftrace: Check the first record for kprobe_args_type.tc

  .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |   5 +-
  .../ftrace/test.d/ftrace/fgraph-filter.tc          |   2 +
  .../ftrace/test.d/ftrace/func-filter-glob.tc       |   2 +
  .../test.d/ftrace/func-filter-notrace-pid.tc       |   5 +-
  .../ftrace/test.d/ftrace/func-filter-pid.tc        |   5 +-
  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |   2 +-
  .../ftrace/test.d/ftrace/func_event_triggers.tc    |   5 +-
  .../ftrace/test.d/ftrace/func_mod_trace.tc         |   2 +-
  .../ftrace/test.d/ftrace/func_profiler.tc          |   5 +-
  .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |   5 +-
  .../ftrace/test.d/ftrace/func_stack_tracer.tc      |   2 +
  .../test.d/ftrace/func_traceonoff_triggers.tc      |   5 +-
  tools/testing/selftests/ftrace/test.d/functions    |   6 +
  .../ftrace/test.d/kprobe/kprobe_args_type.tc       |   2 +-
  .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |   2 +
  tools/testing/selftests/gpio/Makefile              |  12 +-
  tools/testing/selftests/intel_pstate/Makefile      |   2 +-
  tools/testing/selftests/kselftest_deps.sh          | 272 
+++++++++++++++++++++
  tools/testing/selftests/memfd/Makefile             |  14 +-
  19 files changed, 315 insertions(+), 40 deletions(-)
  create mode 100755 tools/testing/selftests/kselftest_deps.sh

----------------------------------------------------------------

--------------AE4A2B6FF0AA988C3FC28E25
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.7-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.7-rc4.diff"

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index aefab0c66d54..f59853857ad2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -10,10 +10,7 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported
 fi
 
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is dynamic ftrace not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 do_reset() {
     if [ -e /proc/sys/kernel/stack_tracer_enabled ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index c8a5209f2119..d610f47edd90 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -9,6 +9,8 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported
 fi
 
+check_filter_file set_ftrace_filter
+
 fail() { # msg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index f4e92afab14b..28936f434ee5 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -9,6 +9,8 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
+check_filter_file set_ftrace_filter
+
 disable_tracing
 clear_trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 8aa46a2ea133..71db68a7975f 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -15,10 +15,7 @@ if [ ! -f set_ftrace_notrace_pid ]; then
     exit_unsupported
 fi
 
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is function tracer not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 do_function_fork=1
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index f2ee1e889e13..d58403c4b7cd 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -16,10 +16,7 @@ if [ ! -f set_ftrace_pid ]; then
     exit_unsupported
 fi
 
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is function tracer not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 do_function_fork=1
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 1a52f2883fe0..b2aff786c1a2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -3,7 +3,7 @@
 # description: ftrace - stacktrace filter command
 # flags: instance
 
-[ ! -f set_ftrace_filter ] && exit_unsupported
+check_filter_file set_ftrace_filter
 
 echo _do_fork:stacktrace >> set_ftrace_filter
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
index ca2ffd7957f9..e9b1fd534e96 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -11,10 +11,7 @@
 #
 
 # The triggers are set within the set_ftrace_filter file
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is dynamic ftrace not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 do_reset() {
     reset_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
index 9330c873f9fe..1a4b4a442d33 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace on module
 
-[ ! -f set_ftrace_filter ] && exit_unsupported
+check_filter_file set_ftrace_filter
 
 : "mod: allows to filter a non exist function"
 echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index dfbae637c60c..a3dadb6b93b4 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -18,10 +18,7 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported;
 fi
 
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is dynamic ftrace not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 if [ ! -f function_profile_enabled ]; then
     echo "function_profile_enabled not found, function profiling enabled?"
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 51f6e6146bd9..70bad441fa7d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -10,10 +10,7 @@
 #
 
 # The triggers are set within the set_ftrace_filter file
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is dynamic ftrace not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 fail() { # mesg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
index b414f0e3c646..51e9e80bc0e6 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -8,6 +8,8 @@ if [ ! -f stack_trace ]; then
   exit_unsupported
 fi
 
+check_filter_file stack_trace_filter
+
 echo > stack_trace_filter
 echo 0 > stack_max_size
 echo 1 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index 1947387fe976..3ed173f2944a 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -11,10 +11,7 @@
 #
 
 # The triggers are set within the set_ftrace_filter file
-if [ ! -f set_ftrace_filter ]; then
-    echo "set_ftrace_filter not found? Is dynamic ftrace not set?"
-    exit_unsupported
-fi
+check_filter_file set_ftrace_filter
 
 fail() { # mesg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5d4550591ff9..61a3c7e2634d 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,3 +1,9 @@
+check_filter_file() { # check filter file introduced by dynamic ftrace
+    if [ ! -f "$1" ]; then
+        echo "$1 not found? Is dynamic ftrace not set?"
+        exit_unsupported
+    fi
+}
 
 clear_trace() { # reset trace output
     echo > trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 1bcb67dcae26..81490ecaaa92 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -38,7 +38,7 @@ for width in 64 32 16 8; do
   echo 0 > events/kprobes/testprobe/enable
 
   : "Confirm the arguments is recorded in given types correctly"
-  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
   check_types $ARGS $width
 
   : "Clear event for next loop"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 7650a82db3f5..df5072815b87 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -5,6 +5,8 @@
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 grep "function" available_tracers || exit_unsupported # this is configurable
 
+check_filter_file set_ftrace_filter
+
 # prepare
 echo nop > current_tracer
 echo _do_fork > set_ftrace_filter
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 0bb80619db58..32bdc978a711 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
-MOUNT_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
-MOUNT_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
-ifeq ($(MOUNT_LDLIBS),)
-MOUNT_LDLIBS := -lmount -I/usr/include/libmount
+VAR_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
+VAR_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lmount -I/usr/include/libmount
 endif
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
-LDLIBS += $(MOUNT_LDLIBS)
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
+LDLIBS += $(VAR_LDLIBS)
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 7340fd6a9a9f..39f0fa2a8fd6 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
-LDLIBS := $(LDLIBS) -lm
+LDLIBS += -lm
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
new file mode 100755
index 000000000000..bbc04646346b
--- /dev/null
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -0,0 +1,272 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# kselftest_deps.sh
+#
+# Checks for kselftest build dependencies on the build system.
+# Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+#
+#
+
+usage()
+{
+
+echo -e "Usage: $0 -[p] <compiler> [test_name]\n"
+echo -e "\tkselftest_deps.sh [-p] gcc"
+echo -e "\tkselftest_deps.sh [-p] gcc vm"
+echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc"
+echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc vm\n"
+echo "- Should be run in selftests directory in the kernel repo."
+echo "- Checks if Kselftests can be built/cross-built on a system."
+echo "- Parses all test/sub-test Makefile to find library dependencies."
+echo "- Runs compile test on a trivial C file with LDLIBS specified"
+echo "  in the test Makefiles to identify missing library dependencies."
+echo "- Prints suggested target list for a system filtering out tests"
+echo "  failed the build dependency check from the TARGETS in Selftests"
+echo "  main Makefile when optional -p is specified."
+echo "- Prints pass/fail dependency check for each tests/sub-test."
+echo "- Prints pass/fail targets and libraries."
+echo "- Default: runs dependency checks on all tests."
+echo "- Optional test name can be specified to check dependencies for it."
+exit 1
+
+}
+
+# Start main()
+main()
+{
+
+base_dir=`pwd`
+# Make sure we're in the selftests top-level directory.
+if [ $(basename "$base_dir") !=  "selftests" ]; then
+	echo -e "\tPlease run $0 in"
+	echo -e "\ttools/testing/selftests directory ..."
+	exit 1
+fi
+
+print_targets=0
+
+while getopts "p" arg; do
+    case $arg in
+        p)
+		print_targets=1
+	shift;;
+    esac
+done
+
+if [ $# -eq 0 ]
+then
+	usage
+fi
+
+# Compiler
+CC=$1
+
+tmp_file=$(mktemp).c
+trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
+#echo $tmp_file
+
+pass=$(mktemp).out
+trap "rm -f $pass" EXIT
+#echo $pass
+
+fail=$(mktemp).out
+trap "rm -f $fail" EXIT
+#echo $fail
+
+# Generate tmp source fire for compile test
+cat << "EOF" > $tmp_file
+int main()
+{
+}
+EOF
+
+# Save results
+total_cnt=0
+fail_trgts=()
+fail_libs=()
+fail_cnt=0
+pass_trgts=()
+pass_libs=()
+pass_cnt=0
+
+# Get all TARGETS from selftests Makefile
+targets=$(egrep "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
+
+# Single test case
+if [ $# -eq 2 ]
+then
+	test=$2/Makefile
+
+	l1_test $test
+	l2_test $test
+	l3_test $test
+
+	print_results $1 $2
+	exit $?
+fi
+
+# Level 1: LDLIBS set static.
+#
+# Find all LDLIBS set statically for all executables built by a Makefile
+# and filter out VAR_LDLIBS to discard the following:
+# 	gpio/Makefile:LDLIBS += $(VAR_LDLIBS)
+# Append space at the end of the list to append more tests.
+
+l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
+		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+
+# Level 2: LDLIBS set dynamically.
+#
+# Level 2
+# Some tests have multiple valid LDLIBS lines for individual sub-tests
+# that need dependency checks. Find them and append them to the tests
+# e.g: vm/Makefile:$(OUTPUT)/userfaultfd: LDLIBS += -lpthread
+# Filter out VAR_LDLIBS to discard the following:
+# 	memfd/Makefile:$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
+# Append space at the end of the list to append more tests.
+
+l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
+		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+
+# Level 3
+# gpio,  memfd and others use pkg-config to find mount and fuse libs
+# respectively and save it in VAR_LDLIBS. If pkg-config doesn't find
+# any, VAR_LDLIBS set to default.
+# Use the default value and filter out pkg-config for dependency check.
+# e.g:
+# gpio/Makefile
+#	VAR_LDLIBS := $(shell pkg-config --libs mount) 2>/dev/null)
+# memfd/Makefile
+#	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+
+l3_tests=$(grep -r --include=Makefile "^VAR_LDLIBS" | \
+		grep -v "pkg-config" | awk -F: '{print $1}')
+
+#echo $l1_tests
+#echo $l2_1_tests
+#echo $l3_tests
+
+all_tests
+print_results $1 $2
+
+exit $?
+}
+# end main()
+
+all_tests()
+{
+	for test in $l1_tests; do
+		l1_test $test
+	done
+
+	for test in $l2_tests; do
+		l2_test $test
+	done
+
+	for test in $l3_tests; do
+		l3_test $test
+	done
+}
+
+# Use same parsing used for l1_tests and pick libraries this time.
+l1_test()
+{
+	test_libs=$(grep --include=Makefile "^LDLIBS" $test | \
+			grep -v "VAR_LDLIBS" | \
+			sed -e 's/\:/ /' | \
+			sed -e 's/+/ /' | cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+# Use same parsing used for l2__tests and pick libraries this time.
+l2_test()
+{
+	test_libs=$(grep --include=Makefile ": LDLIBS" $test | \
+			grep -v "VAR_LDLIBS" | \
+			sed -e 's/\:/ /' | sed -e 's/+/ /' | \
+			cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+l3_test()
+{
+	test_libs=$(grep --include=Makefile "^VAR_LDLIBS" $test | \
+			grep -v "pkg-config" | sed -e 's/\:/ /' |
+			sed -e 's/+/ /' | cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+check_libs()
+{
+
+if [[ ! -z "${test_libs// }" ]]
+then
+
+	#echo $test_libs
+
+	for lib in $test_libs; do
+
+	let total_cnt+=1
+	$CC -o $tmp_file.bin $lib $tmp_file > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "FAIL: $test dependency check: $lib" >> $fail
+		let fail_cnt+=1
+		fail_libs+="$lib "
+		fail_target=$(echo "$test" | cut -d "/" -f1)
+		fail_trgts+="$fail_target "
+		targets=$(echo "$targets" | grep -v "$fail_target")
+	else
+		echo "PASS: $test dependency check passed $lib" >> $pass
+		let pass_cnt+=1
+		pass_libs+="$lib "
+		pass_trgts+="$(echo "$test" | cut -d "/" -f1) "
+	fi
+
+	done
+fi
+}
+
+print_results()
+{
+	echo -e "========================================================";
+	echo -e "Kselftest Dependency Check for [$0 $1 $2] results..."
+
+	if [ $print_targets -ne 0 ]
+	then
+	echo -e "Suggested Selftest Targets for your configuration:"
+	echo -e "$targets";
+	fi
+
+	echo -e "========================================================";
+	echo -e "Checked tests defining LDLIBS dependencies"
+	echo -e "--------------------------------------------------------";
+	echo -e "Total tests with Dependencies:"
+	echo -e "$total_cnt Pass: $pass_cnt Fail: $fail_cnt";
+
+	if [ $pass_cnt -ne 0 ]; then
+	echo -e "--------------------------------------------------------";
+	cat $pass
+	echo -e "--------------------------------------------------------";
+	echo -e "Targets passed build dependency check on system:"
+	echo -e "$(echo "$pass_trgts" | xargs -n1 | sort -u | xargs)"
+	fi
+
+	if [ $fail_cnt -ne 0 ]; then
+	echo -e "--------------------------------------------------------";
+	cat $fail
+	echo -e "--------------------------------------------------------";
+	echo -e "Targets failed build dependency check on system:"
+	echo -e "$(echo "$fail_trgts" | xargs -n1 | sort -u | xargs)"
+	echo -e "--------------------------------------------------------";
+	echo -e "Missing libraries system"
+	echo -e "$(echo "$fail_libs" | xargs -n1 | sort -u | xargs)"
+	fi
+
+	echo -e "--------------------------------------------------------";
+	echo -e "========================================================";
+}
+
+main "$@"
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 187b14cad00c..4da8b565fa32 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -8,11 +8,21 @@ TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
 TEST_GEN_FILES := fuse_test fuse_mnt
 
-fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
+VAR_CFLAGS := $(shell pkg-config fuse --cflags 2>/dev/null)
+ifeq ($(VAR_CFLAGS),)
+VAR_CFLAGS := -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse
+endif
+
+VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lfuse -pthread
+endif
+
+fuse_mnt.o: CFLAGS += $(VAR_CFLAGS)
 
 include ../lib.mk
 
-$(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
+$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
 $(OUTPUT)/memfd_test: memfd_test.c common.c
 $(OUTPUT)/fuse_test: fuse_test.c common.c

--------------AE4A2B6FF0AA988C3FC28E25--
