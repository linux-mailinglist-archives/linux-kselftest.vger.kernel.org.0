Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA03F3B02
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhHUOaw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Aug 2021 10:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhHUOaw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Aug 2021 10:30:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98B061266;
        Sat, 21 Aug 2021 14:30:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHS0h-004wpC-Om; Sat, 21 Aug 2021 10:30:11 -0400
Message-ID: <20210821143011.599117217@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 21 Aug 2021 10:29:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 5/6] selftests/ftrace: Add selftest for testing eprobe events on synthetic
 events
References: <20210821142904.655644298@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test to test event probes, by creating a synthetic event across
sys_enter_openat and sys_exit_openat that passes the filename pointer from
the enter of the system call to the exit, and then add an event probe to
the synthetic event to make sure that the file name is seen.

Link: https://lore.kernel.org/linux-kselftest/20210819152825.526931866@goodmis.org/
Link: https://lkml.kernel.org/r/20210820204742.463259900@goodmis.org

Cc: "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../inter-event/trigger-synthetic-eprobe.tc   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
new file mode 100644
index 000000000000..914fe2e5d030
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger eprobe on synthetic event
+# requires: dynamic_events synthetic_events events/syscalls/sys_enter_openat/hist "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+
+echo 0 > events/enable
+
+clear_dynamic_events
+
+SYSTEM="syscalls"
+START="sys_enter_openat"
+END="sys_exit_openat"
+FIELD="filename"
+SYNTH="synth_open"
+EPROBE="eprobe_open"
+
+echo "$SYNTH u64 filename; s64 ret;" > synthetic_events
+echo "hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
+echo "hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
+
+echo "e:$EPROBE synthetic/$SYNTH file=+0(\$filename):ustring ret=\$ret:s64" >> dynamic_events
+
+grep -q "$SYNTH" dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/synthetic/$SYNTH
+test -d events/eprobes/$EPROBE
+
+echo 1 > events/eprobes/$EPROBE/enable
+ls
+echo 0 > events/eprobes/$EPROBE/enable
+
+content=`grep '^ *ls-' trace | grep 'file='`
+nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."'` || true
+
+if [ -z "$content" ]; then
+	exit_fail
+fi
+
+if [ ! -z "$nocontent" ]; then
+	exit_fail
+fi
+
+echo "-:$EPROBE" >> dynamic_events
+echo '!'"hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
+echo '!'"hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
+echo '!'"$SYNTH u64 filename; s64 ret;" >> synthetic_events
+
+! grep -q "$SYNTH" dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/synthetic/$SYNTH
+! test -d events/eprobes/$EPROBE
+
+clear_trace
-- 
2.30.2
