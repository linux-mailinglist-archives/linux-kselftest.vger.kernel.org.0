Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6932E196F61
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Mar 2020 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgC2SnU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgC2SnU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9977E214DB;
        Sun, 29 Mar 2020 18:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIcty-002G0g-Fv; Sun, 29 Mar 2020 14:43:18 -0400
Message-Id: <20200329184318.379484681@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-next][PATCH 20/21] selftests/ftrace: Add test to test new set_event_notrace_pid file
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A new file was added to the tracing directory that will allow a user to
place a PID into it and the task associated to that PID will not have its
events traced.  If the event-fork option is enabled, then neither will the
children of that task have its events traced.

Cc: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/event/event-no-pid.tc       | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
new file mode 100644
index 000000000000..f0f366f18d0c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -0,0 +1,125 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event tracing - restricts events based on pid notrace filtering
+# flags: instance
+
+do_reset() {
+    echo > set_event
+    echo > set_event_pid
+    echo > set_event_notrace_pid
+    echo 0 > options/event-fork
+    echo 0 > events/enable
+    clear_trace
+    echo 1 > tracing_on
+}
+
+fail() { #msg
+    cat trace
+    do_reset
+    echo $1
+    exit_fail
+}
+
+count_pid() {
+    pid=$@
+    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep $pid | wc -l
+}
+
+count_no_pid() {
+    pid=$1
+    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep -v $pid | wc -l
+}
+
+enable_system() {
+    system=$1
+
+    if [ -d events/$system ]; then
+	echo 1 > events/$system/enable
+    fi
+}
+
+enable_events() {
+    echo 0 > tracing_on
+    # Enable common groups of events, as all events can allow for
+    # events to be traced via scheduling that we don't care to test.
+    enable_system syscalls
+    enable_system rcu
+    enable_system block
+    enable_system exceptions
+    enable_system irq
+    enable_system net
+    enable_system power
+    enable_system signal
+    enable_system sock
+    enable_system timer
+    enable_system thermal
+    echo 1 > tracing_on
+}
+
+if [ ! -f set_event -o ! -d events/sched ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f set_event_pid -o ! -f set_event_notrace_pid ]; then
+    echo "event pid notrace filtering is not supported"
+    exit_unsupported
+fi
+
+echo 0 > options/event-fork
+
+do_reset
+
+read mypid rest < /proc/self/stat
+
+echo $mypid > set_event_notrace_pid
+grep -q $mypid set_event_notrace_pid
+
+enable_events
+
+yield
+
+echo 0 > tracing_on
+
+cnt=`count_pid $mypid`
+if [ $cnt -ne 0 ]; then
+    fail "Filtered out task has events"
+fi
+
+cnt=`count_no_pid $mypid`
+if [ $cnt -eq 0 ]; then
+    fail "No other events were recorded"
+fi
+
+do_reset
+
+echo $mypid > set_event_notrace_pid
+echo 1 > options/event-fork
+
+enable_events
+
+yield &
+child=$!
+echo "child = $child"
+wait $child
+
+echo 0 > tracing_on
+
+cnt=`count_pid $mypid`
+if [ $cnt -ne 0 ]; then
+    fail "Filtered out task has events"
+fi
+
+cnt=`count_pid $child`
+if [ $cnt -ne 0 ]; then
+    fail "Child of filtered out taskhas events"
+fi
+
+cnt=`count_no_pid $mypid`
+if [ $cnt -eq 0 ]; then
+    fail "No other events were recorded"
+fi
+
+do_reset
+
+exit 0
-- 
2.25.1


