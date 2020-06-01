Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1011EA615
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgFAOmv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 10:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOmu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7232B207BC;
        Mon,  1 Jun 2020 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022566;
        bh=cm+NQJu3vNWo2ARhm0VVIusAUnFzuIMmILZrdDdEdfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDMIJ/2HII1i0yb0HfVGwLdsxl9vCDJf9eu3VS1L8XEgZdpNn80YU/IIxtqkT69BM
         g6nnMk6TylTnMgIlz6+EkVRroIUmpRwTLw4cciBK0p3BbYjw15/0Uo3HlKm7orMVWP
         1VQrzAJrnAv11BWYpFWVXUIUC8pdIDKeMfljP2C4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/7] selftests/ftrace: Convert required interface checks into requires list
Date:   Mon,  1 Jun 2020 23:42:42 +0900
Message-Id: <159102256204.31199.842249429317038334.stgit@devnote2>
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

Convert the required tracefs interface checking code with
requires: list.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/00basic/snapshot.tc    |    3 +-
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |    3 +-
 .../ftrace/test.d/direct/kprobe-direct.tc          |    6 +---
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |    3 +-
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |    3 +-
 .../ftrace/test.d/dynevent/clear_select_events.tc  |    6 +---
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |    3 +-
 .../selftests/ftrace/test.d/event/event-enable.tc  |    6 +---
 .../selftests/ftrace/test.d/event/event-no-pid.tc  |   11 +------
 .../selftests/ftrace/test.d/event/event-pid.tc     |   11 +------
 .../ftrace/test.d/event/subsystem-enable.tc        |    6 +---
 .../ftrace/test.d/event/toplevel-enable.tc         |    6 +---
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |    7 +----
 .../test.d/ftrace/func-filter-notrace-pid.tc       |    6 +---
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    6 +---
 .../ftrace/test.d/ftrace/func_profile_stat.tc      |    3 +-
 .../ftrace/test.d/ftrace/func_profiler.tc          |    6 +---
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      |    6 +---
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |   12 ++------
 .../ftrace/test.d/instances/instance-event.tc      |    6 +---
 .../selftests/ftrace/test.d/instances/instance.tc  |    6 +---
 .../ftrace/test.d/kprobe/add_and_remove.tc         |    3 +-
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |    3 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    2 +
 .../ftrace/test.d/kprobe/kprobe_module.tc          |    3 +-
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |    3 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    5 +--
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |    3 +-
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    2 +
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    3 +-
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    3 +-
 .../selftests/ftrace/test.d/kprobe/profile.tc      |    3 +-
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 +--
 .../inter-event/trigger-action-hist-xfail.tc       |   11 +------
 .../inter-event/trigger-field-variable-support.tc  |   16 +---------
 .../trigger-inter-event-combined-hist.tc           |   16 +---------
 .../inter-event/trigger-multi-actions-accept.tc    |   16 +---------
 .../inter-event/trigger-onchange-action-hist.tc    |    6 +---
 .../inter-event/trigger-onmatch-action-hist.tc     |   16 +---------
 .../trigger-onmatch-onmax-action-hist.tc           |   16 +---------
 .../inter-event/trigger-onmax-action-hist.tc       |   16 +---------
 .../inter-event/trigger-snapshot-action-hist.tc    |   16 +---------
 .../trigger-synthetic-event-createremove.tc        |   11 +------
 .../inter-event/trigger-synthetic-event-syntax.tc  |   11 +------
 .../inter-event/trigger-trace-action-hist.tc       |   16 +---------
 .../ftrace/test.d/trigger/trigger-eventonoff.tc    |   11 +------
 .../ftrace/test.d/trigger/trigger-filter.tc        |   11 +------
 .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   16 +---------
 .../test.d/trigger/trigger-hist-syntax-errors.tc   |   18 +-----------
 .../ftrace/test.d/trigger/trigger-hist.tc          |   16 +---------
 .../ftrace/test.d/trigger/trigger-multihist.tc     |   16 +---------
 .../ftrace/test.d/trigger/trigger-snapshot.tc      |   16 +---------
 .../ftrace/test.d/trigger/trigger-stacktrace.tc    |   11 +------
 .../test.d/trigger/trigger-trace-marker-hist.tc    |   21 +-------------
 .../trigger/trigger-trace-marker-snapshot.tc       |   21 +-------------
 .../trigger-trace-marker-synthetic-kernel.tc       |   31 +-------------------
 .../trigger/trigger-trace-marker-synthetic.tc      |   26 +----------------
 .../ftrace/test.d/trigger/trigger-traceonoff.tc    |   11 +------
 66 files changed, 68 insertions(+), 511 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
