Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387EB196F66
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Mar 2020 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgC2Sn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Mar 2020 14:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgC2SnU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7116D2137B;
        Sun, 29 Mar 2020 18:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIcty-002G0A-BU; Sun, 29 Mar 2020 14:43:18 -0400
Message-Id: <20200329184318.239687805@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-next][PATCH 19/21] selftests/ftrace: Add test to test new set_ftrace_notrace_pid file
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A new file was added to the tracing directory that will allow a user to
place a PID into it and the task associated to that PID will not be traced
by the function tracer. If the function-fork option is enabled, then neither
will the children of that task be traced by the function tracer.

Cc: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../test.d/ftrace/func-filter-notrace-pid.tc  | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
new file mode 100644
index 000000000000..8aa46a2ea133
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -0,0 +1,108 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function pid notrace filters
+# flags: instance
+
+# Make sure that function pid matching filter with notrace works.
+
+if ! grep -q function available_tracers; then
+    echo "no function tracer configured"
+    exit_unsupported
+fi
+
+if [ ! -f set_ftrace_notrace_pid ]; then
+    echo "set_ftrace_notrace_pid not found? Is function tracer not set?"
+    exit_unsupported
+fi
+
+if [ ! -f set_ftrace_filter ]; then
+    echo "set_ftrace_filter not found? Is function tracer not set?"
+    exit_unsupported
+fi
+
+do_function_fork=1
+
+if [ ! -f options/function-fork ]; then
+    do_function_fork=0
+    echo "no option for function-fork found. Option will not be tested."
+fi
+
+read PID _ < /proc/self/stat
+
+if [ $do_function_fork -eq 1 ]; then
+    # default value of function-fork option
+    orig_value=`grep function-fork trace_options`
+fi
+
+do_reset() {
+    if [ $do_function_fork -eq 0 ]; then
+	return
+    fi
+
+    echo > set_ftrace_notrace_pid
+    echo $orig_value > trace_options
+}
+
+fail() { # msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+do_test() {
+    disable_tracing
+
+    echo do_execve* > set_ftrace_filter
+    echo *do_fork >> set_ftrace_filter
+
+    echo $PID > set_ftrace_notrace_pid
+    echo function > current_tracer
+
+    if [ $do_function_fork -eq 1 ]; then
+	# don't allow children to be traced
+	echo nofunction-fork > trace_options
+    fi
+
+    enable_tracing
+    yield
+
+    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+
+    # count_pid should be 0
+    if [ $count_pid -ne 0 -o $count_other -eq 0 ]; then
+	fail "PID filtering not working? traced task = $count_pid; other tasks = $count_other "
+    fi
+
+    disable_tracing
+    clear_trace
+
+    if [ $do_function_fork -eq 0 ]; then
+	return
+    fi
+
+    # allow children to be traced
+    echo function-fork > trace_options
+
+    # With pid in both set_ftrace_pid and set_ftrace_notrace_pid
+    # there should not be any tasks traced.
+
+    echo $PID > set_ftrace_pid
+
+    enable_tracing
+    yield
+
+    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+
+    # both should be zero
+    if [ $count_pid -ne 0 -o $count_other -ne 0 ]; then
+	fail "PID filtering not following fork? traced task = $count_pid; other tasks = $count_other "
+    fi
+}
+
+do_test
+
+do_reset
+
+exit 0
-- 
2.25.1


