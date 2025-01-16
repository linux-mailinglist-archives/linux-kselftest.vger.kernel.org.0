Return-Path: <linux-kselftest+bounces-24652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46CA13C5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E295188D671
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C222B8B9;
	Thu, 16 Jan 2025 14:35:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032622B8AB;
	Thu, 16 Jan 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038128; cv=none; b=Y5OyqWOF6/EDe9QY2+uk0KH1DHi9ACc0xDEbC7jsr4i/KYOVkOf+Mb8bucLZEvyyMzwhjQTncHl8whoAbMpTwlv0etQDR0Ms741PWDeFszR6iwaGGouGPACe2xr7ObfWbl0RUzNd1jsZ30SUNR9rmjpNqBX6bImHEO9FtKw5ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038128; c=relaxed/simple;
	bh=9Xk7kEPcKn4EWxPYgvqVx6KfZb68hSs13zANGFl1ZnQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RNcP5js3q1QxVZIYTNOWSLTCfPT9K7IeuQx61x6uxiYaUaaEuuPID8gl1qYQGVII5bRZbqe6aIZxIDJHb17VYiLlep9BSkS9jqwMEArcmFFMK7azopFYBzROqoEuxVOH0flDag6JDvlZgB/vOqy0fsA6anhfxBO5b8P27VeEY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B25C4CED6;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYQy6-00000000szE-0DfY;
	Thu, 16 Jan 2025 09:35:34 -0500
Message-ID: <20250116143533.819228058@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 09:33:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 jochensp@jochen.sprickerhof.de,
 peter.griffin@linaro.org,
 Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/ftrace: Add test that tests event :mod: commands
References: <20250116143334.073917300@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that here's a :mod: command that can be sent into set_event, add a
test that tests its use. Both setting events for a loaded module, as well
as caching what events to set for a module that is not loaded yet.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/event/event-mod.tc          | 192 ++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/event-mod.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-mod.tc b/tools/testing/selftests/ftrace/test.d/event/event-mod.tc
new file mode 100644
index 000000000000..6f7601c4b54b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/event-mod.tc
@@ -0,0 +1,192 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event tracing - enable/disable with module event
+# requires: set_event "Can enable module events via: :mod:":README
+# flags: instance
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved;
+fi
+trap "rmmod trace-events-sample" EXIT
+
+# Set events for the module
+echo ":mod:trace-events-sample" > set_event
+
+test_all_enabled() {
+
+	# Check if more than one is enabled
+	grep -q sample-trace:foo_bar set_event
+	grep -q sample-trace:foo_bar_with_cond set_event
+	grep -q sample-trace:foo_bar_with_fn set_event
+
+	# All of them should be enabled. Check via the enable file
+	val=`cat events/sample-trace/enable`
+	if [ $val -ne 1 ]; then
+		exit_fail
+	fi
+}
+
+clear_events() {
+	echo > set_event
+	val=`cat events/enable`
+	if [ "$val" != "0" ]; then
+		exit_fail
+	fi
+	count=`cat set_event | wc -l`
+	if [ $count -ne 0 ]; then
+		exit_fail
+	fi
+}
+
+test_all_enabled
+
+echo clear all events
+echo 0 > events/enable
+
+echo Confirm the events are disabled
+val=`cat events/sample-trace/enable`
+if [ $val -ne 0 ]; then
+	exit_fail
+fi
+
+echo And the set_event file is empty
+
+cnt=`wc -l set_event`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
+echo now enable all events
+echo 1 > events/enable
+
+echo Confirm the events are enabled again
+val=`cat events/sample-trace/enable`
+if [ $val -ne 1 ]; then
+	exit_fail
+fi
+
+echo disable just the module events
+echo '!:mod:trace-events-sample' >> set_event
+
+echo Should have mix of events enabled
+val=`cat events/enable`
+if [ "$val" != "X" ]; then
+	exit_fail
+fi
+
+echo Confirm the module events are disabled
+val=`cat events/sample-trace/enable`
+if [ $val -ne 0 ]; then
+	exit_fail
+fi
+
+echo 0 > events/enable
+
+echo now enable the system events
+echo 'sample-trace:mod:trace-events-sample' > set_event
+
+test_all_enabled
+
+echo clear all events
+echo 0 > events/enable
+
+echo Confirm the events are disabled
+val=`cat events/sample-trace/enable`
+if [ $val -ne 0 ]; then
+	exit_fail
+fi
+
+echo Test enabling foo_bar only
+echo 'foo_bar:mod:trace-events-sample' > set_event
+
+grep -q sample-trace:foo_bar set_event
+
+echo make sure nothing is found besides foo_bar
+if grep -q -v sample-trace:foo_bar set_event ; then
+	exit_fail
+fi
+
+echo Append another using the system and event name
+echo 'sample-trace:foo_bar_with_cond:mod:trace-events-sample' >> set_event
+
+grep -q sample-trace:foo_bar set_event
+grep -q sample-trace:foo_bar_with_cond set_event
+
+count=`cat set_event | wc -l`
+
+if [ $count -ne 2 ]; then
+	exit_fail
+fi
+
+clear_events
+
+rmmod trace-events-sample
+
+echo ':mod:trace-events-sample' > set_event
+
+echo make sure that the module shows up, and '-' is converted to '_'
+grep -q '\*:\*:mod:trace_events_sample' set_event
+
+modprobe trace-events-sample
+
+test_all_enabled
+
+clear_events
+
+rmmod trace-events-sample
+
+echo Enable just the system events
+echo 'sample-trace:mod:trace-events-sample' > set_event
+grep -q 'sample-trace:mod:trace_events_sample' set_event
+
+modprobe trace-events-sample
+
+test_all_enabled
+
+clear_events
+
+rmmod trace-events-sample
+
+echo Enable event with just event name
+echo 'foo_bar:mod:trace-events-sample' > set_event
+grep -q 'foo_bar:mod:trace_events_sample' set_event
+
+echo Enable another event with both system and event name
+echo 'sample-trace:foo_bar_with_cond:mod:trace-events-sample' >> set_event
+grep -q 'sample-trace:foo_bar_with_cond:mod:trace_events_sample' set_event
+echo Make sure the other event was still there
+grep -q 'foo_bar:mod:trace_events_sample' set_event
+
+modprobe trace-events-sample
+
+echo There should be no :mod: cached events
+if grep -q ':mod:' set_event; then
+	exit_fail
+fi
+
+echo two events should be enabled
+count=`cat set_event | wc -l`
+if [ $count -ne 2 ]; then
+	exit_fail
+fi
+
+echo only two events should be enabled
+val=`cat events/sample-trace/enable`
+if [ "$val" != "X" ]; then
+	exit_fail
+fi
+
+val=`cat events/sample-trace/foo_bar/enable`
+if [ "$val" != "1" ]; then
+	exit_fail
+fi
+
+val=`cat events/sample-trace/foo_bar_with_cond/enable`
+if [ "$val" != "1" ]; then
+	exit_fail
+fi
+
+clear_trace
+
-- 
2.45.2