index 3b1f45e13a2e..13b4dabcf46e 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
@@ -1,9 +1,8 @@
 #!/bin/sh
 # description: Snapshot and tracing setting
+# requires: snapshot
 # flags: instance
 
-[ ! -f snapshot ] && exit_unsupported
-
 echo "Set tracing off"
 echo 0 > tracing_on
 
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
index 5058fbcfd90f..435d07b13407 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_pipe and trace_marker
+# requires: trace_marker
 # flags: instance
 
-[ ! -f trace_marker ] && exit_unsupported
-
 echo "test input 1" > trace_marker
 
 : "trace interface never consume the ring buffer"
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index e95b744b23e4..e52e470a1f8f 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test ftrace direct functions against kprobes
+# requires: kprobe_events
 
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
@@ -8,11 +9,6 @@ if ! modprobe ftrace-direct ; then
   exit_unresolved;
 fi
 
-if [ ! -f kprobe_events ]; then
-	echo "No kprobe_events file -please build CONFIG_KPROBE_EVENTS"
-	exit_unsupported;
-fi
-
 echo "Let the module run a little"
 sleep 1
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index c6d8387dbbb8..1a8c56b197a8 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove kprobe events
-
-[ -f dynamic_events ] || exit_unsupported
+# requires: dynamic_events
 
 grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
 grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
index 62b77b5941d0..f5018b3afb39 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove synthetic events
-
-[ -f dynamic_events ] || exit_unsupported
+# requires: dynamic_events
 
 grep -q "s:\[synthetic/\]" README || exit_unsupported
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
index e0842109cb57..e2484445ddec 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - selective clear (compatibility)
-
-[ -f dynamic_events ] || exit_unsupported
+# requires: dynamic_events kprobe_events synthetic_events
 
 grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
 grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
 
 grep -q "s:\[synthetic/\]" README || exit_unsupported
 
-[ -f synthetic_events ] || exit_unsupported
-[ -f kprobe_events ] || exit_unsupported
-
 echo 0 > events/enable
 echo > dynamic_events
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
index 901922e97878..e56cb60b4e56 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - generic clear event
-
-[ -f dynamic_events ] || exit_unsupported
+# requires: dynamic_events
 
 grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
 grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index dfb0d5122f7b..cfe5bd2d4267 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with event level files
