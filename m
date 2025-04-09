Return-Path: <linux-kselftest+bounces-30439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09651A82A63
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D44416E02A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01752676CB;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B042673B7;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212360; cv=none; b=czM5XsnIe7g6O7P4zbmSpXpuBue9WdCEgdfCqSGz4NbN+oCJrTec5EpghhOHg+J7UMH1tbhOkxZcemJ9G/seOWLIrRmh5ygeQMOoPexBBXbWwEdT6Ms38zmGvDYxJ4h0a4VGhx7L3+G4PIa1w21D0XEgK3WBu2HaKDfC0ym31QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212360; c=relaxed/simple;
	bh=FLXkb/GHsHQdvXLgkljGBSUeoixp2fv24xJ28bkaTeY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DvKMvZJbzofWNSKsCvMvmqbjEYNkJPkhs5H2JVSGDM02rLY6TuSxLnSoK1sTcf8gvNwxnlc0EbNwSoodHCttavpGCAdiuxBQXwLq0b13UNAh9fu7OWQZuvRKffs71A1DGJlFkNmPwiTJ+G7UfFKAZkTCiiwo6L3ENQybHHKs++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583A0C4CEE9;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u2XKi-00000008kRa-2EMv;
	Wed, 09 Apr 2025 11:27:20 -0400
Message-ID: <20250409152720.380778379@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Apr 2025 11:15:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org,
 Andy Chiu <andybnac@gmail.com>
Subject: [PATCH 2/2] tracing/selftest: Add test to better test subops filtering of
 function graph
References: <20250409151549.788068911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A bug was discovered that showed the accounting of the subops of the
ftrace_ops filtering was incorrect. Add a new test to better test the
filtering.

This test creates two instances, where it will add various filters to both
the set_ftrace_filter and the set_ftrace_notrace files and enable
function_graph. Then it looks into the enabled_functions file to make sure
that the filters are behaving correctly.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/ftrace/fgraph-multi-filter.tc      | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi-filter.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi-filter.tc
new file mode 100644
index 000000000000..b6d6a312ead5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi-filter.tc
@@ -0,0 +1,177 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function graph filters
+# requires: set_ftrace_filter function_graph:tracer
+
+# Make sure that function graph filtering works
+
+INSTANCE1="instances/test1_$$"
+INSTANCE2="instances/test2_$$"
+
+WD=`pwd`
+
+do_reset() {
+    cd $WD
+    if [ -d $INSTANCE1 ]; then
+	echo nop > $INSTANCE1/current_tracer
+	rmdir $INSTANCE1
+    fi
+    if [ -d $INSTANCE2 ]; then
+	echo nop > $INSTANCE2/current_tracer
+	rmdir $INSTANCE2
+    fi
+}
+
+mkdir $INSTANCE1
+if ! grep -q function_graph $INSTANCE1/available_tracers; then
+    echo "function_graph not allowed with instances"
+    rmdir $INSTANCE1
+    exit_unsupported
+fi
+
+mkdir $INSTANCE2
+
+fail() { # msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+disable_tracing
+clear_trace
+
+function_count() {
+    search=$1
+    vsearch=$2
+
+    if [ -z "$search" ]; then
+	cat enabled_functions | wc -l
+    elif [ -z "$vsearch" ]; then
+	grep $search enabled_functions | wc -l
+    else
+	grep $search enabled_functions | grep $vsearch| wc -l
+    fi
+}
+
+set_fgraph() {
+    instance=$1
+    filter="$2"
+    notrace="$3"
+
+    echo "$filter" > $instance/set_ftrace_filter
+    echo "$notrace" > $instance/set_ftrace_notrace
+    echo function_graph > $instance/current_tracer
+}
+
+check_functions() {
+    orig_cnt=$1
+    test=$2
+
+    cnt=`function_count $test`
+    if [ $cnt -gt $orig_cnt ]; then
+	fail
+    fi
+}
+
+check_cnt() {
+    orig_cnt=$1
+    search=$2
+    vsearch=$3
+
+    cnt=`function_count $search $vsearch`
+    if [ $cnt -gt $orig_cnt ]; then
+	fail
+    fi
+}
+
+reset_graph() {
+    instance=$1
+    echo nop > $instance/current_tracer
+}
+
+# get any functions that were enabled before the test
+total_cnt=`function_count`
+sched_cnt=`function_count sched`
+lock_cnt=`function_count lock`
+time_cnt=`function_count time`
+clock_cnt=`function_count clock`
+locks_clock_cnt=`function_count locks clock`
+clock_locks_cnt=`function_count clock locks`
+
+# Trace functions with "sched" but not "time"
+set_fgraph $INSTANCE1 '*sched*' '*time*'
+
+# Make sure "time" isn't listed
+check_functions $time_cnt 'time'
+instance1_cnt=`function_count`
+
+# Trace functions with "lock" but not "clock"
+set_fgraph $INSTANCE2 '*lock*' '*clock*'
+instance1_2_cnt=`function_count`
+
+# Turn off the first instance
+reset_graph $INSTANCE1
+
+# The second instance doesn't trace "clock" functions
+check_functions $clock_cnt 'clock'
+instance2_cnt=`function_count`
+
+# Start from a clean slate
+reset_graph $INSTANCE2
+check_functions $total_cnt
+
+# Trace functions with "lock" but not "clock"
+set_fgraph $INSTANCE2 '*lock*' '*clock*'
+
+# This should match the last time instance 2 was by itself
+cnt=`function_count`
+if [ $instance2_cnt -ne $cnt ]; then
+    fail
+fi
+
+# And it should not be tracing "clock" functions
+check_functions $clock_cnt 'clock'
+
+# Trace functions with "sched" but not "time"
+set_fgraph $INSTANCE1 '*sched*' '*time*'
+
+# This should match the last time both instances were enabled
+cnt=`function_count`
+if [ $instance1_2_cnt -ne $cnt ]; then
+    fail
+fi
+
+# Turn off the second instance
+reset_graph $INSTANCE2
+
+# This should match the last time instance 1 was by itself
+cnt=`function_count`
+if [ $instance1_cnt -ne $cnt ]; then
+    fail
+fi
+
+# And it should not be tracing "time" functions
+check_functions $time_cnt 'time'
+
+# Start from a clean slate
+reset_graph $INSTANCE1
+check_functions $total_cnt
+
+# Enable all functions but those that have "locks"
+set_fgraph $INSTANCE1 '' '*locks*'
+
+# Enable all functions but those that have "clock"
+set_fgraph $INSTANCE2 '' '*clock*'
+
+# If a function has "locks" it should not have "clock"
+check_cnt $locks_clock_cnt locks clock
+
+# If a function has "clock" it should not have "locks"
+check_cnt $clock_locks_cnt clock locks
+
+reset_graph $INSTANCE1
+reset_graph $INSTANCE2
+
+do_reset
+
+exit 0
-- 
2.47.2



