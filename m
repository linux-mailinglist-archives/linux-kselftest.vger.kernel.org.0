Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFAF3F3577
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhHTUsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 16:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhHTUsV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 16:48:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D8C61166;
        Fri, 20 Aug 2021 20:47:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHBQU-004qOf-20; Fri, 20 Aug 2021 16:47:42 -0400
Message-ID: <20210820204741.903838783@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 16:46:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v9 2/6] selftests/ftrace: Add clear_dynamic_events() to test cases
References: <20210820204644.546662591@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a function to remove all dynamic events from the tracing directory. It
requires a loop as some of the dynamic events may depend on others being
removed first. Also add a safety that prevents it from looping infinitely
due to a bug where an event never gets removed.

Link: https://lkml.kernel.org/r/20210819152825.348941368@goodmis.org

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../testing/selftests/ftrace/test.d/functions | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index a6fac927ee82..f68d336b961b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -83,6 +83,27 @@ clear_synthetic_events() { # reset all current synthetic events
     done
 }
 
+clear_dynamic_events() { # reset all current dynamic events
+    again=1
+    stop=1
+    # loop mulitple times as some events require other to be removed first
+    while [ $again -eq 1 ]; do
+	stop=$((stop+1))
+	# Prevent infinite loops
+	if [ $stop -gt 10 ]; then
+	    break;
+	fi
+	again=2
+	grep -v '^#' dynamic_events|
+	while read line; do
+	    del=`echo $line | sed -e 's/^.\([^ ]*\).*/-\1/'`
+	    if ! echo "$del" >> dynamic_events; then
+		again=1
+	    fi
+	done
+    done
+}
+
 initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
@@ -93,6 +114,7 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_events_filter
     reset_ftrace_filter
     disable_events
+    clear_dynamic_events
     [ -f set_event_pid ] && echo > set_event_pid
     [ -f set_ftrace_pid ] && echo > set_ftrace_pid
     [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
-- 
2.30.2
