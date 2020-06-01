Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A01EA617
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFAOm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 10:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOm5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C282074B;
        Mon,  1 Jun 2020 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022576;
        bh=WwdZkv9bR1CV32Ilx8eC8YbnqA2kH1BtzWCAFftpY6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmVcqkQfJtgi2zisnMw6RuKdx5/3Nz8k/4aIsw+ZOMiq+cKiBArDGcJTr+58LwS/q
         8xFa/sspPhUEkR57qEwJTfZWXOb+0HQUMa7IXg7j4nKrmbx9WA6tw/ZoyxKgUrs0nt
         y2sIi4cxSlEZ+i7xSWZq9Y7o6zY7X/zoK2I0H7tY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/7] selftests/ftrace: Convert check_filter_file() with requires list
Date:   Mon,  1 Jun 2020 23:42:52 +0900
Message-Id: <159102257181.31199.874384857778027008.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159102252279.31199.12855129586058455119.stgit@devnote2>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since check_filter_file() is basically checking the filter
tracefs file, we can convert it into requires list.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |    4 +---
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |    3 +--
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |    3 +--
 .../test.d/ftrace/func-filter-notrace-pid.tc       |    4 +---
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    4 +---
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    3 +--
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |    7 +++----
 .../ftrace/test.d/ftrace/func_mod_trace.tc         |    3 +--
 .../ftrace/test.d/ftrace/func_profiler.tc          |    4 +---
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |    6 +++---
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      |    4 +---
 .../test.d/ftrace/func_traceonoff_triggers.tc      |    6 +++---
 tools/testing/selftests/ftrace/test.d/functions    |    7 -------
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    4 +---
 14 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index 8dd22561d5b0..62af263fa75e 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters with stack tracer
-# requires: stack_trace
+# requires: stack_trace set_ftrace_filter
 
 # Make sure that function graph filtering works, and is not
 # affected by other tracers enabled (like stack tracer)
@@ -11,8 +11,6 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported
 fi
 
-check_filter_file set_ftrace_filter
-
 do_reset() {
     if [ -e /proc/sys/kernel/stack_tracer_enabled ]; then
 	    echo 0 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index d610f47edd90..56a86a2fc8ba 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters
+# requires: set_ftrace_filter
 
 # Make sure that function graph filtering works
 
@@ -9,8 +10,6 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported
 fi
 
-check_filter_file set_ftrace_filter
-
 fail() { # msg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 28936f434ee5..ac3e4d35f181 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function glob filters
+# requires: set_ftrace_filter
 
 # Make sure that function glob matching filter works.
 
@@ -9,8 +10,6 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
-check_filter_file set_ftrace_filter
-
 disable_tracing
 clear_trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 799cd1b9c42c..b7e18d30104a 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid notrace filters
-# requires: set_ftrace_notrace_pid
+# requires: set_ftrace_notrace_pid set_ftrace_filter
 # flags: instance
 
 # Make sure that function pid matching filter with notrace works.
@@ -11,8 +11,6 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
-check_filter_file set_ftrace_filter
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 9497031913bb..53ec48a92f39 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
-# requires: set_ftrace_pid
+# requires: set_ftrace_pid set_ftrace_filter
 # flags: instance
 
 # Make sure that function pid matching filter works.
@@ -12,8 +12,6 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
-check_filter_file set_ftrace_filter
-
 do_function_fork=1
 
 if [ ! -f options/function-fork ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index b2aff786c1a2..0f41e441c203 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - stacktrace filter command
+# requires: set_ftrace_filter
 # flags: instance
 
-check_filter_file set_ftrace_filter
-
 echo _do_fork:stacktrace >> set_ftrace_filter
 
 grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
index e9b1fd534e96..3145b0f1835c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -3,15 +3,14 @@
 # description: ftrace - test for function event triggers
 # flags: instance
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # Ftrace allows to add triggers to functions, such as enabling or disabling
 # tracing, enabling or disabling trace events, or recording a stack trace
 # within the ring buffer.
 #
 # This test is designed to test event triggers
-#
-
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
 
 do_reset() {
     reset_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
index 1a4b4a442d33..37c8feb9078b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace on module
-
-check_filter_file set_ftrace_filter
+# requires: set_ftrace_filter
 
 : "mod: allows to filter a non exist function"
 echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index 817d504f751c..8b487daaaf68 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiler with function tracing
-# requires: function_profile_enabled
+# requires: function_profile_enabled set_ftrace_filter
 
 # There was a bug after a rewrite of the ftrace infrastructure that
 # caused the function_profiler not to be able to run with the function
@@ -19,8 +19,6 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported;
 fi
 
-check_filter_file set_ftrace_filter
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 70bad441fa7d..e96e279e0533 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - test reading of set_ftrace_filter
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # The set_ftrace_filter file of ftrace is used to list functions as well as
 # triggers (probes) attached to functions. The code to read this file is not
 # straight forward and has had various bugs in the past. This test is designed
@@ -9,9 +12,6 @@
 # file in various ways (cat vs dd).
 #
 
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
index b3d78ef6c639..61264e422699 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -1,11 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - Max stack tracer
-# requires: stack_trace
+# requires: stack_trace stack_trace_filter
 # Test the basic function of max-stack usage tracing
 
-check_filter_file stack_trace_filter
-
 echo > stack_trace_filter
 echo 0 > stack_max_size
 echo 1 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index 3ed173f2944a..aee22289536b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -3,6 +3,9 @@
 # description: ftrace - test for function traceon/off triggers
 # flags: instance
 #
+# The triggers are set within the set_ftrace_filter file
+# requires: set_ftrace_filter
+#
 # Ftrace allows to add triggers to functions, such as enabling or disabling
 # tracing, enabling or disabling trace events, or recording a stack trace
 # within the ring buffer.
@@ -10,9 +13,6 @@
 # This test is designed to test enabling and disabling tracing triggers
 #
 
-# The triggers are set within the set_ftrace_filter file
-check_filter_file set_ftrace_filter
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5100eb1ada0f..cd2756c77ed9 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,10 +1,3 @@
-check_filter_file() { # check filter file introduced by dynamic ftrace
-    if [ ! -f "$1" ]; then
-        echo "$1 not found? Is dynamic ftrace not set?"
-        exit_unsupported
-    fi
-}
-
 clear_trace() { # reset trace output
     echo > trace
 }
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index b7f8536438bd..9a983df5ae17 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -1,12 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with function tracer
-# requires: kprobe_events
+# requires: kprobe_events stack_trace_filter
 
 grep "function" available_tracers || exit_unsupported # this is configurable
 
-check_filter_file set_ftrace_filter
-
 # prepare
 echo nop > current_tracer
 echo _do_fork > set_ftrace_filter