+# requires: set_event events/sched
 # flags: instance
 
 do_reset() {
@@ -13,11 +14,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo 'sched:sched_switch' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index f0f366f18d0c..e6eb78f0b954 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - restricts events based on pid notrace filtering
+# requires: set_event events/sched set_event_pid set_event_notrace_pid
 # flags: instance
 
 do_reset() {
@@ -56,16 +57,6 @@ enable_events() {
     echo 1 > tracing_on
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f set_event_pid -o ! -f set_event_notrace_pid ]; then
-    echo "event pid notrace filtering is not supported"
-    exit_unsupported
-fi
-
 echo 0 > options/event-fork
 
 do_reset
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index f9cb214220b1..7f5f97dffdc3 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - restricts events based on pid
+# requires: set_event set_event_pid events/sched
 # flags: instance
 
 do_reset() {
@@ -16,16 +17,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f set_event_pid ]; then
-    echo "event pid filtering is not supported"
-    exit_unsupported
-fi
-
 echo 0 > options/event-fork
 
 echo 1 > events/sched/sched_switch/enable
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index 83a8c571e93a..b1ede6249866 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with subsystem level files
+# requires: set_event events/sched/enable
 # flags: instance
 
 do_reset() {
@@ -13,11 +14,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo 'sched:*' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 84d7bda08d2a..93c10ea42a68 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event tracing - enable/disable with top level files
+# requires: available_events set_event events/enable
 
 do_reset() {
     echo > set_event
@@ -12,11 +13,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f available_events -o ! -f set_event -o ! -d events ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 echo '*:*' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index f59853857ad2..8dd22561d5b0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function graph filters with stack tracer
+# requires: stack_trace
 
 # Make sure that function graph filtering works, and is not
 # affected by other tracers enabled (like stack tracer)
@@ -37,12 +38,6 @@ fi
 
 echo function_graph > current_tracer
 
-if [ ! -f stack_trace ]; then
-    echo "Stack tracer not configured"
-    do_reset
-    exit_unsupported;
-fi
-
 echo "Now testing with stack tracer"
 
 echo 1 > /proc/sys/kernel/stack_tracer_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 71db68a7975f..799cd1b9c42c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid notrace filters
+# requires: set_ftrace_notrace_pid
 # flags: instance
 
 # Make sure that function pid matching filter with notrace works.
@@ -10,11 +11,6 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
-if [ ! -f set_ftrace_notrace_pid ]; then
-    echo "set_ftrace_notrace_pid not found? Is function tracer not set?"
-    exit_unsupported
-fi
-
 check_filter_file set_ftrace_filter
 
 do_function_fork=1
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index d58403c4b7cd..9497031913bb 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
+# requires: set_ftrace_pid
 # flags: instance
 
 # Make sure that function pid matching filter works.
@@ -11,11 +12,6 @@ if ! grep -q function available_tracers; then
     exit_unsupported
 fi
 
-if [ ! -f set_ftrace_pid ]; then
-    echo "set_ftrace_pid not found? Is function tracer not set?"
-    exit_unsupported
-fi
-
 check_filter_file set_ftrace_filter
 
 do_function_fork=1
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
index 0d501058aa75..4daeffb02fd8 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiling
-
-[ ! -f function_profile_enabled ] && exit_unsupported
+# requires: function_profile_enabled
 
 : "Enable function profile"
 echo 1 > function_profile_enabled
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index a3dadb6b93b4..817d504f751c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function profiler with function tracing
+# requires: function_profile_enabled
 
 # There was a bug after a rewrite of the ftrace infrastructure that
 # caused the function_profiler not to be able to run with the function
@@ -20,11 +21,6 @@ fi
 
 check_filter_file set_ftrace_filter
 
-if [ ! -f function_profile_enabled ]; then
-    echo "function_profile_enabled not found, function profiling enabled?"
-    exit_unsupported
-fi
-
 fail() { # mesg
     echo $1
     exit_fail
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
index 51e9e80bc0e6..b3d78ef6c639 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -1,13 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - Max stack tracer
+# requires: stack_trace
 # Test the basic function of max-stack usage tracing
 
-if [ ! -f stack_trace ]; then
-  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
-  exit_unsupported
-fi
-
 check_filter_file stack_trace_filter
 
 echo > stack_trace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
index 23465823532b..6c190620db47 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -1,21 +1,15 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - test tracing error log support
+# event tracing is currently the only ftrace tracer that uses the
+# tracing error_log, hence this check
+# requires: set_event error_log
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-# event tracing is currently the only ftrace tracer that uses the
-# tracing error_log, hence this check
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-[ -f error_log ] || exit_unsupported
-
 ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
 
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 4fa0f79144f4..0eb47fbb3f44 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test creation and deletion of trace instances while setting an event
-
-if [ ! -d instances ] ; then
-    echo "no instance directory with this kernel"
-    exit_unsupported;
-fi
+# requires: instances
 
 fail() { # mesg
     rmdir foo 2>/dev/null
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance.tc b/tools/testing/selftests/ftrace/test.d/instances/instance.tc
index b84651283bf3..607521d2592b 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance.tc
@@ -1,11 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test creation and deletion of trace instances
-
-if [ ! -d instances ] ; then
-    echo "no instance directory with this kernel"
-    exit_unsupported;
-fi
+# requires: instances
 
 fail() { # mesg
     rmdir x y z 2>/dev/null
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
index bb1eb5a7c64e..eba858c21815 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - adding and removing
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 echo p:myevent _do_fork > kprobe_events
 grep myevent kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
index 442c1a8c5edf..d10bf4f05bc8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - busy event check
-
-[ -f kprobe_events ] || exit_unsupported
+# requires: kprobe_events
 
 echo p:myevent _do_fork > kprobe_events
 test -d events/kprobes/myevent
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index bcdecf80a8f1..61f2ac441aec 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
 grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
index 15c1f70fcaf9..05aaeed6987f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event with comm arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 46e7744f8358..b5fa05443b39 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event string type argument
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
index 2b6dd33f9076..b8c75a3d003c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event symbol argument
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 SYMBOL="linux_proc_banner"
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 6f0f19953193..f06c1477f00f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event argument syntax
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 81490ecaaa92..d599d6f544d4 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobes event arguments with types
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index b41471f301ab..a9b3a788183f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event user-memory access
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 grep -q '\$arg<N>' README || exit_unsupported # depends on arch
 grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 3ff236719b6e..1f6981ef7afa 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event auto/manual naming
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 :;: "Add an event on function without name" ;:
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index df5072815b87..b7f8536438bd 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -1,8 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event with function tracer
+# requires: kprobe_events
 
-[ -f kprobe_events ] || exit_unsupported # this is configurable
 grep "function" available_tracers || exit_unsupported # this is configurable
 
 check_filter_file set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index d861bd776c5e..7e74ee11edf9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - probing module
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index 44494bac86d1..8205d588bed4 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Create/delete multiprobe on kprobe event
-
-[ -f kprobe_events ] || exit_unsupported
+# requires: kprobe_events
 
 grep -q "Create/append/" README || exit_unsupported
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index eb0f4ab4e070..b4d834675e59 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event parser error log check
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
-
-[ -f error_log ] || exit_unsupported
+# requires: kprobe_events error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_kprobe' "$1" 'kprobe_events'
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index ac9ab4a12e53..523fde6d1aa5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kretprobe dynamic event with arguments
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 # Add new kretprobe event
 echo 'r:testprobe2 _do_fork $retval' > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
index 8e05b178519a..0f96a45010d1 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
@@ -1,8 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kretprobe dynamic event with maxactive
+# requires: kprobe_events
 
-[ -f kprobe_events ] || exit_unsupported # this is configurable
 grep -q 'r\[maxactive\]' README || exit_unsupported # this is older version
 
 # Test if we successfully reject unknown messages
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 6e3dbe5f96b7..312d23780096 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Register/unregister many kprobe events
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 # ftrace fentry skip size depends on the machine architecture.
 # Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index a902aa0aaabc..624269c8d534 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe events - probe points
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 TARGET_FUNC=tracefs_create_dir
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index 0384b525cdee..ff6c44adc8a0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -1,8 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe dynamic event - adding and removing
-
-[ -f kprobe_events ] || exit_unsupported # this is configurable
+# requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
 echo p:myevent _do_fork > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index 14229d5778a0..7b5b60c3c5a2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -1,10 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Uprobe event parser error log check
-
-[ -f uprobe_events ] || exit_unsupported # this is configurable
-
-[ -f error_log ] || exit_unsupported
+# requires: uprobe_events error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_uprobe' "$1" 'uprobe_events'
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 3f2aee115f6e..07093bbd9816 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger expected fail actions
+# requires: set_event snapshot
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
 grep -q "snapshot()" README || exit_unsupported # version issue
 
 echo "Test expected snapshot action failure"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index e232059a8ab2..41119e0440e9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test field variable support
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test field variable support"
 
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 07cfcb8157b6..7449a4b8f1f9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index 73e413c2ca26..3ad6e3fd8ac9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test multiple actions on hist trigger
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test multiple actions on hist trigger"
 echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 TRIGGER1=events/sched/sched_wakeup/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index c80007aa9f86..59f876c80d45 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -1,17 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
+# requires: synthetic_events
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
 grep -q "onchange(var)" README || exit_unsupported # version issue
 
 echo "Test onchange action"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index ebe0ad827f9f..20e39471052e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 2a2ef767249e..f4b03ab7c287 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 98d73bfb0296..71c9b5911c70 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmax action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 01b01b9c4e07..2902a897255f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
+# requires: set_event snapshot events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
 grep -q "onchange(var)" README || exit_unsupported # version issue
 
 grep -q "snapshot()" README || exit_unsupported # version issue
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
index df44b14724a4..a152b558b40a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic event create remove
+# requires: set_event synthetic_events
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 88e6c3f43006..59216f3cfb12 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser
+# requires: set_event synthetic_events
 
 do_reset() {
     reset_trigger
@@ -14,16 +15,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
 reset_tracer
 do_reset
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c3baa486aeb4..e2ef5268b7e9 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
 
 echo "Test create synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
index eddb51e1fbf7..c226acee74bf 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test event enable/disable trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,16 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep enable_event events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "event enable/disable trigger is not supported"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
index 2dcc2296ebdd..d9a198cb0f81 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test trigger filter
+# requires: set_event events/sched/sched_process_fork/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,16 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test trigger filter"
 echo 1 > tracing_on
 echo 'traceoff if child_pid == 0' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
index fab4431639d3..4562e13cb26b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram modifiers
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,21 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram with execname modifier"
 
 echo 'hist:keys=common_pid.execname' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
index d44087a2f3d1..52cfe7828e8a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
@@ -1,23 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram parser errors
-
-if [ ! -f set_event -o ! -d events/kmem ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/kmem/kmalloc/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/kmem/kmalloc/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
-[ -f error_log ] || exit_unsupported
+# requires: set_event events/kmem/kmalloc/trigger events/kmem/kmalloc/hist error_log
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'hist:kmem:kmalloc' "$1" 'events/kmem/kmalloc/trigger'
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 177e8d4c4744..0e490921c724 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram trigger
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,21 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram basic tigger"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index 68ff3f45c720..7129b52da947 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test multiple histogram triggers
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist
 # flags: instance
 
 fail() { #msg
@@ -8,21 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram multiple triggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
index ac738500d17f..33f5bdee387f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
@@ -1,27 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test snapshot-trigger
+# requires: set_event events/sched/sched_process_fork/trigger snapshot
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep snapshot events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "snapshot trigger is not supported"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
index 398c05c4d2a7..1fe8e008b14f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test stacktrace-trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 FEATURE=`grep stacktrace events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "stacktrace trigger is not supported"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index ab6bedb25736..c1e947864a71 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram trigger
+# requires: set_event events/ftrace/print/trigger events/ftrace/print/hist
 # flags: instance
 
 fail() { #msg
@@ -8,26 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram trace_marker tigger"
 
 echo 'hist:keys=common_pid' > events/ftrace/print/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index df246e505af7..9fa48b0da940 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test snapshot trigger
+# requires: set_event snapshot events/ftrace/print/trigger
 # flags: instance
 
 fail() { #msg
@@ -8,26 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f snapshot ]; then
-    echo "snapshot is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 test_trace() {
     file=$1
     x=$2
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
index 18b4d1c2807e..531139f41e94 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram with synthetic event against kernel event
+# requires: set_event synthetic_events events/sched/sched_waking events/ftrace/print/trigger events/ftrace/print/hist
 # flags:
 
 fail() { #msg
@@ -8,36 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic events not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/sched/sched_waking ]; then
-    echo "event sched_waking is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram kernel event to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index dd262d6d0db6..cc99cbb06d5e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: trace_marker trigger - test histogram with synthetic event
+# requires: set_event synthetic_events events/ftrace/print/trigger events/ftrace/print/hist
 # flags:
 
 fail() { #msg
@@ -8,31 +9,6 @@ fail() { #msg
     exit_fail
 }
 
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic events not supported"
-    exit_unsupported
-fi
-
-if [ ! -d events/ftrace/print ]; then
-    echo "event trace_marker is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/ftrace/print/hist ]; then
-    echo "hist trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test histogram trace_marker to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
index d5d2dcbc9cab..9ca04678f4da 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
@@ -1,22 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test traceon/off trigger
+# requires: set_event events/sched/sched_process_fork/trigger
 
 fail() { #msg
     echo $1
     exit_fail
 }
 
-if [ ! -f set_event -o ! -d events/sched ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f events/sched/sched_process_fork/trigger ]; then
-    echo "event trigger is not supported"
-    exit_unsupported
-fi
-
 echo "Test traceoff trigger"
 echo 1 > tracing_on
 echo 'traceoff' > events/sched/sched_process_fork/trigger

