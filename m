Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3F1B412F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgDVKuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 06:50:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19730 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729233AbgDVKLp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:45 -0400
X-IronPort-AV: E=Sophos;i="5.72,413,1580745600"; 
   d="scan'208";a="89467558"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Apr 2020 18:11:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 6581B46B5FA5;
        Wed, 22 Apr 2020 18:01:00 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 22 Apr 2020 18:11:35 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Wed, 22 Apr 2020 18:11:34 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <rostedt@goodmis.org>
CC:     <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] selftests/ftrace: Check required filter files before running test
Date:   Wed, 22 Apr 2020 17:58:07 +0800
Message-ID: <20200422095807.548519-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6581B46B5FA5.AB41B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Without CONFIG_DYNAMIC_FTRACE, some tests get failure because required
filter files(set_ftrace_filter/available_filter_functions/stack_trace_filter)
are missing.  So implement check_filter_file() and make all related tests
check required filter files by it.

BTW: set_ftrace_filter and available_filter_functions are introduced together
so just check either of them.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc   | 5 +----
 .../testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc | 2 ++
 .../selftests/ftrace/test.d/ftrace/func-filter-glob.tc      | 2 ++
 .../ftrace/test.d/ftrace/func-filter-notrace-pid.tc         | 5 +----
 .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc       | 5 +----
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc          | 2 +-
 .../selftests/ftrace/test.d/ftrace/func_event_triggers.tc   | 5 +----
 .../selftests/ftrace/test.d/ftrace/func_mod_trace.tc        | 2 +-
 .../testing/selftests/ftrace/test.d/ftrace/func_profiler.tc | 5 +----
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc  | 5 +----
 .../selftests/ftrace/test.d/ftrace/func_stack_tracer.tc     | 2 ++
 .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc        | 5 +----
 tools/testing/selftests/ftrace/test.d/functions             | 6 ++++++
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc | 2 ++
 14 files changed, 23 insertions(+), 30 deletions(-)

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
-- 
2.25.1



