Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36AF1EB803
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgFBJJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 05:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgFBJJG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 05:09:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E126120738;
        Tue,  2 Jun 2020 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591088944;
        bh=Wkhnyt5kEBuBb2xcVJzd88oqCDCzULJIKT076tORkGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jqQM7+TG91gFNz5bEy+YztKyOtRtIo0U2O6v6OcLmTHbBsWWIB4BfWjntZzHY5F0
         TfnDBdwbaaLM7bWmbvTTUpxAEYeQqH6IoiJ8qSBM2MRRl/eDwUsWFtuDS0kS/X4i0t
         MQ6jfA2E/UYntNerfkD7SQVGEq7tFzx2nDOL4gX8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 6/7] selftests/ftrace: Support ":tracer" suffix for requires
Date:   Tue,  2 Jun 2020 18:09:00 +0900
Message-Id: <159108894045.42416.9967715747204641780.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159108888259.42416.547252366885528860.stgit@devnote2>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ":tracer" suffix support for the requires list, so that
the testcase can list up the required tracer (e.g. function)
to the requires list.

For example, if the testcase requires function_graph tracer,
it can write requires list as below instead of checking
available_tracers.

# requires: function_graph:tracer

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |    7 +------
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |    7 +------
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |    7 +------
 .../test.d/ftrace/func-filter-notrace-pid.tc       |    7 +------
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    7 +------
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    6 +-----
 .../ftrace/test.d/ftrace/func_profiler.tc          |    6 +-----
 tools/testing/selftests/ftrace/test.d/functions    |   10 ++++++++--
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    4 +---
 .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |    4 +---
 tools/testing/selftests/ftrace/test.d/template     |    3 ++-
 .../selftests/ftrace/test.d/tracer/wakeup.tc       |    6 +-----
 .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |    6 +-----
 13 files changed, 21 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index 62af263fa75e..cf3ea42b12b0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -1,16 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters with stack tracer
-# requires: stack_trace set_ftrace_filter
+# requires: stack_trace set_ftrace_filter function_graph:tracer
 
 # Make sure that function graph filtering works, and is not
 # affected by other tracers enabled (like stack tracer)
 
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported
-fi
-
 do_reset() {
     if [ -e /proc/sys/kernel/stack_tracer_enabled ]; then
 	    echo 0 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index 56a86a2fc8ba..b3ccdaec2a61 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -1,15 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters
-# requires: set_ftrace_filter
+# requires: set_ftrace_filter function_graph:tracer
 
 # Make sure that function graph filtering works
 
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported
-fi
-
 fail() { # msg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index ac3e4d35f181..4b994b6df5ac 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -1,15 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function glob filters
-# requires: set_ftrace_filter
+# requires: set_ftrace_filter function:tracer
 
 # Make sure that function glob matching filter works.
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
 disable_tracing
 clear_trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index b7e18d30104a..acb17ce543d2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -1,16 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid notrace filters
-# requires: set_ftrace_notrace_pid set_ftrace_filter
+# requires: set_ftrace_notrace_pid set_ftrace_filter function:tracer
 # flags: instance
 
 # Make sure that function pid matching filter with notrace works.
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 53ec48a92f39..9f0a9687c773 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,17 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
-# requires: set_ftrace_pid set_ftrace_filter
+# requires: set_ftrace_pid set_ftrace_filter function:tracer
 # flags: instance
 
 # Make sure that function pid matching filter works.
 # Also test it on an instance directory
 
-if ! grep -q function available_tracers; then
-    echo "no function tracer configured"
-    exit_unsupported
-fi
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
index 71fa3f49e35e..0c6cf7725110 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace with cpumask
+# requires: function:tracer
 
 if ! which nproc ; then
   nproc() {
@@ -15,11 +16,6 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
-if ! grep -q "function" available_tracers ; then
-  echo "Function trace is not enabled"
-  exit_unsupported
-fi
-
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index 8b487daaaf68..1dbd766c0cd2 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiler with function tracing
-# requires: function_profile_enabled set_ftrace_filter
+# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
 
 # There was a bug after a rewrite of the ftrace infrastructure that
 # caused the function_profiler not to be able to run with the function
@@ -14,10 +14,6 @@
 # This test triggers those bugs on those kernels.
 #
 # We need function_graph and profiling to to run this test
-if ! grep -q function_graph available_tracers; then
-    echo "no function graph tracer configured"
-    exit_unsupported;
-fi
 
 fail() { # mesg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index cd2756c77ed9..35de6bc9613b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -106,9 +106,15 @@ initialize_ftrace() { # Reset ftrace to initial-state
     enable_tracing
 }
 
-check_requires() { # Check required files
+check_requires() { # Check required files and tracers
     for i in $* ; do
-        if [ ! -e $i ]; then
+        t=${i%:tracer}
+        if [ $t != $i ]; then
+            if ! grep -wq $t available_tracers ; then
+                echo "Required tracer $t is not configured."
+                exit_unsupported
+            fi
+        elif [ ! -e $i ]; then
             echo "Required feature interface $i doesn't exist."
             exit_unsupported
         fi
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 9a983df5ae17..81d8b58c03bc 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -1,9 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with function tracer
-# requires: kprobe_events stack_trace_filter
-
-grep "function" available_tracers || exit_unsupported # this is configurable
+# requires: kprobe_events stack_trace_filter function:tracer
 
 # prepare
 echo nop > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index 2b82c80edf69..22bff122b933 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: test for the preemptirqsoff tracer
+# requires: preemptoff:tracer irqsoff:tracer
 
 MOD=preemptirq_delay_test
 
@@ -27,9 +28,6 @@ unres() { #msg
 modprobe $MOD || unres "$MOD module not available"
 rmmod $MOD
 
-grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
-grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
-
 reset_tracer
 
 # Simulate preemptoff section for half a second couple of times
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index d679e5c9e1ee..e7d92905a4ce 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,7 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
-# requires: %HERE LIST UP REQUIRED FILES%
+# requires: %HERE LIST UP REQUIRED FILES OR TRACERS%
+# The required tracer needs :tracer suffix, e.g. function:tracer
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
 
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
index b0893d7edda3..11be10e1bf96 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup tracer
+# requires: wakeup:tracer
 
 if ! which chrt ; then
   echo "chrt is not found. This test requires nice command."
   exit_unresolved
 fi
 
-if ! grep -wq "wakeup" available_tracers ; then
-  echo "wakeup tracer is not supported"
-  exit_unsupported
-fi
-
 echo wakeup > current_tracer
 echo 1 > tracing_on
 echo 0 > tracing_max_latency
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
index b9b6669a623b..3a77198b3c69 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup RT tracer
+# requires: wakeup_rt:tracer
 
 if ! which chrt ; then
   echo "chrt is not found. This test requires chrt command."
   exit_unresolved
 fi
 
-if ! grep -wq "wakeup_rt" available_tracers ; then
-  echo "wakeup_rt tracer is not supported"
-  exit_unsupported
-fi
-
 echo wakeup_rt > current_tracer
 echo 1 > tracing_on
 echo 0 > tracing_max_latency

